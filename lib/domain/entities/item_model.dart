import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

class DateTimeTimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const DateTimeTimestampConverter();

  @override
  DateTime fromJson(Timestamp json) {
    return json.toDate();
  }

  @override
  Timestamp toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}

@freezed
class Item with _$Item {
  factory Item({
    String? id,
    required String title,
    @Default(false) bool isCompleted,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) = _Item;

  const Item._();

  factory Item.empty() => Item(title: '', createdAt: DateTime.now());
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
