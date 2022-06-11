import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key?key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Null> ?timer;

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  checkConnection() async {
    final bool connection = await InternetConnectionChecker().hasConnection;
    developer.log('Internet Connection', name: '${connection.toString()}');
    if (!connection) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.3,
                    top: MediaQuery.of(context).size.height * 0.3,
                    right: MediaQuery.of(context).size.width * 0.1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => exit(0),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Close",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Oops!",
                      style: GoogleFonts.staatliches(
                          textStyle: TextStyle(
                              shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0, 2),
                                blurRadius: 15),
                          ],
                              fontSize: 40,
                              color: Colors.red,
                              fontWeight: FontWeight.w800)),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Internet Connectivity\n Please try again \n ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle:const TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            );
          });
    } else {
      navigateToAppropriateScreen();
    }
  }

  void navigateToAppropriateScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    timer = Future.delayed(Duration(seconds: 4), () {
      if (token == null || token.isEmpty) {
        print("Login Trigger ---->");
        Navigator.of(context).pushNamed('/home');
      } else {
      print("Home Trigger ---->");
        Navigator.of(context).pushNamed('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child:Image.network('https://images.squarespace-cdn.com/content/v1/542edac6e4b0607b72d46c7d/1554505999358-SZ4NN7NTCZGLO6LRPGFP/energy.gif?format=750w')
            ),
          ),
          
        ],
      ),
    );
  }
}
