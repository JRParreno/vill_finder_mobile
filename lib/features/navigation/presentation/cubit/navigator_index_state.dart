// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigator_index_cubit.dart';

class NavigatorIndexState extends Equatable {
  const NavigatorIndexState({
    required this.indexes,
    required this.currentIndex,
  });

  final List<IconData> indexes;
  final int currentIndex;

  @override
  List<Object> get props => [indexes, currentIndex];

  NavigatorIndexState copyWith({
    List<IconData>? indexes,
    int? currentIndex,
  }) {
    return NavigatorIndexState(
      indexes: indexes ?? this.indexes,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
