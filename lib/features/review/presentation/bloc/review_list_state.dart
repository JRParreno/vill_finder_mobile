part of 'review_list_bloc.dart';

sealed class ReviewListState extends Equatable {
  const ReviewListState();

  @override
  List<Object> get props => [];
}

final class ReviewListInitial extends ReviewListState {}

final class ReviewListLoading extends ReviewListState {}

final class ReviewListSuccess extends ReviewListState {
  final int placeId;
  final ReviewType reviewType;
  final ReviewListResponseEntity responseEntity;
  final bool isPaginated;

  const ReviewListSuccess({
    required this.placeId,
    required this.reviewType,
    required this.responseEntity,
    this.isPaginated = false,
  });

  ReviewListSuccess copyWith({
    int? placeId,
    ReviewType? reviewType,
    ReviewListResponseEntity? responseEntity,
    bool? isPaginated,
  }) {
    return ReviewListSuccess(
      placeId: placeId ?? this.placeId,
      reviewType: reviewType ?? this.reviewType,
      responseEntity: responseEntity ?? this.responseEntity,
      isPaginated: isPaginated ?? this.isPaginated,
    );
  }

  @override
  List<Object> get props => [
        reviewType,
        placeId,
        responseEntity,
        isPaginated,
      ];
}

final class ReviewListFailure extends ReviewListState {
  final String message;

  const ReviewListFailure({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
