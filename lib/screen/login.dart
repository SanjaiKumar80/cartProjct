// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:cart/common/constants.dart';
import 'package:cart/data/user_sqlite_helper.dart';
import 'package:cart/model/user_model.dart';
import 'package:cart/screen/registration.dart';
import 'package:cart/screen/tab_view.dart';
import 'package:cart/widget/cart_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final UserDataModel _userDataModel = UserDataModel();
  
  final UserDbProvider _userDbProvider = UserDbProvider();
  SharedPreferences? logindata;
  bool? newuser;
  bool obscureText = true;
  @override
  void initState() {
    super.initState();
    alreadyLogin();
    setState(() {});
  }

  void alreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata!.getBool('login') ?? true);
    // print(newuser);
    if (newuser == false) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ProductTabView()));
    }
  }

  void _submitResult(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    int status = await _userDbProvider.checkLogin(
        _userDataModel.userName.toString(), _userDataModel.password.toString());
    if (status == 1) {
      logindata!.setBool('login', false);
      logindata!.setString('username', _userDataModel.userName.toString());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ProductTabView()));
    } else {
      
      showAlertDialog(context);
      return;
    }
  }

  showAlertDialog(BuildContext context) {

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("user name or password is incorrect"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void toggle() {
    setState(() {
      if (obscureText) {
        obscureText = false;
      } else {
        obscureText = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Container(
                      height: mediaQueryHeight - 235,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 6.0,
                            ),
                          ],
                          border: Border.all(
                            color: Color.fromRGBO(200, 200, 200, 0),
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                     
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(fontSize: 28),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CartTextBox(
                                  withAsterisk: true,
                                  labelText: "Username",
                                  hintText: "Please Enter the UserName",
                                  onError: (value) {
                                    if (value.isEmpty) {
                                      return 'Thisfieldisrequired';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _userDataModel.userName = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: CartTextBox(
                                  withAsterisk: true,
                                  labelText: "Password",
                                  obscureText: obscureText,
                                  hintText: "Please Enter the Password",
                                  onError: (value) {
                                    if (value.isEmpty) {
                                      return 'Thisfieldisrequired';
                                    }
                                    return null;
                                  },
                                  suffixIcon: obscureText
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  suffixIconEvent: toggle,
                                  onSaved: (value) {
                                    _userDataModel.password = value;
                                  },
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 300,
                                    minWidth: 120,
                                    minHeight: 50),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => secondaryTextColor),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              secondaryTextColor),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: secondaryTextColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      _submitResult(context);
                                    },
                                    // ignore: prefer_const_constructors
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      // ignore: prefer_const_constructors
                                      child: Text(
                                        "Login",
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 14,
                                          fontWeight: fontWeight600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 300,
                                    minWidth: 120,
                                    minHeight: 50),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: TextButton(
                                    style: ButtonStyle(
                                      overlayColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => secondaryColor),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              secondaryTextColor),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: secondaryTextColor,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Registration()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: secondaryColor,
                                          fontSize: 14,
                                          fontWeight: fontWeight600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
