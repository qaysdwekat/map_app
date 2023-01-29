// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class IBaseEvent extends Equatable {
  final dynamic data;

  const IBaseEvent(this.data);

  @override
  List<Object> get props => [data];
}

class InitialEvent extends IBaseEvent {
  const InitialEvent() : super(null);
}
