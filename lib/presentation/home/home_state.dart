import 'package:equatable/equatable.dart';

import '../../domain/models/location_info_model.dart';

// ignore: must_be_immutable
class HomeState extends Equatable {
  LocationInfoModel? locationInfo;

  HomeState();
  factory HomeState.init() => HomeState();

  @override
  List<Object?> get props => [locationInfo];

  HomeState copyWith({
    LocationInfoModel? locationInfo,
  }) =>
      HomeState()..locationInfo = locationInfo ?? this.locationInfo;
}
