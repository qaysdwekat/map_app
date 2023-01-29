import 'package:dartz/dartz.dart';

import '../common_models/failure.dart';

abstract class BaseUsecase extends Object {
  /// A representation of the runtime type of the object.
  @override
  external Type get runtimeType;
}

typedef UsecaseValue<T> = Either<Failure, T>;
