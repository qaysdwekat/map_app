import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_info_model.g.dart';

@JsonSerializable()
class LocationInfoModel extends Equatable {
  @JsonKey(name: 'formatted_address', readValue: _readValueFromJson)
  String? formattedAddress;

  @JsonKey(name: 'place_id', readValue: _readValueFromJson)
  String? placeId;

  @JsonKey(name: 'geometry', fromJson: _readFromJson, readValue: _readValueFromJson)
  LatLng? location;

  static dynamic _readValueFromJson(dynamic json, String key) {
    try {
      return json['results'][0][key];
    } catch (_) {}
    return null;
  }

  static LatLng? _readFromJson(dynamic json) {
    try {
      return LatLng(json['location']['lat'], json['location']['lng']);
    } catch (_) {}
    return null;
  }

  LocationInfoModel();

  @override
  List<Object?> get props => [
        formattedAddress,
        placeId,
        location,
      ];

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) => _$LocationInfoModelFromJson(
        json,
      );
}
