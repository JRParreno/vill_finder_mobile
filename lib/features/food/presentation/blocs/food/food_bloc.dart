import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vill_finder/features/food/domain/usecases/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final GetFoodEstablishment _getFoodEstablishment;

  FoodBloc(GetFoodEstablishment getFoodEstablishment)
      : _getFoodEstablishment = getFoodEstablishment,
        super(FoodInitial()) {
    on<GetFoodEvent>(onGetFoodEvent);
  }

  Future<void> onGetFoodEvent(
      GetFoodEvent event, Emitter<FoodState> emit) async {
    emit(FoodLoading());

    final response = await _getFoodEstablishment.call(event.id);

    response.fold(
      (l) => emit(FoodFailure(l.message)),
      (r) => emit(FoodSuccess(r)),
    );
  }
}
