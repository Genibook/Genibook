import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:genibook/constants.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

/// Returns the value written to the TOS key as a bool
Future<bool> writeTOS() async {
  String value = await storage.read(key: Constants.tosReadKey) ?? "false";

  bool b = value.toLowerCase() == 'true';
  if (b) {
    //value == true
    await storage.write(key: Constants.tosReadKey, value: "false");
    return false;
  } else {
    //value == false
    await storage.write(key: Constants.tosReadKey, value: "true");
    return true;
  }
}

// void teststuff() async {
//   await storage.write(key: "test", value: "hi");
//   String value = await storage.read(key: "test") ?? "";

// // Read all values
//   Map<String, String> allValues = await storage.readAll();

// // Delete value
//   await storage.delete(key: "test");

// // Delete all
//   await storage.deleteAll();

//   print(value);
//   print(allValues);

// // Write value
// }
