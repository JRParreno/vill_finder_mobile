import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

abstract interface class BusinessMapRemoteDataSource {
  Future<BusinessListResponseEntity> getBusinessMapList({
    required double minLongitude,
    required double maxLongitude,
    required double minLatitude,
    required double maxLatitude,
    String? businessName,
    String? previous,
    String? next,
  });
}

class BusinessMapRemoteDataSourceImpl implements BusinessMapRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<BusinessListResponseEntity> getBusinessMapList({
    required double minLongitude,
    required double maxLongitude,
    required double minLatitude,
    required double maxLatitude,
    String? businessName,
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/businesses/?'
        'min_latitude=$minLatitude&max_latitude=$maxLatitude'
        '&min_longitude=$minLongitude&max_longitude=$maxLongitude';

    if (businessName != null && businessName.isNotEmpty) {
      url += '&business_name=$businessName';
    }

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return BusinessListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
