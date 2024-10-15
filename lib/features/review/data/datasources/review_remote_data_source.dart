import 'package:dio/dio.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/core/env/env.dart';
import 'package:vill_finder/core/error/failure.dart';
import 'package:vill_finder/core/interceptor/api_interceptor.dart';
import 'package:vill_finder/features/review/data/models/index.dart';

abstract interface class ReviewRemoteDataSource {
  Future<ReviewListResponseModel> getReviewList({
    required int placeId,
    required ReviewType reviewType,
    String? previous,
    String? next,
  });
  Future<ReviewModel> addReview({
    required int objectId,
    required ReviewType reviewType,
    required int stars,
    required String comments,
  });
  Future<ReviewModel> updateReview({
    required int id,
    required ReviewType reviewType,
    required int stars,
    required String comments,
  });
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final apiInstance = ApiInterceptor.apiInstance();
  final baseUrl = Env.apiURL;

  @override
  Future<ReviewListResponseModel> getReviewList({
    required int placeId,
    required ReviewType reviewType,
    String? previous,
    String? next,
  }) async {
    String url =
        '$baseUrl/api/reviews/?content_type=${reviewType.name}&object_id=$placeId';

    try {
      final response = await apiInstance.get(next ?? previous ?? url);
      return ReviewListResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<ReviewModel> addReview({
    required int objectId,
    required ReviewType reviewType,
    required int stars,
    required String comments,
  }) async {
    final String url = '$baseUrl/api/reviews/';

    final data = {
      "content_type": reviewType.name,
      "object_id": objectId,
      "stars": stars,
      "comment": comments,
    };

    try {
      final response = await apiInstance.post(url, data: data);
      return ReviewModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<ReviewModel> updateReview({
    required int id,
    required ReviewType reviewType,
    required int stars,
    required String comments,
  }) async {
    final String url = '$baseUrl/api/reviews/$id/';

    final data = {
      "stars": stars,
      "comment": comments,
    };

    try {
      final response = await apiInstance.patch(url, data: data);
      return ReviewModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Failure(
        e.response?.data['error_message'] ?? 'Something went wrong.',
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
