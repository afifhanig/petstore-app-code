import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends Order {
  OrderModel({
    int? id,
    int? petId,
    int? quantity,
    String? shipDate,
    String? status,
    bool? complete,
  }) : super(
         id: id,
         petId: petId,
         quantity: quantity,
         shipDate: shipDate,
         status: status,
         complete: complete,
       );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
