import 'package:flutter/material.dart';

class ShowAverage extends StatelessWidget {
  final double average;
  final int numberOfClass;

  const ShowAverage(
      {Key? key, required this.average, required this.numberOfClass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          numberOfClass > 0
              ? "$numberOfClass classes entered"
              : "Enter The Class",
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          average >= 0 ? average.toStringAsFixed(2) : "0.0",
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          "points",
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
