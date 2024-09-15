import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessModel extends BusinessEntity {
  BusinessModel({
    required super.id,
    required super.category,
    required super.businessPhotos,
    required super.userProfile,
    required super.createdAt,
    required super.updatedAt,
    required super.name,
    required super.description,
    required super.address,
    required super.longitude,
    required super.latitude,
    required super.openTime,
    required super.closeTime,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'] as int,
      category: List.from(
        (json['category']).map(
          (x) => BusinessSubCategoryModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      businessPhotos: List.from(
        (json['business_photos']).map(
          (x) => BusinessPhotoModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      userProfile: BusinessUserProfileModel.fromJson(
          json['user_profile'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
      openTime: json['open_time'] as String,
      closeTime: json['close_time'] as String,
    );
  }
}
