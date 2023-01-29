import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String key;

  const Failure(this.key);

  @override
  List<Object> get props => [key];
}
