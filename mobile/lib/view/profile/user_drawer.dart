import 'package:client/common/utils.dart';
import 'package:client/view/profile/change_password.dart';
import 'package:client/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../storage/storage.dart';
import '../../provider/user_profile_provider.dart';
import '../auth/auth_state_notifier.dart';
import '../widget/custom_error_widget.dart';
import '../widget/theme_switcher.dart';
import 'user_avatar.dart';

class UserDrawer extends ConsumerWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).value;

    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          ref.watch(userDataProvider(userId!)).when(
              data: (data) => Column(
                    children: [
                      const SizedBox(height: 20),
                      UserAvatar(
                        iconSize: 50,
                        image: data.imageUrl,
                        showIcon: false,
                        onTap: () {
                          Navigator.of(context).pop();
                          push(ProfileScreen(userId: userId));
                        },
                      ),
                      Text(
                        "${data.firstName} ${data.lastName}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        data.profession!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              error: (e, t) => Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: CustomErrorWidget(
                      onPressed: () => ref.refresh(userDataProvider(userId)),
                    ),
                  ),
              loading: () => const SizedBox.shrink()),
          const Spacer(),
          const ThemeSwitcher(),
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.lock_outline),
            onTap: () => push(const ChangePassword()),
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
            ),
            trailing: const Icon(Icons.exit_to_app, color: Colors.red),
            onTap: () => StorageProvider().logout(),
          )
        ],
      )),
    );
  }
}
