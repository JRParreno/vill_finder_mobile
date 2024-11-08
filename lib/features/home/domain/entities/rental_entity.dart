import 'package:vill_finder/features/home/domain/entities/index.dart';

class RentalEntity {
  final int id;
  final PlaceEntity place;
  final bool kitchen;
  final bool airConditioning;
  final bool wifi;
  final bool petsAllowed;
  final bool refrigerator;
  final bool emergencyExit;
  final int numBedrooms;
  final int numBathrooms;
  final String propertyType;
  final String propertyCondition;
  final String furnitureCondition;
  final String leaseTerm;
  final String monthlyRent;
  final String? contactNumber;

  RentalEntity({
    required this.id,
    required this.place,
    required this.kitchen,
    required this.airConditioning,
    required this.wifi,
    required this.petsAllowed,
    required this.refrigerator,
    required this.emergencyExit,
    required this.numBedrooms,
    required this.numBathrooms,
    required this.propertyType,
    required this.propertyCondition,
    required this.furnitureCondition,
    required this.leaseTerm,
    required this.monthlyRent,
    this.contactNumber,
  });

  RentalEntity copyWith({
    int? id,
    PlaceEntity? place,
    bool? kitchen,
    bool? airConditioning,
    bool? wifi,
    bool? petsAllowed,
    bool? refrigerator,
    bool? emergencyExit,
    String? contactNumber,
    int? numBedrooms,
    int? numBathrooms,
    String? propertyType,
    String? propertyCondition,
    String? furnitureCondition,
    String? leaseTerm,
    String? monthlyRent,
  }) {
    return RentalEntity(
      id: id ?? this.id,
      place: place ?? this.place,
      kitchen: kitchen ?? this.kitchen,
      airConditioning: airConditioning ?? this.airConditioning,
      wifi: wifi ?? this.wifi,
      petsAllowed: petsAllowed ?? this.petsAllowed,
      refrigerator: refrigerator ?? this.refrigerator,
      emergencyExit: emergencyExit ?? this.emergencyExit,
      contactNumber: contactNumber ?? this.contactNumber,
      numBedrooms: numBedrooms ?? this.numBedrooms,
      numBathrooms: numBathrooms ?? this.numBathrooms,
      propertyType: propertyType ?? this.propertyType,
      propertyCondition: propertyCondition ?? this.propertyCondition,
      furnitureCondition: furnitureCondition ?? this.furnitureCondition,
      leaseTerm: leaseTerm ?? this.leaseTerm,
      monthlyRent: monthlyRent ?? this.monthlyRent,
    );
  }
}
