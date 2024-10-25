import 'package:atomic_habits/core/errors/failures.dart';
import 'package:atomic_habits/core/helpers/functional_types.dart';

abstract class UseCase<R, P> {
  const UseCase();

  FunctionalFuture<Failure, R> call(P params);
}

class NoParams {}
