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

  static Future<void> storeBioAuth(bool doesUserWantIt) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    if (doesUserWantIt) {
      await storage.write(key: "bio_auth", value: "true");
    } else {
      await storage.write(key: "bio_auth", value: "false");
    }
  }

  static Future<bool> readBioAuth() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String value = await storage.read(key: "bio_auth") ?? "false";
    return value.toLowerCase() == 'true';
  }

  static Future<void> storeBdaySeen(bool seenState) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    if (seenState) {
      await storage.write(key: "bdaySeen", value: "true");
    } else {
      await storage.write(key: "bdaySeen", value: "false");
    }
  }

  static Future<bool> readBdaySeen() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String value = await storage.read(key: "bdaySeen") ?? "false";
    return value.toLowerCase() == 'true';
  }

  // static Future<void> storeSessionBioAuth(bool auth) async {
  //   const storage = FlutterSecureStorage(
  //       aOptions: AndroidOptions(
  //     encryptedSharedPreferences: true,
  //   ));
  //   if (auth) {
  //     await storage.write(key: "session_bio_auth", value: "true");
  //   } else {
  //     await storage.write(key: "session_bio_auth", value: "false");
  //   }
  // }

  // static Future<bool> readSessionBioAuth() async {
  //   const storage = FlutterSecureStorage(
  //       aOptions: AndroidOptions(
  //     encryptedSharedPreferences: true,
  //   ));
  //   String value = await storage.read(key: "session_bio_auth") ?? "false";
  //   return value.toLowerCase() == 'true';
  // }
}
