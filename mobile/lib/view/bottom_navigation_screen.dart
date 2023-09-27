import 'package:client/view/home/home_view.dart';
import 'package:client/view/upload/add_post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final provider = ref.watch(indexNotifier);
      return Scaffold(
        body: [
          const HomeView(),
          const SizedBox.shrink(),
          const Scaffold()
        ][provider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.currentIndex,
            onTap: (value) => provider.setCurrentIndex(value),
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: GestureDetector(
                      onTap: () => showMaterialModalBottomSheet(
                            enableDrag: false,
                            context: context,
                            builder: (context) => const AddPostView(),
                          ),
                      child: const Icon(Icons.add_a_photo)),
                  label: 'Upload'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.notifications), label: 'Notifications'),
            ]),
      );
    });
  }
}

final indexNotifier = ChangeNotifierProvider((ref) => BottomNavNotifier());

class BottomNavNotifier extends ChangeNotifier {
  int currentIndex = 0;

  void setCurrentIndex(int i) {
    currentIndex = i;
    notifyListeners();
  }
}
