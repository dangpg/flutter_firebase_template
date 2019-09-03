import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/viewmodels/home_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/view_state.dart';
import 'package:flutter_firebase_template/ui/app_localizations.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';
import 'package:flutter_firebase_template/ui/widgets/loading_overlay.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeView extends StatefulWidget {
  final HomeViewArgs homeViewArgs;

  const HomeView({this.homeViewArgs});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) {
        model.getUserData();
        model.getItems();

        if (widget.homeViewArgs?.snackbarMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(widget.homeViewArgs.snackbarMessage),
                action: widget.homeViewArgs.deletedItem != null
                    ? SnackBarAction(
                        label: AppLocalizations.of(context).snackbarActionUndo,
                        onPressed: () {
                          model.undoDeleteItem(widget.homeViewArgs.deletedItem);
                        },
                      )
                    : null,
              ),
            ),
          );
        }
      },
      builder: (context, model, child) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).title),
            ),
            drawer: Drawer(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: model.userData != null
                              ? Text(model.userData.username)
                              : Text(''),
                          accountEmail: model.userData != null
                              ? Text(model.userData.email)
                              : Text(''),
                          currentAccountPicture: GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState.removeCurrentSnackBar();
                              model.navigateToProfileView();
                            },
                            child: model.userData != null
                                ? CircleAvatar(
                                    backgroundColor: Colors.lightBlueAccent,
                                    backgroundImage: model
                                            .userData.avatarUrl.isEmpty
                                        ? Image.memory(kTransparentImage).image
                                        : Image(
                                            image: CachedNetworkImageProvider(
                                                model.userData.avatarUrl),
                                          ).image,
                                    child: model.userData.avatarUrl.isEmpty
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
                                  )
                                : Container(),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.fitness_center),
                          title: Text(AppLocalizations.of(context).homeDrawerItem1Title),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text(AppLocalizations.of(context).homeDrawerSettingsTitle),
                          onTap: () {
                            _scaffoldKey.currentState.removeCurrentSnackBar();
                            model.navigateToSettingsView();
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text(AppLocalizations.of(context).homeDrawerLogoutTitle),
                          onTap: model.logout,
                        ),
                        SizedBox(
                          height: 5.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: _buildItemList(context, model),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await model.createRandomItem();
                await model.getItems();
              },
            ),
          ),
          model.state == ViewState.Busy ? LoadingOverlay() : Container(),
        ],
      ),
    );
  }

  Widget _buildItemList(BuildContext context, HomeModel model) {
    return RefreshIndicator(
      onRefresh: model.getItems,
      child: ListView(
        padding: const EdgeInsets.only(top: 5.0),
        children: model.items
            .map((item) => _buildItem(context, model, item))
            .toList(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, HomeModel model, Item item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: ListTile(
          title: Text(item.title + ' (${item.id})'),
          subtitle: Text(
            item.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          onTap: () {
            _scaffoldKey.currentState.removeCurrentSnackBar();
            model.navigateToDetailView(item);
          },
        ),
      ),
    );
  }
}
