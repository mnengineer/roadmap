import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/application/state/memo_list_notifier.dart';
import 'package:roadmap/domain/types/memo.dart';

/// メモ一覧のプロバイダー
final memoListProvider = StateNotifierProvider<MemoListNotifier, List<Memo>>(
  (ref) {
    return MemoListNotifier([]);
  },
);
