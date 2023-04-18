import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

void teststuff() async {
  await storage.write(key: "test", value: "hi");
  String value = await storage.read(key: "test") ?? "";

// Read all values
  Map<String, String> allValues = await storage.readAll();

// Delete value
  await storage.delete(key: "test");

// Delete all
  await storage.deleteAll();

  print(value);
  print(allValues);

// Write value
}
