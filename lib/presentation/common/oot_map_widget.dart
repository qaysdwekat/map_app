import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/core/utils/logs.dart';

import '../../core/utils/image_tools.dart';
import '../../domain/models/location_info_model.dart';
import 'oot_marker.dart';

class OOTMapWidget extends StatefulWidget {
  final CameraPosition initialPosition;
  final void Function(LatLng)? onTap;
  final LocationInfoModel? marker;
  final void Function(GoogleMapController)? onMapCreated;
  void Function(LocationInfoModel?, bool?)? executeAfterWholeBuildProcess;

  OOTMapWidget({
    super.key,
    required this.initialPosition,
    this.onTap,
    this.marker,
    this.onMapCreated,
    this.executeAfterWholeBuildProcess,
  });
  final state = _OOTMapState();
  @override
  State<StatefulWidget> createState() => state;

  bool get isMarkerAdded => state.validateMarkerAdded();

  List<Marker> get markers => state.markers;
}

class _OOTMapState extends State<OOTMapWidget> {
  late GoogleMapController mapController;
  List<Marker> markers = [];
  bool isMarkerAdded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.marker != null && !isMarkerAdded) {
      buildMarker(widget.marker?.formattedAddress).then((icon) {
        markers = [
          Marker(
            markerId: const MarkerId('selected'),
            position: widget.marker!.location!,
            icon: icon,
          )
        ];
        setState(() {
          isMarkerAdded = true;
        });
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isMarkerAdded = true;
      markers = [
        Marker(
          markerId: MarkerId(widget.marker!.placeId!),
          position: widget.marker!.location!,
        )
      ];
      
      validateMarkerAdded();
    });

    return GoogleMap(
      initialCameraPosition: widget.initialPosition,
      onMapCreated: (GoogleMapController controller) {
        widget.onMapCreated?.call(controller);
        mapController = controller;
      },
      onCameraMoveStarted: () {},
      onCameraMove: (position) {},
      onCameraIdle: () {},
      onTap: (position) {
        isMarkerAdded = false;
        widget.onTap?.call(position);
      },
      markers: Set<Marker>.from(markers),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
    );
  }

  Future<BitmapDescriptor> buildMarker(String? title) async {
    const size = Size(120, 80);
    final markerWithInfo = await ImageTools.createImageFromWidget(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
          width: size.width,
          height: size.height,
          child: CustomPaint(
            size: size,
            painter: OOTMarker(
              borderColor: Colors.red,
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              child: Center(
                child: Text(
                  title ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ),
        size: size);
    if (markerWithInfo != null) {
      return BitmapDescriptor.fromBytes(markerWithInfo);
    }
    return BitmapDescriptor.defaultMarker;
  }

  bool validateMarkerAdded() {
    return isMarkerAdded;
  }
}
