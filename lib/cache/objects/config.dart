import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genibook/constants.dart';

class ConfigCache {
  ConfigCache._();

  static Future<void> storeBgFetchVal(bool enabled) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));

    if (enabled) {
      await storage.write(key: "bg-fetch", value: "true");
    } else {
      await storage.write(key: "bg-fetch", value: "false");
    }
  }

  static Future<bool> readBgFetchVal() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String value = await storage.read(key: "bg-fetch") ?? "true";
    return value.toLowerCase() == 'true';
  }

  static Future<void> storeMPs(List<dynamic> mps) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String stringJson = jsonEncode(mps);
    await storage.write(key: "mps", value: stringJson);
  }

  static Future<List<dynamic>> readMPs() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String jsonString = await storage.read(key: "mps") ?? "";

    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print("[DEBUG] READ MPS:");
        print(jsonString);
      }
    }
    if (jsonString.isNotEmpty) {
      List<dynamic> thing = json.decode(jsonString);
      return thing;
    } else {
      return <dynamic>["MP1", "MP2"];
    }
  }
}
