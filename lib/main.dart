import 'package:bill_desk/src/Configuration/Routes/Routes.dart';
import 'package:bill_desk/src/Screens/Splash%20Screen/Splash%20Screen.dart';
import 'package:bill_desk/src/Themes/theme.dart';
import 'package:bill_desk/src/Widgets/Custom%20Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  getData() async {}

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle.dark,                
        child: MaterialApp(
          title: 'Bill Desk Application',
          theme: AppTheme.lightTheme.copyWith(
            textTheme: GoogleFonts.mulishTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: Routes.getRoute(),
          onGenerateRoute: (RouteSettings settings) {
            if (settings.name!.contains('home')) {
              return CustomRoute<bool>(
                  builder: (BuildContext context) => const Text("Home Screen"));
            } else {
              return CustomRoute<bool>(
                  builder: (BuildContext context) => const SplashScreen());
            }
          },
          initialRoute: "/",
        ));
  }
}
