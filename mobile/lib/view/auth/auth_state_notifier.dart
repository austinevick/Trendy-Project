import 'package:client/view/auth/signin_view.dart';
import 'package:client/view/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/storage.dart';

final authProvider =
    FutureProvider((ref) => ref.watch(storageProvider).getUserId());

class AuthStateNotifier extends ConsumerWidget {
  const AuthStateNotifier({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authProvider).when(
        data: (data) =>
            data == null ? const SigninView() : const BottomNavigationScreen(),
        error: (e, t) => const SizedBox.shrink(),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
