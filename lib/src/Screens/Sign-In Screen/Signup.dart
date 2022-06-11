import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  String name,
      gender,
      email,
      maritalStatus,
      bloodGroup,
      height,
      weight,
      mobile,
      dob;

  List<String> maritalStatuses = [
    'Single',
    'Married',
    'Seperated',
    'Divorced',
    'Widowed'
  ];
  List<String> bloodgroups = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];
  List<String> genders = ['Male', 'Female', 'Other'];

  List<Map> maritalStatusMap = [];
  List<Map> bloodGroupMap = [];
  List<Map> genderMap = [];
  TextEditingController dateCtl = TextEditingController();
  @override
  void initState() {
    for (var i = 0; i < bloodgroups.length; i++) {
      bloodGroupMap.add({
        'label': '${bloodgroups[i]}',
        'value': '${bloodgroups[i]}',
        'icon': Container(
          child: Text(
            '${bloodgroups[i]}',
          ),
        ),
      });
    }
    for (var i = 0; i < maritalStatuses.length; i++) {
      maritalStatusMap.add({
        'label': '${maritalStatuses[i]}',
        'value': '${maritalStatuses[i]}',
        'icon': Container(
          child: Text(
            '${maritalStatuses[i]}',
          ),
        ),
      });
    }
    for (var i = 0; i < genders.length; i++) {
      genderMap.add({
        'label': '${genders[i]}',
        'value': '${genders[i]}',
        'icon': Container(
          child: Text(
            '${genders[i]}',
          ),
        ),
      });
    }

    super.initState();
  }

  _login() async {
    _formKey.currentState.save();
    final requestData = <String, dynamic>{
      "name": name,
      "gender": gender,
      "email": email,
      "date_of_birth": dob,
      "marital_status": maritalStatus,
      "blood_group": bloodGroup,
      "height": height,
      "weight": weight,
      "mobile": mobile,
    };
    final getTokenres = await createAccount(requestData);
    print(getTokenres);
    if (getTokenres["success"]) {
      Navigator.of(context).pushNamed('/splash');
    } else {
      print(requestData);
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
                          onTap: () => Navigator.of(context).pop(),
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
                              'There was an Error in Logging in \n Please try again \n ',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Text("${getTokenres["message"]}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w400))),
                          ],
                        )),
                  ],
                ),
              ),
            );
          });
    }
  }

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
          _formKey.currentState.save();
          _login();
          // _login();
        }, borderRadius: BorderRadius.all(Radius.circular(13))),
      );
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return GestureDetector(
      // onTap: () => FocusScope.of(context).unfocus(),
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
                              decoration: BoxDecoration(
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
                              decoration: BoxDecoration(
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
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/injection.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
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
                            padding: EdgeInsets.all(5),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextFormField(
                                      onSaved: (value) => name = value,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Name",
                                          hintStyle: TextStyle(fontSize: 12),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0,
                                              top: 5),
                                          prefixIcon: Icon(Icons.person,
                                              color: Colors.black54)),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    margin: EdgeInsets.only(top: 20),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextFormField(
                                      onSaved: (value) => mobile = value,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Mobile",
                                          hintStyle: TextStyle(fontSize: 12),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0,
                                              top: 5),
                                          prefixIcon: Icon(Icons.phone,
                                              color: Colors.black54)),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextFormField(
                                      onSaved: (value) => email = value,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Email",
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CoolDropdown(
                                    dropdownList: genderMap,
                                    dropdownItemPadding: EdgeInsets.zero,
                                    onChange: (dropdownItem) {
                                      setState(() {
                                        gender =
                                            dropdownItem["value"].toString();
                                      });
                                    },
                                    dropdownHeight: 80,
                                    dropdownWidth:
                                        MediaQuery.of(context).size.width * 0.5,
                                    resultWidth:
                                        MediaQuery.of(context).size.width,
                                    dropdownItemHeight: 30,
                                    dropdownItemGap: 10,
                                    resultIcon: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 10,
                                          bottom: 0,
                                          top: 5),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <InlineSpan>[
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Icon(
                                                MdiIcons.genderMaleFemale,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    gender ?? "Gender",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    resultIconLeftGap: 0,
                                    resultPadding: EdgeInsets.zero,
                                    resultIconRotation: true,
                                    resultIconRotationValue: 0,
                                    dropdownItemReverse: true,
                                    isDropdownLabel: false,
                                    isResultLabel: false,
                                    isResultIconLabel: false,
                                    isTriangle: false,
                                    dropdownPadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 20),
                                    resultAlign: Alignment.center,
                                    resultMainAxis: MainAxisAlignment.center,
                                    dropdownItemMainAxis:
                                        MainAxisAlignment.center,
                                    resultBD: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    selectedItemBD: BoxDecoration(
                                        color: LightColor.orange.withAlpha(50),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    gap: 20,
                                  ),
                                  // Container(
                                  //   height: 40,
                                  //   alignment: Alignment.center,
                                  //   margin: EdgeInsets.only(top: 20),
                                  //   decoration: BoxDecoration(
                                  //       color:
                                  //           LightColor.lightGrey.withAlpha(100),
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10))),
                                  //   child: TextFormField(
                                  //     onSaved: (value) => gender = value,
                                  //     decoration: InputDecoration(
                                  //         border: InputBorder.none,
                                  //         hintText: "Gender",
                                  //         hintStyle: TextStyle(fontSize: 12),
                                  //         contentPadding: EdgeInsets.only(
                                  //             left: 10,
                                  //             right: 10,
                                  //             bottom: 0,
                                  //             top: 5),
                                  //         prefixIcon: Icon(Icons.people,
                                  //             color: Colors.black54)),
                                  //   ),
                                  // ),
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextFormField(
                                      onSaved: (value) {
                                        dob = value;
                                      },
                                      controller: dateCtl,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "Date Of Birth (DD/MM/YYYY)",
                                          hintStyle: TextStyle(fontSize: 12),
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              bottom: 0,
                                              top: 5),
                                          prefixIcon: Icon(Icons.calendar_today,
                                              color: Colors.black54)),
                                      onTap: () async {
                                        DateTime date = DateTime(1900);
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());

                                        date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100));

                                        dateCtl.text =
                                            '${date.day}/0${date.month}/${date.year}'
                                                .toString();
                                      },
                                    ),
                                  ),
                                  // Container(
                                  //   height: 40,
                                  //   alignment: Alignment.center,
                                  //   margin: EdgeInsets.only(top: 20),
                                  //   decoration: BoxDecoration(
                                  //       color:
                                  //           LightColor.lightGrey.withAlpha(100),
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10))),
                                  //   child: TextFormField(
                                  //     onSaved: (value) => dob = value,
                                  //     decoration: InputDecoration(
                                  //         border: InputBorder.none,
                                  //         hintText:
                                  //             "Date Of Birth (DD/MM/YYYY)",
                                  //         hintStyle: TextStyle(fontSize: 12),
                                  //         contentPadding: EdgeInsets.only(
                                  //             left: 10,
                                  //             right: 10,
                                  //             bottom: 0,
                                  //             top: 5),
                                  //         prefixIcon: Icon(Icons.calendar_today,
                                  //             color: Colors.black54)),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CoolDropdown(
                                    dropdownList: maritalStatusMap,
                                    dropdownItemPadding: EdgeInsets.zero,
                                    onChange: (dropdownItem) {
                                      setState(() {
                                        maritalStatus =
                                            dropdownItem["value"].toString();
                                      });
                                    },
                                    dropdownHeight: 200,
                                    dropdownWidth:
                                        MediaQuery.of(context).size.width * 0.5,
                                    resultWidth:
                                        MediaQuery.of(context).size.width,
                                    dropdownItemHeight: 30,
                                    dropdownItemGap: 10,
                                    resultIcon: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 10,
                                          bottom: 0,
                                          top: 5),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <InlineSpan>[
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Icon(
                                                MdiIcons.humanMaleFemale,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    maritalStatus ??
                                                        "Marital Status",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    resultIconLeftGap: 0,
                                    resultPadding: EdgeInsets.zero,
                                    resultIconRotation: true,
                                    resultIconRotationValue: 0,
                                    dropdownItemReverse: true,
                                    isDropdownLabel: false,
                                    isResultLabel: false,
                                    isResultIconLabel: false,
                                    isTriangle: false,
                                    dropdownPadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 20),
                                    resultAlign: Alignment.center,
                                    resultMainAxis: MainAxisAlignment.center,
                                    dropdownItemMainAxis:
                                        MainAxisAlignment.center,
                                    resultBD: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    selectedItemBD: BoxDecoration(
                                        color: LightColor.orange.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    gap: 20,
                                  ),
                                  SizedBox(height: 20),

                                  CoolDropdown(
                                    dropdownList: bloodGroupMap,
                                    dropdownItemPadding: EdgeInsets.zero,
                                    onChange: (dropdownItem) {
                                      setState(() {
                                        bloodGroup =
                                            dropdownItem["value"].toString();
                                      });
                                    },
                                    dropdownHeight: 300,
                                    dropdownWidth:
                                        MediaQuery.of(context).size.width * 0.5,
                                    resultWidth:
                                        MediaQuery.of(context).size.width,
                                    dropdownItemHeight: 30,
                                    dropdownItemGap: 10,
                                    resultIcon: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                          left: 12,
                                          right: 10,
                                          bottom: 0,
                                          top: 5),
                                      child: RichText(
                                        text: TextSpan(
                                          children: <InlineSpan>[
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: Icon(
                                                MdiIcons.bloodBag,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    bloodGroup ?? "Blood Group",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade700),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    resultIconLeftGap: 0,
                                    resultPadding: EdgeInsets.zero,
                                    resultIconRotation: true,
                                    resultIconRotationValue: 0,
                                    dropdownItemReverse: true,
                                    isDropdownLabel: false,
                                    isResultLabel: false,
                                    isResultIconLabel: false,
                                    isTriangle: false,
                                    dropdownPadding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 20),
                                    selectedItemPadding: EdgeInsets.all(20),
                                    resultAlign: Alignment.center,
                                    resultMainAxis: MainAxisAlignment.center,
                                    dropdownItemMainAxis:
                                        MainAxisAlignment.center,
                                    resultBD: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    selectedItemBD: BoxDecoration(
                                        color: LightColor.orange.withAlpha(50),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    gap: 20,
                                  ),
                                  // Container(
                                  //   height: 40,
                                  //   margin: EdgeInsets.only(top: 20),
                                  //   alignment: Alignment.center,
                                  //   decoration: BoxDecoration(
                                  //       color:
                                  //           LightColor.lightGrey.withAlpha(100),
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10))),
                                  //   child: TextFormField(
                                  //     onSaved: (value) => maritalStatus = value,
                                  //     decoration: InputDecoration(
                                  //       border: InputBorder.none,
                                  //       hintText: "Marital Status",
                                  //       hintStyle: TextStyle(fontSize: 12),
                                  //       contentPadding: EdgeInsets.only(
                                  //           left: 10,
                                  //           right: 10,
                                  //           bottom: 0,
                                  //           top: 5),
                                  //       prefixIcon: Icon(
                                  //         MdiIcons.genderMaleFemale,
                                  //         color: Colors.black54,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   height: 40,
                                  //   alignment: Alignment.center,
                                  //   margin: EdgeInsets.only(top: 20),
                                  //   decoration: BoxDecoration(
                                  //       color:
                                  //           LightColor.lightGrey.withAlpha(100),
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10))),
                                  //   child: TextFormField(
                                  //     onSaved: (value) => bloodGroup = value,
                                  //     decoration: InputDecoration(
                                  //       border: InputBorder.none,
                                  //       hintText: "Blood Group",
                                  //       hintStyle: TextStyle(fontSize: 12),
                                  //       contentPadding: EdgeInsets.only(
                                  //           left: 10,
                                  //           right: 10,
                                  //           bottom: 0,
                                  //           top: 5),
                                  //       prefixIcon: Icon(
                                  //         MdiIcons.bloodBag,
                                  //         color: Colors.black54,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextFormField(
                                      onSaved: (value) => weight = value,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Weight",
                                        hintStyle: TextStyle(fontSize: 12),
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 0,
                                            top: 5),
                                        prefixIcon: Icon(
                                          MdiIcons.weight,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        color:
                                            LightColor.lightGrey.withAlpha(100),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: TextFormField(
                                      onSaved: (value) => height = value,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Height",
                                        hintStyle: TextStyle(fontSize: 12),
                                        contentPadding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 0,
                                            top: 5),
                                        prefixIcon: Icon(
                                          MdiIcons.label,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
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
