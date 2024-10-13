import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/core/enum/review_type.dart';
import 'package:vill_finder/features/review/domain/entities/index.dart';
import 'package:vill_finder/features/review/domain/usecases/get_review_list.dart';

part 'review_list_event.dart';
part 'review_list_state.dart';

class ReviewListBloc extends Bloc<ReviewListEvent, ReviewListState> {
  final GetReviewList _getReviewList;

  ReviewListBloc(GetReviewList getReviewList)
      : _getReviewList = getReviewList,
        super(ReviewListInitial()) {
    on<GetReviewsEvent>(onGetReviewsEvent);
    on<PaginateReviewEvent>(onPaginateReviewEvent);
  }

  Future<void> onGetReviewsEvent(
      GetReviewsEvent event, Emitter<ReviewListState> emit) async {
    emit(ReviewListLoading());

    final response = await _getReviewList.call(GetReviewListParams(
      placeId: event.placeId,
      reviewType: event.reviewType,
    ));

    response.fold(
      (l) => emit(ReviewListFailure(message: l.message)),
      (r) => emit(ReviewListSuccess(
        responseEntity: r,
        placeId: event.placeId,
        reviewType: event.reviewType,
      )),
    );
  }

  Future<void> onPaginateReviewEvent(
      PaginateReviewEvent event, Emitter<ReviewListState> emit) async {
    final state = this.state;

    if (state is ReviewListSuccess) {
      emit(state.copyWith(isPaginated: true));

      final response = await _getReviewList.call(GetReviewListParams(
        placeId: state.placeId,
        reviewType: state.reviewType,
        next: state.responseEntity.next,
        previous: state.responseEntity.previous,
      ));

      response.fold(
        (l) => emit(ReviewListFailure(message: l.message)),
        (r) => emit(
          state.copyWith(
            isPaginated: false,
            responseEntity: r.copyWith(
              reviews: [...state.responseEntity.reviews, ...r.reviews],
            ),
          ),
        ),
      );
    }
  }
}
