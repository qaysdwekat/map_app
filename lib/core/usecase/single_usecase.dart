import 'base_usecase.dart';

abstract class SingleUsecase<M> extends BaseUsecase {
  Future<UsecaseValue<M?>> call();
}
