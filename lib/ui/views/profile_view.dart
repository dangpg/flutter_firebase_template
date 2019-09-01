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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // We cannot use TextEditingController here because of the async call to retrieve userdata

  final FocusNode _focusNodeUsername = FocusNode();
  final FocusNode _focusNodeFirstname = FocusNode();
  final FocusNode _focusNodeLastname = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileModel>(
      onModelReady: (model) {
        model.getUserData();

        // TODO: better solution?
        _focusNodeUsername.addListener(model.onTextFieldFocus);
        _focusNodeFirstname.addListener(model.onTextFieldFocus);
        _focusNodeLastname.addListener(model.onTextFieldFocus);
      },
      builder: (context, model, child) => model.userData == null
          ? LoadingView()
          : WillPopScope(
              onWillPop: () async {
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              model.saveProfile();
                              // model.saveProfile();
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
                                        initialValue: model.userData.username,
                                        decoration: InputDecoration(
                                          labelText: 'Username (optional)',
                                          hintText: 'Username',
                                        ),
                                        focusNode: _focusNodeUsername,
                                        onSaved: (value) =>
                                            model.userData.username = value,
                                      ),
                                      TextFormField(
                                        initialValue: model.userData.firstname,
                                        decoration: InputDecoration(
                                          labelText: 'First name (optional)',
                                          hintText: 'First name',
                                        ),
                                        focusNode: _focusNodeFirstname,
                                        onSaved: (value) =>
                                            model.userData.firstname = value,
                                      ),
                                      TextFormField(
                                        initialValue: model.userData.lastname,
                                        decoration: InputDecoration(
                                          labelText: 'Last name (optional)',
                                          hintText: 'Last name',
                                        ),
                                        focusNode: _focusNodeLastname,
                                        onSaved: (value) =>
                                            model.userData.lastname = value,
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
