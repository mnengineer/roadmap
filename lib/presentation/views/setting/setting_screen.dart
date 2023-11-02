import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:roadmap/core/di/providers.dart';
import 'package:roadmap/presentation/views/setting/setting_list_item.dart';
import 'package:roadmap/presentation/widgets/dialog/error_dialog.dart';
import 'package:roadmap/presentation/widgets/snackbar/snackbar.dart';
import 'package:roadmap/presentation/widgets/tile/setting_list_group_tile.dart';
import 'package:roadmap/presentation/widgets/tile/setting_list_tile.dart';

class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(settingViewModelProvider.notifier);
    final state = ref.watch(settingViewModelProvider);

    final snackbar = ref.read(snackbarProvider);
    final errorDialog = ref.read(errorDialogProvider);

    final authenticationAttempt = useState(false);

    useEffect(
      () {
        Logger().d('useeffect');
        if (authenticationAttempt.value) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.when(
              data: (_) {
                Logger().d('成功');
                snackbar.successSnackBar(
                  context,
                  title: 'Logout Success',
                );
                viewModel
                  ..navigatePop()
                  ..navigateToWelcome();
              },
              loading: () {
                Logger().d('ローディング');
              },
              error: (error, stackTrace) {
                Logger().d('失敗');
                errorDialog.showErrorDialog(
                  context,
                  title: 'Logout Error',
                  message: error.toString(),
                );
              },
            );
          });
        }
        return null;
      },
      [state],
    );

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey[900]!.withOpacity(0.9),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Settings',
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                const SettingListTile(
                  '一般',
                  Icons.settings,
                  Colors.blue,
                ),
                const SizedBox(height: 16),
                SettingListGroupTile(
                  [
                    SettingListItem(
                      'シェアする',
                      Icons.ios_share,
                      Colors.blue,
                    ),
                    SettingListItem(
                      'アプリを評価する',
                      Icons.star,
                      Colors.orange,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SettingListGroupTile(
                  [
                    SettingListItem(
                      'ヘルプ',
                      Icons.help,
                      Colors.green,
                    ),
                    SettingListItem(
                      'お問い合わせ',
                      Icons.mail,
                      Colors.purple,
                    ),
                    SettingListItem(
                      'サービス利用規約',
                      Icons.description,
                      Colors.grey,
                    ),
                    SettingListItem(
                      'プライバシーポリシー',
                      Icons.privacy_tip,
                      Colors.teal,
                    ),
                    SettingListItem(
                      'バージョン',
                      Icons.info,
                      Colors.brown,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SettingListGroupTile(
                  [
                    SettingListItem(
                      'ログアウト',
                      Icons.logout,
                      Colors.red,
                      onTap: () {
                        authenticationAttempt.value = true;
                        viewModel.logout();
                      },
                    ),
                    SettingListItem(
                      '退会',
                      Icons.delete_forever,
                      Colors.red,
                      onTap: () {
                        authenticationAttempt.value = true;
                        viewModel.deleteAccount();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
