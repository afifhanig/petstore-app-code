class PetUpdateRequest {
  final int id;
  final String name;
  final String status;
  final int categoryId;
  final String categoryName;
  final String photoUrl;

  PetUpdateRequest({
    required this.id,
    required this.name,
    required this.status,
    required this.categoryId,
    required this.categoryName,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": {"id": categoryId, "name": categoryName},
      "photoUrls": [photoUrl],
      "tags": [],
      "status": status,
    };
  }
}
