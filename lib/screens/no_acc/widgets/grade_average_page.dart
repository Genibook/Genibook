import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/screens/no_acc/helper/data_helper.py.dart';
import 'package:genibook/screens/no_acc/app_constants.dart';
import 'package:genibook/screens/no_acc/utils.dart';
import 'package:genibook/screens/no_acc/model/lesson.dart';
import 'package:genibook/screens/no_acc/widgets/lesson_list.dart';
import 'package:genibook/screens/no_acc/widgets/show_average.dart';

class GradeAveragePage extends StatefulWidget {
  const GradeAveragePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GradeAveragePageState createState() => _GradeAveragePageState();
}

class _GradeAveragePageState extends State<GradeAveragePage> {
  var formKey = GlobalKey<FormState>();
  double selectedGradeValue = 1;
  double selectedCreditValue = 1;
  bool selectedAPorHonors = false;

  var courseName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "GPA calculator",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          ShowAverage(
              average: DataHelper.calculateAvg()[0],
              weightedAverage: DataHelper.calculateAvg()[1],
              numberOfClass: DataHelper.allAddedLessons.length),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: _buildForm(),
                ),
              ],
            ),
          ),
          Expanded(
            child: LessonList(
              onDismiss: (index) {
                DataHelper.allAddedLessons.removeAt(index);
                setState(() {});
              },
            ),
          ),
        ],
      )),
    );
  }

  _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          _buildTextFormField(),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGradePercent(),
              _buildCredits(),
              _buildHonorsCheckBox(),
              IconButton(
                onPressed: _addLessonAndCalAvg,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                iconSize: 30,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  _buildHonorsCheckBox() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("AP/Honors"),
            Checkbox(
                value: selectedAPorHonors,
                onChanged: (bool? honors) {
                  setState(() {
                    selectedAPorHonors = honors ?? false;
                  });
                }),
          ],
        ));
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (value) {
        setState(() {
          courseName = value!;
        });
      },
      validator: (v) {
        if (v!.isEmpty) {
          return "Enter The Course Name.";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: "Course Name (e.g. Mathematics)",
        border: OutlineInputBorder(
            borderRadius: Constants.borderRadius, borderSide: BorderSide.none),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      ),
    );
  }

  _buildGradePercent() {
    return Expanded(
      child: TextFormField(
        onSaved: (value) {},
        validator: (v) {
          if (v!.isEmpty) {
            return "Enter a grade";
          } else if (!isNumeric(v)) {
            return "Enter a valid grade";
          } else if (double.parse(v) < 0) {
            return "Enter a valid grade";
          } else {
            setState(() {
              selectedGradeValue = double.parse(v);
            });
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: "Grade",
          border: OutlineInputBorder(
              borderRadius: Constants.borderRadius,
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
    );
  }

  _buildCredits() {
    return Expanded(
      child: TextFormField(
        onSaved: (value) {},
        validator: (v) {
          if (v!.isEmpty) {
            return "Enter a credit";
          } else if (!isNumeric(v)) {
            return "Enter a valid credit";
          } else {
            setState(() {
              selectedCreditValue = double.parse(v);
            });
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: "Credits",
          border: OutlineInputBorder(
              borderRadius: Constants.borderRadius,
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
    );
  }

  void _addLessonAndCalAvg() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      var addingLesson = Lesson(
          name: courseName,
          grade: selectedGradeValue,
          creditGrade: selectedCreditValue,
          addCredit: selectedAPorHonors);
      DataHelper.addLesson(addingLesson);
      if (kDebugMode) {
        print(DataHelper.calculateAvg());
      }
      setState(() {
        formKey.currentState?.reset();
      });
    }
  }
}
