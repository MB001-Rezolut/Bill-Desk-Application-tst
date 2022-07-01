import 'package:bill_desk/src/Screens/Home%20Screen/home_screen.dart';
import 'package:flutter/material.dart';


class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => const MainPage(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}