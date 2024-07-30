import 'package:dartz/dartz.dart';

import '../utils/api_service.dart';

typedef NoParam = void;

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call([Param param]);
}
