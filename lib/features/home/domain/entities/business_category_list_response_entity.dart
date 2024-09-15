// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessCategoryListResponseEntity {
  final int count;
  final String? next;
  final String? previous;
  final List<BusinessCategoryEntity> results;

  BusinessCategoryListResponseEntity({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  BusinessCategoryListResponseEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<BusinessCategoryEntity>? results,
  }) {
    return BusinessCategoryListResponseEntity(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
