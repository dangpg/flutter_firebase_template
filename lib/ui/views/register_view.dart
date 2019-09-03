import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/register_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/view_state.dart';
import 'package:flutter_firebase_template/ui/app_localizations.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterModel>(
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
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .formConfirmPasswordHintText,
                    ),
                    obscureText: true,
                    validator: (confirmPassword) {
                      if (_passwordController.text != confirmPassword) {
                        return AppLocalizations.of(context).formConfirmPasswordValidator;
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      child: model.state == ViewState.Busy
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  model.register(_emailController.text,
                                      _passwordController.text);
                                }
                              },
                              child: Text(AppLocalizations.of(context)
                                  .registerRegisterButton),
                            ),
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
