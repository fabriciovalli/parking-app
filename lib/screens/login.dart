import 'package:app4car/colors.dart';
import 'package:app4car/utils/app4car.dart';
import 'package:app4car/utils/app4car_navigator.dart';
import 'package:app4car/widgets/buttons.dart';
import 'package:app4car/widgets/password_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          child: new SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                Image.asset('assets/logo.png'),
                SizedBox(
                  height: 80.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: App4Car.username,
                  ),
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 12.0,
                ),
                PasswordField(
                  label: App4Car.password,
                ),
                SizedBox(
                  height: 30.0,
                ),
                RoundButton(
                  text: App4Car.login,
                  onPressed: () => App4CarNavigator.goToHome(context),
                  color: Theme.of(context).buttonColor,
                  height: 50.0,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: <Widget>[
                    Text('Não tem conta?', style: Theme.of(context).textTheme.caption.copyWith(color: kApp4CarBlueBorder),),
                    FlatButton(
                      padding: EdgeInsets.all(0.0),
                      textColor: Theme.of(context).buttonColor,
                      onPressed: () {},
                      child: const Text('Cadastre-se!'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
