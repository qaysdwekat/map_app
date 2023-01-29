import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/core/base/base_stateless_widget.dart';
import 'package:map_app/core/base/states/general_state.dart';
import 'package:map_app/presentation/home/home_bloc.dart';

import '../common/oot_map_widget.dart';
import '../common/ott_image.dart';
import 'home_state.dart';

class HomeScreen extends BaseStatelessWidget<HomeState, HomeBloc> {
  CameraPosition initialPosition = const CameraPosition(target: LatLng(43.658275, -79.398181), zoom: 14);

  late GoogleMapController mapController;
  List<Marker> markers = [];

  HomeScreen({super.key});

  @override
  AppBar? buildAppBar(BuildContext context, GeneralState<HomeState> s) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const OOTImage(
        imageUrl: 'assets/images/oot_logo.svg',
        height: 35,
      ),
    );
  }

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  Color get backgroundColor => Theme.of(context).backgroundColor;

  @override
  Widget buildScreen(BuildContext context, GeneralState<HomeState> state) {
    return OOTMapWidget(
      initialPosition: initialPosition,
      onTap: (position) async {
        broadcastEvent(GetLocationInfoEvent(position));
      },
      marker: state.data.locationInfo,
    );
  }
}
