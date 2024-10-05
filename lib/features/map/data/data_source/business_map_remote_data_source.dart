import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/map/data/models/search_map_response_model.dart';

abstract interface class BusinessMapRemoteDataSource {
  Future<SearchMapResponseModel> getBusinessMapList({
    required double minLongitude,
    required double maxLongitude,
    required double minLatitude,
    required double maxLatitude,
    String? name,
    String? previous,
    String? next,
  });
}

class BusinessMapRemoteDataSourceImpl implements BusinessMapRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<SearchMapResponseModel> getBusinessMapList({
    required double minLongitude,
    required double maxLongitude,
    required double minLatitude,
    required double maxLatitude,
    String? name,
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/places/search/?'
        'min_latitude=$minLatitude&max_latitude=$maxLatitude'
        '&min_longitude=$minLongitude&max_longitude=$maxLongitude';

    if (name != null && name.isNotEmpty) {
      url += '&q=$name';
    }

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return SearchMapResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
