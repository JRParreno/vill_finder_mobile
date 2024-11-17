import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class FoodEstablishmentModel extends FoodEstablishmentEntity {
  FoodEstablishmentModel({
    required super.id,
    required super.place,
    required super.openingTime,
    required super.closingTime,
    super.isOpen24Hours,
  });

  factory FoodEstablishmentModel.fromJson(Map<String, dynamic> json) {
    return FoodEstablishmentModel(
      id: json['id'] as int,
      place: PlaceModel.fromJson(json),
      openingTime: json['opening_time'] as String,
      closingTime: json['closing_time'] as String,
      isOpen24Hours: json['is_open_24_hours'] ?? false,
    );
  }
}
