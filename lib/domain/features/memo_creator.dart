import 'package:roadmap/domain/types/memo.dart';
import 'package:roadmap/domain/types/status.dart';
import 'package:uuid/uuid.dart';

/// メモの作成ルールを担当するクラス
class MemoCreater {
  MemoCreater({
    required this.defaultText,
  });

  /// 最初からメモに書かれている文字
  final String defaultText;

  /// 新規メモを作成する
  Memo createNewMemo() {
    /// ランダムな ID を作成
    final id = const Uuid().v4();
    return Memo(
      id: id,
      // はじめは 予定 のステータス
      status: Status.todo,
      text: defaultText,
    );
  }
}
