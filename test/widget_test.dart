// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:map_app/core/utils/logs.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/domain/models/location_info_model.dart';
import 'package:map_app/presentation/common/oot_map_widget.dart';

void main() {
  testWidgets('Add marker to map test', (WidgetTester tester) async {
    CameraPosition initialPosition = const CameraPosition(
      target: LatLng(43.658275, -79.398181),
      zoom: 14,
    );

    // final selectMarker = LocationInfoModel()
    //   ..formattedAddress = 'College St / Huron St, Toronto, ON M5T 1R5, Canada'
    //   ..placeId = 'ChIJ2XKl28A0K4gRLOW3FMSaRIE'
    //   ..location = const LatLng(43.658148, -79.398167);

    final selectMarker = LocationInfoModel()
      ..formattedAddress = 'Qays'
      ..placeId = 'Sadam'
      ..location = const LatLng(-1, -1);

    final mapWidget = OOTMapWidget(
      initialPosition: initialPosition,
      marker: selectMarker,
    );

    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: mapWidget,
    ));

    await tester.pump();

    final isMarked = mapWidget.isMarkerAdded;

    final markers = mapWidget.markers;
    expect(isMarked, true);
    expect(markers.first.markerId.value, selectMarker.placeId);
  });
}
