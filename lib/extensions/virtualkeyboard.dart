import 'package:flutter/widgets.dart';

extension VirtualKeyboard on BuildContext {
  /// is dark mode currently enabled?
  bool get virtualKeyboardIsOpen {
    return MediaQuery.of(this).viewInsets.bottom > 0;
  }
}
