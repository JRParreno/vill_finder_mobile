// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'dart:typed_data';

import 'package:vill_finder/features/review/domain/entities/index.dart';

class PlaceEntity {
  final List<BusinessCategoryEntity> categories;
  final BusinessUserProfileEntity userProfile;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String description;
  final String address;
  final double longitude;
  final double latitude;
  final bool isFoodEstablishment;
  final List<BusinessPhotoEntity> photos;
  final Uint8List? bitMapIcon;
  final bool isFavorited;
  final bool userHasReviewed;
  final int totalReview;
  final double averageReview;
  final ReviewEntity? reviewEntity;
  final String? contactNumber;
  final String? contactName;

  PlaceEntity({
    required this.categories,
    required this.userProfile,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.isFoodEstablishment,
    required this.photos,
    required this.averageReview,
    this.totalReview = 0,
    this.bitMapIcon,
    this.isFavorited = false,
    this.userHasReviewed = false,
    this.reviewEntity,
    this.contactName,
    this.contactNumber,
  });

  PlaceEntity copyWith({
    List<BusinessCategoryEntity>? categories,
    BusinessUserProfileEntity? userProfile,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? description,
    String? address,
    double? longitude,
    double? latitude,
    double? averageReview,
    bool? isFoodEstablishment,
    List<BusinessPhotoEntity>? photos,
    Uint8List? bitMapIcon,
    bool? isFavorited,
    bool? userHasReviewed,
    ReviewEntity? reviewEntity,
    int? totalReview,
    String? contactNumber,
    String? contactName,
  }) {
    return PlaceEntity(
      categories: categories ?? this.categories,
      userProfile: userProfile ?? this.userProfile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      isFoodEstablishment: isFoodEstablishment ?? this.isFoodEstablishment,
      photos: photos ?? this.photos,
      bitMapIcon: bitMapIcon ?? this.bitMapIcon,
      isFavorited: isFavorited ?? this.isFavorited,
      userHasReviewed: userHasReviewed ?? this.userHasReviewed,
      reviewEntity: reviewEntity ?? this.reviewEntity,
      totalReview: totalReview ?? this.totalReview,
      contactName: contactName ?? this.contactName,
      contactNumber: contactNumber ?? this.contactNumber,
      averageReview: averageReview ?? this.averageReview,
    );
  }
}
