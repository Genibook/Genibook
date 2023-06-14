import 'package:flutter/material.dart';
import 'package:genibook/screens/no_acc/helper/data_helper.py.dart';

class CreditDropdownWidget extends StatefulWidget {
  final Function onCreditSelected;
  const CreditDropdownWidget({required this.onCreditSelected, Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreditDropdownWidgetState createState() => _CreditDropdownWidgetState();
}

class _CreditDropdownWidgetState extends State<CreditDropdownWidget> {
  double selectedCreditValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: DropdownButton<double>(
        value: selectedCreditValue,
        elevation: 16,
        iconEnabledColor: Theme.of(context).highlightColor,
        onChanged: (selectedValue) {
          setState(() {
            selectedCreditValue = selectedValue!;
            widget.onCreditSelected(selectedCreditValue);
          });
        },
        underline: Container(),
        items: DataHelper.allClassesOfCredits(),
      ),
    );
  }
}
