import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/profile_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/view_state.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';
import 'package:flutter_firebase_template/ui/views/loading_view.dart';
import 'package:flutter_firebase_template/ui/widgets/loading_overlay.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController _usernameController;
  TextEditingController _firstnameController;
  TextEditingController _lastnameController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // We cannot use TextEditingController here because of the async call to retrieve userdata

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileModel>(
      onModelReady: (model) async {
        await model.getUserData();
        _usernameController =
            TextEditingController(text: model.userData.username);
        _firstnameController =
            TextEditingController(text: model.userData.firstname);
        _lastnameController =
            TextEditingController(text: model.userData.lastname);
      },
      builder: (context, model, child) => model.userData == null
          ? LoadingView()
          : WillPopScope(
              onWillPop: () async {
                model.updateDirtyUserData(_usernameController.text,
                    _firstnameController.text, _lastnameController.text);

                if (!model.pendingChanges) return Future.value(true);

                return await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Unsaved changes will be lost'),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('CANCEL'),
                              onPressed: () {
                                model.dismissAlert(false);
                              },
                            ),
                            FlatButton(
                              child: Text(
                                'DISCARD',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                model.dismissAlert(true);
                              },
                            )
                          ],
                        );
                      },
                    ) ??
                    false;
              },
              child: Stack(
                children: <Widget>[
                  Scaffold(
                    appBar: AppBar(
                      title: Text('Profile View'),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              model.updateDirtyUserData(
                                  _usernameController.text,
                                  _firstnameController.text,
                                  _lastnameController.text);
                              await model.saveProfile();
                            }
                          },
                        ),
                      ],
                    ),
                    body: Center(
                      child: ListView(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 50.0,
                              ),
                              Stack(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 75.0,
                                    backgroundColor: Colors.lightBlueAccent,
                                    backgroundImage: model
                                                .userData.avatarUrl.isEmpty &&
                                            model.imageFile == null
                                        ? Image.memory(kTransparentImage).image
                                        : model.imageFile != null
                                            ? Image.file(model.imageFile).image
                                            : Image(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        model.userData
                                                            .avatarUrl),
                                              ).image,
                                    child: model.userData.avatarUrl.isEmpty &&
                                            model.imageFile == null
                                        ? Text(
                                            model.userData.email
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: new RawMaterialButton(
                                      constraints: BoxConstraints(
                                        minHeight: 40.0,
                                        maxHeight: 40.0,
                                        minWidth: 40.0,
                                        maxWidth: 40.0,
                                      ),
                                      onPressed: () => model.getImage(),
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.red,
                                        size: 25.0,
                                      ),
                                      shape: new CircleBorder(),
                                      elevation: 2.0,
                                      fillColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: _usernameController,
                                        decoration: InputDecoration(
                                          labelText: 'Username (optional)',
                                          hintText: 'Username',
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _firstnameController,
                                        decoration: InputDecoration(
                                          labelText: 'First name (optional)',
                                          hintText: 'First name',
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _lastnameController,
                                        decoration: InputDecoration(
                                          labelText: 'Last name (optional)',
                                          hintText: 'Last name',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  model.state == ViewState.Busy
                      ? LoadingOverlay()
                      : Container(),
                ],
              ),
            ),
    );
  }
}
