import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/home/data/models/index.dart';

abstract interface class FoodRemoteDataSource {
  Future<FoodEstablishmentModel> getFoodEstablishment(int id);
}

class FoodRemoteDataSourceImpl implements FoodRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<FoodEstablishmentModel> getFoodEstablishment(int id) async {
    final url = '$baseUrl/api/places/food/detail/$id';

    try {
      final response = await apiInstance.get(url);
      return FoodEstablishmentModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
