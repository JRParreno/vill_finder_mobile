import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/home/data/models/index.dart';

abstract interface class FavoriteRemoteDataSource {
  Future<RentalListResponseModel> getFavorites({
    String? next,
    String? previous,
  });
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<RentalListResponseModel> getFavorites({
    String? next,
    String? previous,
  }) async {
    String url = '$baseUrl/api/places/rental/favorites/';

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return RentalListResponseModel.fromMap(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
