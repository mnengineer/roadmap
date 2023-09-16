import 'package:roadmap/domain/types/memo.dart';
import 'package:roadmap/domain/types/memo_config.dart';
import 'package:roadmap/domain/types/status.dart';

/// メモに関する設定値
final memoConfig = MemoConfig(
  defaultText: 'Flutter Roadmap',
  exampleMemos: [
    const Memo(
      id: 'xxxx-example-01-xxxx',
      status: Status.todo,
      text: 'Kotlin Roadmap',
    ),
    const Memo(
      id: 'xxxx-example-02-xxxx',
      status: Status.doing,
      text: 'Firebase Roadmap',
    ),
    const Memo(
      id: 'xxxx-example-03-xxxx',
      status: Status.done,
      text: 'Dart Roadmap',
    ),
  ],
  maxLength: 20,
);
