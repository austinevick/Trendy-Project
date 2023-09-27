import 'package:client/view/bottom_navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../storage/storage.dart';
import 'signup_view.dart';

final authProvider =
    FutureProvider((ref) => ref.watch(storageProvider).getUserId());

class AuthStateNotifier extends ConsumerWidget {
  const AuthStateNotifier({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authProvider).when(
        data: (data) =>
            data == null ? const SignupView() : const BottomNavigationScreen(),
        error: (e, t) => const SizedBox.shrink(),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}