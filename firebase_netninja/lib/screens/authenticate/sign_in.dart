import 'package:firebase_netninja/screens/authenticate/register.dart';
import 'package:firebase_netninja/services/auth.dart';
import 'package:firebase_netninja/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_netninja/shared/loading.dart';

class SignIn extends StatefulWidget {
  /* Authenticate sayfasından gelen toggleView için
       constructor oluşturalım.                     */
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //textfield state
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("Sign in "),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () => {
                          widget.toggleView(),
                        },
                    icon: Icon(Icons.person),
                    label: Text("Register")),
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? "Enter an e-mail" : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          validator: (val) => val.length < 6
                              ? "Enter a password 6+ or long"
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        RaisedButton(
                            color: Colors.pink[400],
                            child: Text(
                              "Sign in",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = "Wrong id or pass. Try again";
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(
                          height: 15.0,
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ],
                    ))),
          );
  }
}
