// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessEntity {
  final int id;
  final List<BusinessSubCategoryEntity> category;
  final List<BusinessPhotoEntity> businessPhotos;
  final BusinessUserProfileEntity userProfile;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String description;
  final String address;
  final double longitude;
  final double latitude;
  final String openTime;
  final String closeTime;
  final Uint8List? bitMapIcon;

  BusinessEntity({
    required this.id,
    required this.category,
    required this.businessPhotos,
    required this.userProfile,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.openTime,
    required this.closeTime,
    this.bitMapIcon,
  });

  BusinessEntity copyWith({
    int? id,
    List<BusinessSubCategoryEntity>? category,
    List<BusinessPhotoEntity>? businessPhotos,
    BusinessUserProfileEntity? userProfile,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? description,
    String? address,
    double? longitude,
    double? latitude,
    String? openTime,
    String? closeTime,
    Uint8List? bitMapIcon,
  }) {
    return BusinessEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      businessPhotos: businessPhotos ?? this.businessPhotos,
      userProfile: userProfile ?? this.userProfile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      bitMapIcon: bitMapIcon ?? this.bitMapIcon,
    );
  }
}
