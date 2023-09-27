import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/utils.dart';
import 'provider/theme_provider.dart';
import 'view/auth/auth_state_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeProvider().setAppTheme();
  internetConnectivity();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ValueListenableBuilder<bool>(
          valueListenable: ThemeProvider.themeNotifier,
          builder: (context, theme, _) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Trendy',
                themeMode: theme ? ThemeMode.dark : ThemeMode.light,
                darkTheme: ThemeData.dark(useMaterial3: true),
                theme: ThemeData.light(useMaterial3: true).copyWith(
                    scaffoldBackgroundColor: Colors.white,
                    colorScheme:
                        const ColorScheme.light(primary: primaryLightColor)),
                navigatorKey: navigatorKey,
                home: const AuthStateNotifier());
          }),
    );
  }
}
