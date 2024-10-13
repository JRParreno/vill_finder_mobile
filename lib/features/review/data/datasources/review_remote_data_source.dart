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
}
