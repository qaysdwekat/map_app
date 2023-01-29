import 'base_usecase.dart';
abstract class SingleUsecaseWithParameter<M, P> extends BaseUsecase {
  Future<UsecaseValue<M>> call(P data);
}
