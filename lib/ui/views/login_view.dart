import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/login_model.dart';
import 'package:flutter_firebase_template/ui/app_localizations.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).formEmailHintText,
                    ),
                    validator: (email) {
                      if (!email.contains('@')) {
                        return AppLocalizations.of(context).formEmailValidator;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context).formPasswordHintText,
                    ),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      child: model.state == ViewState.Busy
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  model.login(_emailController.text,
                                      _passwordController.text);
                                }
                              },
                              child: Text(AppLocalizations.of(context)
                                  .loginLoginButton),
                            ),
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      AppLocalizations.of(context).loginRegisterLink,
                      style: TextStyle(
                        color: Colors.red[200],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: model.navigateToRegisterView,
                  ),
                  StreamBuilder<String>(
                    stream: model.errorStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error);
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
