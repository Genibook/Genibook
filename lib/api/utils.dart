import 'package:flutter/foundation.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/constants.dart';

Uri getCorrectUri(String ending, Map<String, String> map) {
  Uri url;
  if (Constants.url.startsWith("127") ||
      Constants.url.startsWith("19") ||
      Constants.url.startsWith("10")) {
    if (kDebugMode) {
      if (Constants.debugModePrintEVERYTHING) {
        print(Constants.url);
        print(ending);
      }
    }

    url = Uri.http(
      Constants.url,
      ending,
      map,
    );
    //url example: const String URL = "127.0.0.1:6969";
    // url = Uri.http(Constants.url, ending, );
  } else {
    //url is https
    url = Uri(
      host: Constants.url,
      path: ending,
      scheme: "https",
      queryParameters: map,
    );
  }

  return url;
}

Future<void> refreshAllData(bool backgroundTask) async {
  //Student stud =
  await ApiHandler.getNewStudent(false, backgroundTask);
  await ApiHandler.getNewSchedule(false);
  await ApiHandler.getMPs(false);
  await ApiHandler.getGPAhistory(false);
  await ApiHandler.getGpa(false);

  if (backgroundTask) {
    await ApiHandler.postThisIsABGcall();
  }
  // return stud;
}

// Future<void> refreshGPAHistory() async {
//   await ApiHandler.getGPAhistory(false);
// }
