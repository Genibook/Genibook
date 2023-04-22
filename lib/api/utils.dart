import 'package:genibook/constants.dart';

Uri getCorrectUri(String ending) {
  Uri url;
  if (Constants.url.startsWith("127")) {
    url = Uri.http(Constants.url, ending);
  } else {
    //url is https
    url = Uri.https(Constants.url, ending);
  }

  return url;
}
