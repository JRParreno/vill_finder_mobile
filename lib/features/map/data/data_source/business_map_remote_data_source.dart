import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/map/data/models/search_map_response_model.dart';

abstract interface class BusinessMapRemoteDataSource {
  Future<SearchMapResponseModel> getBusinessMapList({
    double? longitude,
    double? latitude,
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
    double? longitude,
    double? latitude,
    String? name,
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/places/search/';

    if (name != null && latitude != null && longitude != null) {
      url += '?q=$name&latitude=$latitude&longitude=$longitude';
    } else {
      if (name != null) {
        url += '?q=$name';
      } else {
        if (latitude != null && longitude != null) {
          url += '?latitude=$latitude&longitude=$longitude';
        }
      }
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
