import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common_models/failure.dart';
import '../events/base_event.dart';
import './states/general_state.dart';
import '../usecase/base_usecase.dart';
import '../usecase/single_usecase.dart';
import '../usecase/single_usecase_with_parameter.dart';

class BaseBloc<T extends Equatable> extends Bloc<IBaseEvent, GeneralState<T>> {
  BaseBloc(GeneralState<T> initialState) : super(initialState) {
    on<InitialEvent>((event, emit) => renderEventToState(event, emit));
  }

  void renderEventToState(IBaseEvent event, Emitter<IGeneralState> emit) {
    try {
      emit(handleLoadingState(event, event.data));

      GeneralState<T> newState = handleSuccessState(event, event.data);

      emit(newState);
    } catch (e) {
      if (e is Failure) {
        emit(handleErrorState(event, e.key));
      } else {
        emit(handleErrorState(event, e.toString()));
      }
    }
  }

  void mapEventToState(BaseUsecase useCase, IBaseEvent event, Emitter<IGeneralState> emit) async {
    try {
      emit(handleLoadingState(event, event.data));
      GeneralState<T> newState;
      if (useCase is SingleUsecaseWithParameter) {
        final response = await useCase.call(event.data);
        newState = _eitherLoadedOrErrorState(
          event,
          response,
        );
      } else if (useCase is SingleUsecase) {
        final response = await useCase.call();
        newState = _eitherLoadedOrErrorState(
          event,
          response,
        );
      }
      //TODO:- this should be removed
      else {
        newState = handleSuccessState(event, event.data);
      }
      emit(newState);//591371
    } catch (e) {
      if (e is Failure) {
        emit(handleErrorState(event, e.key));
      } else {
        emit(handleErrorState(event, e.toString()));
      }
    }
  }

  GeneralState<T> _eitherLoadedOrErrorState(
    IBaseEvent event,
    UsecaseValue<dynamic>? failureOrSuccess,
  ) {
    return failureOrSuccess!.fold(
      (failure) => handleErrorState(event, failure.key),
      (data) => handleSuccessState(event, data),
    );
  }

  GeneralState<T> handleLoadingState(IBaseEvent event, dynamic data) {
    return state.copyWithLoading(type: event.runtimeType);
  }

  GeneralState<T> handleSuccessState(IBaseEvent event, dynamic data) {
    if (event.runtimeType == InitialEvent) {
      GeneralState<T> newState = state;
      newState = newState.copyWithSuccess(type: event.runtimeType);
      return newState;
    }
    throw UnimplementedError();
  }

  GeneralState<T> handleErrorState(IBaseEvent event, String? failure) {
    GeneralState<T> newState = state;
    newState = newState.copyWithException(type: event.runtimeType, exception: failure);
    return newState;
  }
}
