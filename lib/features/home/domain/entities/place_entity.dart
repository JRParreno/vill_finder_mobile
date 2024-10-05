// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vill_finder/features/home/domain/entities/index.dart';
import 'dart:typed_data';

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
    this.bitMapIcon,
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
    bool? isFoodEstablishment,
    List<BusinessPhotoEntity>? photos,
    Uint8List? bitMapIcon,
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
    );
  }
}
