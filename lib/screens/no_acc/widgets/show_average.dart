import 'package:flutter/material.dart';

class ShowAverage extends StatelessWidget {
  final double average;
  final int numberOfClass;

  const ShowAverage(
      {Key? key, required this.average, required this.numberOfClass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Text(
              "Unweighted GPA: ",
              textAlign: TextAlign.center,
            ),
            Text(
              average >= 0 ? average.toStringAsFixed(2) : "0.0",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "Weighted GPA: ",
              textAlign: TextAlign.center,
            ),
            Text(
              average >= 0 ? average.toStringAsFixed(2) : "0.0",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
