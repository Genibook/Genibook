import 'package:genibook/api/handler.dart';
import 'package:genibook/constants.dart';

Uri getCorrectUri(String ending, Map<String, String> map) {
  Uri url;
  if (Constants.url.startsWith("127")) {
    url = Uri(
      host: Constants.url,
      path: ending,
      scheme: "http",
      queryParameters: map,
    );
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

Future<void> refreshAllData() async {
  await ApiHandler.getNewStudent(false);
  await ApiHandler.getNewSchedule(false);
  await ApiHandler.getMPs(false);
}
