import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../view/widget/custom_button.dart';
import 'api.dart';

final navigatorKey = GlobalKey<NavigatorState>();

const kTabletDimension = 720.0;
const kDesktopDimension = 1440.0;

const primaryLightColor = Color(0xff3b8767);
const darkBlueColor = Color(0xff0d1c2c);
void showSnackBar(String data) => showFlash<bool>(
      builder: (context, controller) => FlashBar(
        controller: controller,
        content: Text(
          data,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          CustomButton(
              width: 100,
              height: 40,
              color: const Color(0xff3b8767),
              onPressed: () => controller.dismiss(true),
              child: const Text(
                'DISMISS',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ))
        ],
      ),
      context: navigatorKey.currentContext!,
    );

Future<void> push(Widget child) => Navigator.of(navigatorKey.currentContext!)
    .push(PageTransition(child: child, type: PageTransitionType.rightToLeft));

void pop<T extends Object?>([T? result]) =>
    Navigator.of(navigatorKey.currentContext!).pop();
Future<void> pushReplacement(Widget child) =>
    Navigator.of(navigatorKey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) => child));

Future<void> pushAndRemoveUntil(Widget child) =>
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => child), (c) => false);

void internetConnectivity() {
  Connectivity().onConnectivityChanged.listen((event) {
    if (event == ConnectivityResult.none) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
          duration: const Duration(days: 3),
          content: Column(
            children: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    noConnection,
                    style: TextStyle(fontSize: 16),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                    width: 100,
                    height: 40,
                    color: const Color(0xff3b8767),
                    onPressed: () =>
                        ScaffoldMessenger.of(navigatorKey.currentContext!)
                            .clearSnackBars(),
                    child: const Text(
                      'DISMISS',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              )
            ],
          )));
    } else {
      ScaffoldMessenger.of(navigatorKey.currentContext!).clearSnackBars();
    }
  });
}

void showErrorDialog(String message) => showDialog(
    context: navigatorKey.currentContext!,
    builder: (ctx) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'DISMISS',
                  height: 40,
                  textSize: 16,
                  color: Colors.black,
                  onPressed: () =>
                      Navigator.of(navigatorKey.currentContext!).pop(),
                )
              ],
            ),
          ),
        ));

void loadingDialog() => showDialog(
    context: navigatorKey.currentContext!,
    builder: (ctx) => Dialog.fullscreen(
          backgroundColor: Colors.black38.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
