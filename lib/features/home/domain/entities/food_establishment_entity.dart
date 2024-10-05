import 'package:vill_finder/features/home/domain/entities/index.dart';

class FoodEstablishmentEntity {
  final int id;
  final PlaceEntity place;
  final String openingTime;
  final String closingTime;

  FoodEstablishmentEntity({
    required this.id,
    required this.place,
    required this.openingTime,
    required this.closingTime,
  });

  FoodEstablishmentEntity copyWith({
    int? id,
    PlaceEntity? place,
    String? openingTime,
    String? closingTime,
  }) {
    return FoodEstablishmentEntity(
      id: id ?? this.id,
      place: place ?? this.place,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
    );
  }
}
