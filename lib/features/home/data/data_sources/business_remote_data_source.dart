import 'package:dio/dio.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/exceptions.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/home/data/models/index.dart';

abstract interface class BusinessRemoteDataSource {
  Future<RentalListResponseModel> getHomeRentalList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
    bool? isFeatured,
  });
  Future<FoodEstablishmentListResponseModel> getHomeFoodList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
  });
  Future<BusinessCategoryListResponseModel> getHomeBusinessCategoryList({
    String? previous,
    String? next,
    String? name,
  });
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<FoodEstablishmentListResponseModel> getHomeFoodList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
  }) async {
    String url = '$baseUrl/api/places/food/';

    if (name != null &&
        name.isNotEmpty &&
        categoryId != null &&
        categoryId > -1) {
      url += '?category_id=$categoryId&search=$name';
    } else {
      if (name != null && name.isNotEmpty) {
        url += '?search=$name';
      }

      if (categoryId != null && categoryId > -1) {
        url += '?category_id=$categoryId';
      }
    }

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return FoodEstablishmentListResponseModel.fromMap(response.data);
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<RentalListResponseModel> getHomeRentalList({
    int? categoryId,
    String? name,
    String? previous,
    String? next,
    bool? isFeatured,
  }) async {
    String url = '$baseUrl/api/places/rental/';

    if (name != null &&
        name.isNotEmpty &&
        categoryId != null &&
        categoryId > -1 &&
        isFeatured != null) {
      url += '?category_id=$categoryId&q=$name&isFeatured=$isFeatured';
    } else {
      if (name != null && name.isNotEmpty) {
        url += '?q=$name';
      }

      if (categoryId != null && categoryId > -1) {
        url += '?category_id=$categoryId';
      }

      if (isFeatured != null) {
        url += '?is_featured=$isFeatured';
      }
    }

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return RentalListResponseModel.fromMap(response.data);
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
    String? name,
  }) async {
    String url = '$baseUrl/api/categories/?limit=50';

    if (name != null) {
      url += 'q=$name';
    }

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
