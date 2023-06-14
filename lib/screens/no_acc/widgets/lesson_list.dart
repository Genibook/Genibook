import 'package:flutter/material.dart';
import 'package:genibook/screens/no_acc/app_constants.dart';
import 'package:genibook/screens/no_acc/helper/data_helper.py.dart';

class LessonList extends StatelessWidget {
  final Function onDismiss;
  const LessonList({required this.onDismiss, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataHelper.allAddedLessons.isNotEmpty
        ? ListView.builder(
            itemCount: DataHelper.allAddedLessons.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (a) {
                  onDismiss(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(DataHelper.allAddedLessons[index].name),
                      leading: CircleAvatar(
                          backgroundColor: Constants.mainColor,
                          child: Text((DataHelper
                                      .allAddedLessons[index].letterGrade *
                                  DataHelper.allAddedLessons[index].creditGrade)
                              .toStringAsFixed(0))),
                      subtitle: Text(
                          "Credit: ${DataHelper.allAddedLessons[index].creditGrade}, Letter Grade: ${DataHelper.allAddedLessons[index].letterGrade}"),
                    ),
                  ),
                ),
              );
            })
        : Container(
            alignment: Alignment.center,
            child: Text("Please Add Lesson.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall),
          );
  }
}
