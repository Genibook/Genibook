import 'package:flutter/widgets.dart';

extension Dimensions on BuildContext {
  /// is dark mode currently enabled?
  double get getWidth {
    Size screenSize = MediaQuery.of(this).size;
    return screenSize.width;
  }

  double get getHeight {
    Size screenSize = MediaQuery.of(this).size;
    return screenSize.height;
  }
}
