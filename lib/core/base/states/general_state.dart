import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

import '../../events/base_event.dart';

@immutable
abstract class IGeneralState extends Equatable {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class GeneralState<T extends Equatable> extends IGeneralState {
  final Type type;
  bool isLoading;
  bool isSuccess;
  bool isException;
  String? exception;
  T data;
  GeneralState({
    required this.type,
    required this.data,
    this.isException = false,
    this.isLoading = false,
    this.isSuccess = false,
    this.exception = '', // Add defualt message
  });

  GeneralState<T> copyWithSuccess({
    T? data,
    Type? type,
  }) =>
      GeneralState(
        data: data ?? this.data,
        type: type ?? this.type,
        isLoading: false,
        isSuccess: true,
        isException: false,
        exception: null,
      );

  GeneralState<T> copyWithException({
    String? exception,
    Type? type,
  }) =>
      GeneralState(
        data: data,
        type: type ?? this.type,
        isLoading: false,
        isSuccess: false,
        isException: true,
        exception: exception,
      );

  GeneralState<T> copyWithLoading({
    T? data,
    Type? type,
  }) =>
      GeneralState(
        data: data ?? this.data,
        type: type ?? this.type,
        isLoading: true,
        isSuccess: false,
        isException: false,
        exception: null,
      );

  @override
  List<Object> get props => [
        type,
        data,
        isException,
        isLoading,
        isSuccess,
      ];
}

// ignore: must_be_immutable
class Initial<T extends Equatable> extends GeneralState<T> {
  Initial(data) : super(type: InitialEvent, data: data);
}

class Success extends IGeneralState {
  Success({required this.type, required this.data});

  factory Success.init() => Success(type: InitialEvent, data: null);
  final Type type;
  final dynamic data;

  @override
  List<Object> get props => [type, data];
}
