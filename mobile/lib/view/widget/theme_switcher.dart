import 'package:flutter/material.dart';
import '../../provider/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: ThemeProvider.themeNotifier,
        builder: (context, mode, _) {
          return SwitchListTile(
              title: const Text('Change theme'),
              value: mode,
              onChanged: (val) {
                ThemeProvider.themeNotifier.value =
                    mode == false ? true : false;
                ThemeProvider.saveDarkTheme(val);
              });
        });
  }
}
