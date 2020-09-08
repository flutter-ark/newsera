import 'dart:ui';

class NotchUtil {
  bool checkNotch() {
    return (window.viewPadding.top > 0 || window.viewPadding.bottom > 0)
        ? true
        : false;
  }
}
