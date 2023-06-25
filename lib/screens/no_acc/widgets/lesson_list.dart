import 'package:flutter/material.dart';
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
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(DataHelper.allAddedLessons[index].name[0]),
                      ),
                      subtitle: Text(
                          "Credit: ${DataHelper.allAddedLessons[index].creditGrade}, Grade: ${DataHelper.allAddedLessons[index].grade}"),
                    ),
                  ),
                ),
              );
            })
        : Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Text(
                  "Add a lesson!\n\nSwipe the lesson to the right to remove it 🗑️",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            ));
  }
}
