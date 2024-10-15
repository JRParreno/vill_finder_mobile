import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigator_index_state.dart';

class NavigatorIndexCubit extends Cubit<NavigatorIndexState> {
  NavigatorIndexCubit()
      : super(
          const NavigatorIndexState(
            currentIndex: 0,
            indexes: [
              Icons.home,
              CupertinoIcons.heart_fill,
              Icons.map,
              Icons.person,
            ],
          ),
        );

  void onChangeIndex(int value) {
    emit(state.copyWith(currentIndex: value));
  }
}
