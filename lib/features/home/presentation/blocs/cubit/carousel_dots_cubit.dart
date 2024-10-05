import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DotsEvent {}

class UpdateDotsIndex extends DotsEvent {
  final int index;

  UpdateDotsIndex(this.index);
}

// State
class DotsState {
  final int currentIndex;

  DotsState(this.currentIndex);
}

// Cubit
class DotsCubit extends Cubit<DotsState> {
  DotsCubit() : super(DotsState(0));

  void updateIndex(int index) {
    emit(DotsState(index));
  }
}
