import 'package:flutter/material.dart';
import 'package:genibook/screens/no_acc/app_constants.dart';
import 'package:genibook/screens/no_acc/helper/data_helper.py.dart';

class LetterDropdownWidget extends StatefulWidget {
  final Function onLetterSelected;
  const LetterDropdownWidget({required this.onLetterSelected, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LetterDropdownWidgetState createState() => _LetterDropdownWidgetState();
}

class _LetterDropdownWidgetState extends State<LetterDropdownWidget> {
  double selectedLetterValue = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Constants.dropDownPadding,
      decoration: BoxDecoration(
          borderRadius: Constants.borderRadius,
          color: Constants.mainColor.shade100.withOpacity(0.3)),
      child: DropdownButton<double>(
        value: selectedLetterValue,
        elevation: 16,
        iconEnabledColor: Constants.mainColor,
        onChanged: (selectedValue) {
          setState(() {
            selectedLetterValue = selectedValue!;
            widget.onLetterSelected(selectedLetterValue);
          });
        },
        underline: Container(),
        items: DataHelper.allGradeLetters(),
      ),
    );
  }
}
