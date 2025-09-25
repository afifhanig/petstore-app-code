import 'package:json_annotation/json_annotation.dart';
import 'package:petstore_app/features/pet/domain/entities/pet.dart';

part 'pet_model.g.dart';

@JsonSerializable()
class PetModel {
  final int id;
  final String? name;
  final CategoryModel? category;
  final List<String>? photoUrls;
  // final List<TagModel>? tags;
  final String? status;

  PetModel({
    required this.id,
    this.name,
    this.category,
    this.photoUrls,
    // this.tags,
    this.status,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) =>
      _$PetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PetModelToJson(this);

  Pet toEntity() {
    return Pet(
      id: id,
      name: name,
      status: status,
      categoryName: category?.name,
      photoUrl: (photoUrls?.isNotEmpty ?? false) ? photoUrls!.first : null,
    );
  }

  factory PetModel.fromEntity(Pet entity) {
    return PetModel(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      category: entity.categoryName != null
          ? CategoryModel(id: 1, name: entity.categoryName!)
          : null,
      photoUrls: entity.photoUrl != null ? [entity.photoUrl!] : [],
      // tags: [],
    );
  }
}

@JsonSerializable()
class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class TagModel {
  final int id;
  final String name;

  TagModel({required this.id, required this.name});

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagModelToJson(this);
}
