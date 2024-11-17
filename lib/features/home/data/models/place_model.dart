import 'dart:convert';

import 'package:vill_finder/features/home/data/models/index.dart';
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'package:vill_finder/features/review/data/models/index.dart';

class PlaceModel extends PlaceEntity {
  PlaceModel({
    required super.categories,
    required super.userProfile,
    required super.createdAt,
    required super.updatedAt,
    required super.name,
    required super.description,
    required super.address,
    required super.longitude,
    required super.latitude,
    required super.isFoodEstablishment,
    required super.photos,
    required super.averageReview,
    super.bitMapIcon,
    super.isFavorited,
    super.userHasReviewed,
    super.reviewEntity,
    super.totalReview,
    super.contactName,
    super.contactNumber,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      categories: List.from(
        json['categories'].map<BusinessCategoryModel>(
          (x) => BusinessCategoryModel.fromJson(x as Map<String, dynamic>),
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
      isFoodEstablishment: json['is_food_establishment'] as bool,
      bitMapIcon: json['map_icon_bitmap'] != null
          ? base64Decode(json['map_icon_bitmap'])
          : null,
      photos: List<BusinessPhotoModel>.from(
        json['photos'].map<BusinessPhotoModel>(
          (x) => BusinessPhotoModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      isFavorited: json['is_favorited'],
      userHasReviewed: json['user_has_reviewed'],
      reviewEntity: json['user_review'] != null
          ? ReviewModel.fromJson(json['user_review'])
          : null,
      totalReview: json['total_review'],
      contactNumber: json['contact_number'] as String?,
      contactName: json['contact_name'] as String?,
      averageReview: json['average_review'] ?? 0.0,
    );
  }
}
