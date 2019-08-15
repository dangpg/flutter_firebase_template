import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/viewmodels/home_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/view_state.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';
import 'package:flutter_firebase_template/ui/widgets/loading_overlay.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) {
        model.getUserData(Provider.of<User>(context).id);
        model.getItems();
      },
      builder: (context, model, child) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              title: Text('Flutter Firebase Template'),
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
                        ),
                        ListTile(
                          title: Text('Item 1'),
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
                          title: Text('Settings'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app),
                          title: Text('Logout'),
                          onTap: () {
                            model.logout();
                          },
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
            body: _buildItemList(context, model, model.items),
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

  Widget _buildItemList(
      BuildContext context, HomeModel model, List<Item> items) {
    return RefreshIndicator(
      onRefresh: model.getItems,
      child: ListView(
        padding: const EdgeInsets.only(top: 5.0),
        children:
            items.map((item) => _buildItem(context, model, item)).toList(),
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
            model.openDetailView(item);
          },
        ),
      ),
    );
  }
}
