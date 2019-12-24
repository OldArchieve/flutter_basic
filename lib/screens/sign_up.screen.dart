import 'dart:core';
import '../constants/constants.dart';
import '../stores/user.store.dart';
import "package:flutter/material.dart";
import "../widgets/custom_textfield.widget.dart";
import '../business/validator.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_flatbutton.widget.dart';

import '../widgets/custom_alert_dialog.widget.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/auth-screen';

  final Function changeScreen;

  SignUpScreen(this.changeScreen);

  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _confirmEmail = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _confirmEmailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;

  @override
  void initState() {
    super.initState();

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.teal,
      controller: _email,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _confirmEmailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.teal,
      controller: _confirmEmail,
      hint: "Confirm E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );

    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.teal,
      controller: _password,
      obscureText: true,
      hint: "Password",
      validator: Validator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    final usersStore = Provider.of<UsersStore>(context);
    return Stack(
      children: <Widget>[
        Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Text(
                    "Create new account",
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.teal,
                      decoration: TextDecoration.none,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: _emailField,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: _confirmEmailField,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: _passwordField,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 40.0),
                  child: CustomFlatButton(
                    title: "Sign Up",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () {
                      _signUp(
                          confirmEmail: _confirmEmail.text,
                          email: _email.text,
                          password: _password.text,
                          usersStore: usersStore);
                    },
                    splashColor: Colors.black12,
                    borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                    borderWidth: 0,
                    color: Colors.teal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 25.0, horizontal: 40.0),
                  child: CustomFlatButton(
                    title: "Back to Login",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () {
                      widget.changeScreen(Constants.LOGIN_TYPE);
                    },
                    splashColor: Colors.black12,
                    borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                    borderWidth: 0,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
        Offstage(
          offstage: !_blackVisible,
          child: GestureDetector(
            onTap: () {},
            child: AnimatedOpacity(
              opacity: _blackVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }

  void _signUp(
      {String confirmEmail,
      String email,
      String password,
      final usersStore}) async {
    if (!Validator.validateEmail(email)) {
      _changeBlackVisible();
      _showErrorAlert(
          title: Constants.EMAIL_FAIL,
          content: Constants.EMAIL_FAIL_MESSAGE,
          onPressed: _changeBlackVisible);
    } else if (!Validator.validateEmail(confirmEmail)) {
      _changeBlackVisible();
      _showErrorAlert(
          title: Constants.CONFIRM_EMAIL_FAIL,
          content: Constants.CONFIRM_EMAIL_FAIL_MESSAGE,
          onPressed: _changeBlackVisible);
    } else if (!Validator.validatePassword(password)) {
      _changeBlackVisible();
      _showErrorAlert(
          title: Constants.PASSWORD_FAIL,
          content: Constants.PASSWORD_FAIL_MESAGE,
          onPressed: _changeBlackVisible);
    } else if (!Validator.validateEmailMatch(email, confirmEmail)) {
      _changeBlackVisible();
      _showErrorAlert(
          title: Constants.EMAIL_NO_MATCH,
          content: Constants.EMAIL_DOES_NOT_MATCH_MESSAGE,
          onPressed: _changeBlackVisible);
    } else {
      await usersStore.userSignUp(email, password);
    }
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }
}
