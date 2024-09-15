// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessListResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<BusinessEntity> results;

  BusinessListResponseEntity({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  BusinessListResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<BusinessEntity>? results,
  }) {
    return BusinessListResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
