import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:genibook/constants.dart';
import 'package:genibook/models/student_class.dart';
import 'package:genibook/utils/grades_utils.dart';

import 'package:url_launcher/url_launcher.dart';

List<Widget> generateUnDetailedProfileInfo(
    Student student, BuildContext context) {
  List<Widget> ret = [
    ListTile(
      title: Text(
        "Counselor Name",
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
      ),
      trailing: Text(
        student.counselorName,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
      ),
    ),
    ListTile(
      title: Text(
        "Locker",
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
      ),
      trailing: Text(
        student.locker,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
      ),
    ),
    ListTile(
      title: Text(
        "Grade",
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
      ),
      trailing: Text(
        "${student.grade}",
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
      ),
    ),
  ];

  return ret;
}

List<Widget> generateGPAHistories(
    Map<String, dynamic> data, int grade, BuildContext context) {
  if (kDebugMode) {
    if (Constants.debugModePrintEVERYTHING) {
      print("[DEBUG generateGPAHistories]: data given in param $data");
    }
  }

  //TODO: add grade check support
  // lets do like grade+1 - 9
  // if that value is greater > 0, get that value then sum (loop) it only that amount of times
  // if it is not, just calculate the cummulative normally.
  //

  List<Widget> ret = [];

  int lengthOfCourses = 0;
  double sumOfWeighted = 0;
  double sumOfUnWeighted = 0;

  for (var key in data.keys.toList().reversed) {
    dynamic value = data[key];

    double unweighted = value["unweighted"] ?? 0.0;
    double weighted = value["weighted"] ?? 0.0;

    if (key != "Current") {
      sumOfWeighted += weighted;
      sumOfUnWeighted += unweighted;
      lengthOfCourses++;
    }

    Widget tile = ListTile(
      title: Text(
        key,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      trailing: SizedBox(
          width: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              "$weighted",
              style: TextStyle(
                  color: getColorFromGrade(weighted),
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize),
            ),
            const Text("|"),
            Text("$unweighted",
                style: TextStyle(
                    color: getColorFromGrade(weighted),
                    fontSize:
                        Theme.of(context).textTheme.bodyMedium!.fontSize)),
          ])),
    );

    ret.add(tile);
  }

  if (lengthOfCourses != 0) {
    double averagedWeightedGpa =
        roundDouble(sumOfWeighted / lengthOfCourses, 2);
    double averagedUnWeightedGpa =
        roundDouble(sumOfUnWeighted / lengthOfCourses, 2);
    ret.insert(
        0,
        ListTile(
          title: Text(
            "Cummulative",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: SizedBox(
              width: 100,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  "$averagedWeightedGpa",
                  style: TextStyle(
                      color: getColorFromGrade(averagedWeightedGpa),
                      fontSize:
                          Theme.of(context).textTheme.bodyMedium!.fontSize),
                ),
                const Text("|"),
                Text("$averagedUnWeightedGpa",
                    style: TextStyle(
                        color: getColorFromGrade(averagedUnWeightedGpa),
                        fontSize:
                            Theme.of(context).textTheme.bodyMedium!.fontSize)),
              ])),
        ));
  }

  ret.insert(
      0,
      ListTile(
        title: Text(
          "Year",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        trailing: SizedBox(
          width: 200,
          child: Text(
            "Weighted|Unweighted",
            textAlign: TextAlign.end,
            style: Theme.of(context)
                .textTheme
                .copyWith(
                  titleMedium:
                      Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                )
                .titleMedium,
          ),
        ),
      ));

  return ret;
}

// ignore: non_constant_identifier_names
Future<void> LaunchUrl(String urll) async {
  final Uri url = Uri.parse(urll);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
