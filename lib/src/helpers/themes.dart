import 'package:flutter/material.dart';

class Themes {
  static const Map<int, Color> _pink = {
    50: Color(0xffffeded),
    100: Color(0xffffd3d3),
    200: Color(0xffffb5b5),
    300: Color(0xffff9797),
    400: Color(0xffff8181),
    500: Color(0xffff6b6b),
    600: Color(0xffff6363),
    700: Color(0xffff5858),
    800: Color(0xffff4e4e),
    900: Color(0xffff3c3c),
  };

  static const MaterialColor pink = MaterialColor(0xffff6b6b, _pink);
}
