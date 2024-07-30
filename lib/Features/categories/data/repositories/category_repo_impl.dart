// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
//
// import '../../../../core/utils/api_service.dart';
// import '../../domain/entities/category_entity.dart';
// import '../../domain/repositories/categotry_repo.dart';
// import '../data_sources/category_repo_data_source.dart';
//
// class CategoryRepoImpl extends CategoryRepo {
//   final CategoryDataSource categoryDataSource;
//
//   CategoryRepoImpl({required this.categoryDataSource});
//
//   @override
//   Future<Either<Failure, List<ServiceEntity>>> getCategories() async {
//     try {
//       final category = await categoryDataSource.getCategories();
//       return Right(category);
//     } catch (e) {
//       if (e is DioException) {
//         return Left(ServerFailure.fromDioError(e));
//       } else {
//         return Left(GeneralError());
//       }
//     }
//   }
// }
// class CategoryRepoImpl extends CategoryRepo {
//   final CategoryDataSource categoryDataSource;
//
//   CategoryRepoImpl({required this.categoryDataSource});
//
//   @override
//   Future<Either<Failure, List<ServiceEntity>>> getCategories() async {
//     try {
//       final category = await categoryDataSource.getca();
//       return Right(category);
//     } catch (e) {
//       if (e is DioException) {
//         return Left(ServerFailure.fromDioError(e));
//       } else {
//         return Left(GeneralError());
//       }
//     }
//   }
// }
