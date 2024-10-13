part of 'review_list_bloc.dart';

sealed class ReviewListEvent extends Equatable {
  const ReviewListEvent();

  @override
  List<Object> get props => [];
}

final class GetReviewsEvent extends ReviewListEvent {
  final int placeId;
  final ReviewType reviewType;

  const GetReviewsEvent({
    required this.placeId,
    required this.reviewType,
  });

  @override
  List<Object> get props => [
        placeId,
        reviewType,
      ];
}

final class PaginateReviewEvent extends ReviewListEvent {}
