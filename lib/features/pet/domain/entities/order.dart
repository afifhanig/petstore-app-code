class Order {
  final int? id;
  final int? petId;
  final int? quantity;
  final String? shipDate;
  final String? status;
  final bool? complete;

  Order({
    this.id,
    this.petId,
    this.quantity,
    this.shipDate,
    this.status,
    this.complete,
  });
}
