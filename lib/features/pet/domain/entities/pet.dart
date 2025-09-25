class Pet {
  final int id;
  final String? name;
  final String? status;
  final String? categoryName;
  final String? photoUrl;

  Pet({
    required this.id,
    this.name,
    this.status,
    this.categoryName,
    this.photoUrl,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pet &&
        other.id == id &&
        other.name == name &&
        other.status == status &&
        other.categoryName == categoryName &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      status.hashCode ^
      categoryName.hashCode ^
      photoUrl.hashCode;
}
