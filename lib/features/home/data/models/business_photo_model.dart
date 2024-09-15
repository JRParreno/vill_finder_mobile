import 'package:vill_finder/features/home/domain/entities/index.dart';

class BusinessPhotoModel extends BusinessPhotoEntity {
  BusinessPhotoModel({
    required super.id,
    required super.image,
  });

  factory BusinessPhotoModel.fromJson(Map<String, dynamic> json) {
    return BusinessPhotoModel(
      id: json['id'] as int,
      image: json['image'] as String,
    );
  }
}
