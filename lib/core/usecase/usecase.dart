import 'package:fpdart/fpdart.dart';
import 'package:vill_finder/core/error/failure.dart';

abstract interface class UseCase<SuccessfulType, Params> {
  Future<Either<Failure, SuccessfulType>> call(Params params);
}

class NoParams {}

class PaginationParams {
  final String? next;
  final String? previous;

  PaginationParams({this.next, this.previous});
}
