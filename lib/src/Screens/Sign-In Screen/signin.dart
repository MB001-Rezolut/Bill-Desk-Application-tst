import 'package:bill_desk/src/Configuration/Animations/Fade%20Animations.dart';
import 'package:bill_desk/src/Themes/light_color.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
  }

  late String email, password;


  @override
  Widget build(BuildContext context) {
    Widget _buttonCommand(String commandText, context) {
      return Container(
        child: Container(
          height: 50,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
          ),
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.blueGrey.withAlpha(100),
                    offset: Offset(1.1, 1.1),
                    blurRadius: 6.0)
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 93, 224, 250).withOpacity(0.6),
                LightColor.orange,
              ])),
          child: Center(
            child: Text(
              commandText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ).ripple(() {
          _login();
        }, borderRadius: BorderRadius.all(Radius.circular(13))),
      );
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          reverse: true,
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/sign_in_out_header.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 20,
                        width: 80,
                        top: 30,
                        height: 200,
                        child: FadeAnimation(
                            2,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/emergency.png'))),
                            )),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.5 - 40,
                        width: 80,
                        top: 10,
                        height: 150,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/heart.png'))),
                            )),
                      ),
                      Positioned(
                        right: 20,
                        width: 80,
                        top: 30,
                        height: 200,
                        child: FadeAnimation(
                            2,
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/injection.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin:const EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Avid Mart",
                                  style: GoogleFonts.staatliches(
                                      textStyle: TextStyle(
                                          shadows: [
                                        Shadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            offset: Offset(0, 2),
                                            blurRadius: 15),
                                      ],
                                          fontSize: 40,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800)),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.06,
                      right: MediaQuery.of(context).size.width * 0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: const TextFormField(
                                      onSaved: (value) => email = value!,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email or Phone number",
                                          hintStyle: TextStyle(fontSize: 12),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0,
                                              top: 5),
                                          prefixIcon: Icon(Icons.email,
                                              color: Colors.black54)),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextFormField(
                                      onSaved: (value) => password = value,
                                      obscureText: _passwordVisible,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(fontSize: 12),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0,
                                              top: 5),
                                          suffixIcon: GestureDetector(
                                              onTap: () => {
                                                    if (_passwordVisible)
                                                      {
                                                        setState(() {
                                                          _passwordVisible =
                                                              false;
                                                        })
                                                      }
                                                    else
                                                      {
                                                        setState(() {
                                                          _passwordVisible =
                                                              true;
                                                        })
                                                      }
                                                  },
                                              child: _passwordVisible
                                                  ? Icon(Icons.visibility_off)
                                                  : Icon(Icons.visibility)),
                                          prefixIcon: Icon(Icons.password,
                                              color: Colors.black54)),
                                    ),
                                  ),
                                  FadeAnimation(
                                      1.5,
                                      GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Forgot Password?",
                                            textAlign: TextAlign.right,
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blueGrey,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(2, _buttonCommand("Login", context)),
                      Padding(
                          padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context)
                                      .viewInsets
                                      .bottom) *
                              0.6),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Or",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 10,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w500)),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.of(context).pushNamed('/login_otp');
                            //   },
                            //   child: FadeAnimation(
                            //       1.5,
                            //       Text(
                            //         "Login with OTP",
                            //         style: GoogleFonts.poppins(
                            //             textStyle: TextStyle(
                            //                 fontSize: 14,
                            //                 color: Colors.blueGrey,
                            //                 fontWeight: FontWeight.w500)),
                            //       )),
                            // ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('/login_otp');
                              },
                              child: FadeAnimation(
                                  1.5,
                                  Text(
                                    "Create Account",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.w500)),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: FadeAnimation(
                            1.5,
                            Text(
                              "Terms and Conditions !!",
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500)),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
