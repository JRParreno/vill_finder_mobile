import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/home/data/models/index.dart';

abstract interface class RentalRemoteDataSource {
  Future<RentalModel> getRental(int id);
  Future<RentalModel> setFavoriteRental({
    required int id,
    bool isFavorite = false,
  });
}

class RentalRemoteDataSourceImpl implements RentalRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<RentalModel> getRental(int id) async {
    final url = '$baseUrl/api/places/rental/detail/$id';

    try {
      final response = await apiInstance.get(url);
      return RentalModel.fromMap(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<RentalModel> setFavoriteRental({
    required int id,
    bool isFavorite = false,
  }) async {
    final url = '$baseUrl/api/places/rental/detail/$id';

    final data = {"favorite": isFavorite};

    try {
      final response = await apiInstance.patch(url, data: data);
      return RentalModel.fromMap(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
