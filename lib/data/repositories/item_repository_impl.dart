import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/domain/entities/item_model.dart';
import 'package:roadmap/domain/repositories/item_repository.dart';

class ItemRepositoryImpl implements ItemRepository {
  const ItemRepositoryImpl(this._ref);

  final Ref _ref;

  @override
  Future<List<Item>> retrieveItems() async {
    try {
      final snap =
          await _ref.read(firebaseFirestoreProvider).collection('lists').get();
      return snap.docs.map(Item.fromDocument).toList();
    } on Exception {
      return [];
    }
  }

  @override
  Future<String> createItem({
    required Item item,
  }) async {
    try {
      final docRef = await _ref
          .read(firebaseFirestoreProvider)
          .collection('lists')
          .add(item.toDocument());
      return docRef.id;
    } on Exception {
      return '';
    }
  }

  @override
  Future<void> updateItem({required Item item}) async {
    try {
      await _ref
          .read(firebaseFirestoreProvider)
          .collection('lists')
          .doc(item.id)
          .update(item.toDocument());
    } on Exception {
      // NOP
    }
  }

  @override
  Future<void> deleteItem({
    required String id,
  }) async {
    try {
      await _ref
          .read(firebaseFirestoreProvider)
          .collection('lists')
          .doc(id)
          .delete();
    } on Exception {
      // NOP
    }
  }
}
