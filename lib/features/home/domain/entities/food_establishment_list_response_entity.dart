import 'package:vill_finder/features/home/domain/entities/index.dart';

class FoodEstablishmentListResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<FoodEstablishmentEntity> results;

  FoodEstablishmentListResponseEntity({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  FoodEstablishmentListResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<FoodEstablishmentEntity>? results,
  }) {
    return FoodEstablishmentListResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
