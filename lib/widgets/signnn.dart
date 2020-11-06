import 'package:assessment_app/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../model/http_exception.dart';
// import 'package:login_test/dashbord/app_theme.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService service = AuthService();
  bool _isLoading = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    try {
      service.signUp(_authData["email"], _authData["password"]);
    } on HttpException catch (error) {
      var errorMessage = "Authentication Failed";
      if (error.toString().contains("EMAIL_EXISTS")) {
        errorMessage = "This email address is already in use";
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = "This is not a valid email address";
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = "This password is too weak";
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Could not find a user with that email";
      } else if (error.toString().contains("INVALID_PASSOWRD")) {
        errorMessage = "Invalid password";
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = "Could Not authenticate you. Please try again Later";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("An Error Occured!"),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text("Okay"),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
  }

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: deviceSize.height,
          decoration: BoxDecoration(
            // color: Theme.of(context).primaryColor,
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.05), BlendMode.dstATop),
              image: AssetImage('assets/images/mountains.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(100.0),
                    child: Center(
                      child: Icon(
                        Icons.cloud,
                         color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child:  Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child:  Text(
                            "EMAIL",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                               color: Theme.of(context).primaryColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: deviceSize.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                             color: Theme.of(context).primaryColor,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: TextFormField(
                      // decoration: InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }else return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value;
                      },
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child:  Text(
                            "PASSWORD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                               color: Theme.of(context).primaryColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: deviceSize.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                             color: Theme.of(context).primaryColor,
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: TextFormField(
                      // decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                        else return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value;
                      },
                    ),
                  ),
                  Divider(
                    height: 24.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child:  Text(
                            "CONFIRM PASSWORD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                               color: Theme.of(context).primaryColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: deviceSize.width,
                    margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 0.5,
                            style: BorderStyle.solid),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                    child: TextFormField(
                      // decoration:
                      // InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator:  (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                        else return null;
                      }

                    ),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: new FlatButton(
                          child: new Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Theme.of(context).primaryColor
                            ),
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ],
                  ),
                    Container(
                      width: deviceSize.width,
                      margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
                      alignment: Alignment.center,
                      child:  Row(
                        children: <Widget>[
                          Expanded(
                            child:  FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              onPressed:  _submit,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: _isLoading ? CircularProgressIndicator() : Text(
                                        "SIGN UP",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
