import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class RentalModel extends RentalEntity {
  RentalModel({
    required super.id,
    required super.place,
    required super.kitchen,
    required super.airConditioning,
    required super.wifi,
    required super.petsAllowed,
    required super.refrigerator,
    required super.emergencyExit,
    required super.contactNumber,
    required super.numBedrooms,
    required super.numBathrooms,
    required super.propertyType,
    required super.propertyCondition,
    required super.furnitureCondition,
    required super.leaseTerm,
    required super.monthlyRent,
  });

  factory RentalModel.fromMap(Map<String, dynamic> json) {
    return RentalModel(
      id: json['id'] as int,
      place: PlaceModel.fromJson(json),
      kitchen: json['kitchen'] as bool,
      airConditioning: json['air_conditioning'] as bool,
      wifi: json['wifi'] as bool,
      petsAllowed: json['pets_allowed'] as bool,
      refrigerator: json['refrigerator'] as bool,
      emergencyExit: json['emergency_exit'] as bool,
      contactNumber: json['contact_number'] as String?,
      numBedrooms: json['num_bedrooms'] as int,
      numBathrooms: json['num_bathrooms'] as int,
      propertyType: json['property_type'] as String,
      propertyCondition: json['property_condition'] as String,
      furnitureCondition: json['furniture_condition'] as String,
      leaseTerm: json['lease_term'] as String,
      monthlyRent: json['monthly_rent'] as String,
    );
  }
}
