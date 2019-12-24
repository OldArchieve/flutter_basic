import '../constants/constants.dart';
import '../stores/user.store.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import "../widgets/custom_textfield.widget.dart";
import '../business/validator.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_flatbutton.widget.dart';
import '../widgets/custom_alert_dialog.widget.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = "/signIn";
  final Function changeScreen;

  SignInScreen(this.changeScreen);

  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.teal,
      controller: _email,
      hint: "E-mail Adress",
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              child: Text(
                "BASIC",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal,
                  decoration: TextDecoration.none,
                  fontSize: 48.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "OpenSans",
                ),
              ),
              padding: const EdgeInsets.all(70),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5,
                      bottom: 10.0,
                      left: 15.0,
                      right: 10.0),
                  child: Text(
                    "Sign In",
                    softWrap: true,
                    textAlign: TextAlign.center,
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
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 15.0, right: 15.0),
                  child: _emailField,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 20.0, left: 15.0, right: 15.0),
                  child: _passwordField,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 40.0),
                  child: CustomFlatButton(
                    title: "Log In",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () {
                      _emailLogin(
                          email: _email.text,
                          password: _password.text,
                          usersStore: usersStore);
                    },
                    splashColor: Colors.black12,
                    borderColor: Color.fromRGBO(212, 20, 15, 1.0),
                    borderWidth: 0,
                    color: Colors.teal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 40.0),
                  child: CustomFlatButton(
                    title: "Register",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () {
                      widget.changeScreen(Constants.REGISTER_TYPE);
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

  void _emailLogin({String email, String password, final usersStore}) async {
    if (!Validator.validateEmail(email)) {
      _changeBlackVisible();
      _showErrorAlert(
          title: Constants.EMAIL_FAIL,
          content: Constants.EMAIL_FAIL_MESSAGE,
          onPressed: _changeBlackVisible);
    } else if (!Validator.validatePassword(password)) {
      _changeBlackVisible();
      _showErrorAlert(
          title: Constants.PASSWORD_FAIL,
          content: Constants.PASSWORD_FAIL_MESAGE,
          onPressed: _changeBlackVisible);
    } else {
      try {
        _changeBlackVisible();
        await usersStore.userSignIn(email, password);
      } catch (error) {
        _showErrorAlert(
            title: Constants.ERROR_OCCURED,
            content: error.toString(),
            onPressed: _changeBlackVisible);
      }
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
