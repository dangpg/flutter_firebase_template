import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/viewmodels/home_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/viewstate.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(Provider.of<User>(context).id),
              SizedBox(height: 10.0,),
              model.state == ViewState.Busy ? CircularProgressIndicator() : RaisedButton(
                onPressed: () {
                  model.logout();
                },
                child: Text('Sign Out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
