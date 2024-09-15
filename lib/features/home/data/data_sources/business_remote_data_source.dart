import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/home/data/models/index.dart';

abstract interface class BusinessRemoteDataSource {
  Future<BusinessListResponseModel> getHomeBusinessList({
    int? categoryId,
    String? businessName,
    String? previous,
    String? next,
  });
  Future<BusinessCategoryListResponseModel> getHomeBusinessCategoryList({
    String? previous,
    String? next,
  });
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<BusinessListResponseModel> getHomeBusinessList({
    int? categoryId,
    String? businessName,
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/businesses/';

    if (businessName != null && businessName.isNotEmpty) {
      url += '?business_name=$businessName';
    }

    if (categoryId != null) {
      url += '?category_id=$categoryId';
    }

    if (businessName != null && businessName.isNotEmpty && categoryId != null) {
      url += '?category_id=$categoryId&business_name=$businessName';
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

  @override
  Future<BusinessCategoryListResponseModel> getHomeBusinessCategoryList({
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/business-categories/?limit=50';

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return BusinessCategoryListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
