import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/core/events/base_event.dart';

import '../../core/base/base_bloc.dart';
import '../../core/base/states/general_state.dart';
import '../../domain/usecase/get_location_info_usecase.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc(
    GetLocationInfoUsecase getLocationInfoUsecase,
  ) : super(Initial<HomeState>(HomeState.init())) {
    on<GetLocationInfoEvent>(
      (event, emit) => mapEventToState(getLocationInfoUsecase, event, emit),
    );
  }

  @override
  GeneralState<HomeState> handleSuccessState(IBaseEvent event, data) {
    HomeState newData = state.data;
    if (event is GetLocationInfoEvent) {
      newData = newData.copyWith(
        locationInfo: data,
      );
    }
    return state.copyWithSuccess(type: event.runtimeType, data: newData);
  }
}

class GetLocationInfoEvent extends IBaseEvent {
  LatLng position;
  GetLocationInfoEvent(this.position) : super(position);
}
