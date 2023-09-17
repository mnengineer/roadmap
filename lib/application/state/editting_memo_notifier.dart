import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/domain/types/memo.dart';

/// 編集中メモを管理するNotifier
class EdittingMemoNotifier extends StateNotifier<Memo> {
  EdittingMemoNotifier(
    /// 初期値
    super.initialMemo,
  );

  /// 現在の状態
  Memo get value => state;

  /// 更新
  // ignore: use_setters_to_change_properties
  void update(Memo memo) {
    state = memo;
  }
}
