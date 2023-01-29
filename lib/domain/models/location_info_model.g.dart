// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationInfoModel _$LocationInfoModelFromJson(Map<String, dynamic> json) =>
    LocationInfoModel()
      ..formattedAddress =
          LocationInfoModel._readValueFromJson(json, 'formatted_address')
              as String?
      ..placeId =
          LocationInfoModel._readValueFromJson(json, 'place_id') as String?
      ..location = LocationInfoModel._readFromJson(
          LocationInfoModel._readValueFromJson(json, 'geometry'));

Map<String, dynamic> _$LocationInfoModelToJson(LocationInfoModel instance) =>
    <String, dynamic>{
      'formatted_address': instance.formattedAddress,
      'place_id': instance.placeId,
      'geometry': instance.location,
    };
