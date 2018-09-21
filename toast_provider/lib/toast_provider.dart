import 'dart:async';

import 'package:flutter/services.dart';

class ToastProvider {
  static const MethodChannel _channel = const MethodChannel('toast_provider');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static void showToast(String message) =>
      _channel.invokeMethod('showToast', {"message": message});

  static void showToastLong(String message) =>
      _channel.invokeMethod('showToastLong', {"message": message});
}
