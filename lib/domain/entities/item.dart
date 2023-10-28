import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class Item with _$Item {
  factory Item({
    String? id,
    required String title,
    required String description,
    required DateTime deadline,
    required String imagePath,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
  }) = _Item;

  const Item._();

  factory Item.empty() => Item(
        title: '',
        description: '',
        deadline: DateTime.now(),
        imagePath: '',
        createdAt: DateTime.now(),
      );
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
