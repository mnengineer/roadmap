import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:roadmap/application/di/infrastructure.dart';
import 'package:roadmap/application/di/usecases.dart';
import 'package:roadmap/application/state/memo_list_provider.dart';
import 'package:roadmap/presentation/router/go_router.dart';
import 'package:roadmap/presentation/router/screen_path.dart';
import 'package:roadmap/presentation/widgets/add_button.dart';
import 'package:roadmap/presentation/widgets/memo_card.dart';

class ListScreen extends HookConsumerWidget {
  const ListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// logger
    ref.watch(loggerProvider).debug('ListScreen.build()');

    // 画面が表示された時に処理をする
    useEffect(
      () {
        // スプラッシュ画面がないのでここで初期化
        // ユースケースを呼び出す
        ref.read(initAppProvider).execute();
        return null;
      },
      const [],
    );

    /// メモ一覧
    final memoList = ref.watch(memoListProvider);

    /// リスト
    final listView = ListView.builder(
      itemCount: memoList.length,
      itemBuilder: (context, index) {
        final memo = memoList[index];
        return MemoCard(
          memo: memoList[index],
          onPressed: () {
            ref.read(goRouterProvider).pushNamed(
              ScreenId.edit.routeName,
              pathParameters: {'id': memo.id},
            );
          },
          onPressedDelete: () {
            // ユースケースを呼び出す
            ref.read(deleteMemoProvider).deleteMemo(memo.id);
          },
        );
      },
    );

    /// 追加ボタン
    final addButton = AddButton(
      onPressed: () {
        // ユースケースを呼び出す
        ref.read(addMemoProvider).addNewMemo();
      },
    );

    /// 画面レイアウト
    return Scaffold(
      floatingActionButton: addButton,
      appBar: AppBar(
        title: const Text('List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // ユースケースを呼び出す
              ref.read(logoutProvider).logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: listView,
      ),
    );
  }
}
