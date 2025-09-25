// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: (json['id'] as num?)?.toInt(),
  petId: (json['petId'] as num?)?.toInt(),
  quantity: (json['quantity'] as num?)?.toInt(),
  shipDate: json['shipDate'] as String?,
  status: json['status'] as String?,
  complete: json['complete'] as bool?,
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'petId': instance.petId,
      'quantity': instance.quantity,
      'shipDate': instance.shipDate,
      'status': instance.status,
      'complete': instance.complete,
    };
