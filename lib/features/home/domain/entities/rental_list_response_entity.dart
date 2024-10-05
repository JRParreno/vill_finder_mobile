import 'package:vill_finder/features/home/domain/entities/index.dart';

class RentalListResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<RentalEntity> results;

  RentalListResponseEntity({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  RentalListResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<RentalEntity>? results,
  }) {
    return RentalListResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
