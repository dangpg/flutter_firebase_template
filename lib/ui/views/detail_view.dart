import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/detail_model.dart';
import 'package:flutter_firebase_template/core/viewmodels/view_state.dart';
import 'package:flutter_firebase_template/ui/app_localizations.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';
import 'package:flutter_firebase_template/ui/views/detail_view_args.dart';
import 'package:flutter_firebase_template/ui/widgets/loading_overlay.dart';

class DetailView extends StatefulWidget {
  final DetailViewArgs detailViewArgs;

  const DetailView({@required this.detailViewArgs});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailModel>(
      onModelReady: (model) {
        model.item = this.widget.detailViewArgs.item;

        model.snackbarStream.listen(
          (msg) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(msg),
              ),
            );
          },
        );
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          if (!model.pendingChanges) return Future.value(true);

          return await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(AppLocalizations.of(context).showdialogUnsavedChangesWarning),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(AppLocalizations.of(context).showdialogCancel),
                        onPressed: () {
                          model.dismissAlert(false);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          AppLocalizations.of(context).showdialogDiscard,
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          model.revertChanges();
                          model.dismissAlert(true);
                        },
                      )
                    ],
                  );
                },
              ) ??
              false;
        },
        child: Stack(children: <Widget>[
          Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(model.item.title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text(AppLocalizations.of(context).detailDialogDeleteItemTitle),
                            actions: <Widget>[
                              FlatButton(
                                  child: Text(AppLocalizations.of(context).showdialogCancel),
                                  onPressed: () {
                                    model.dismissAlert();
                                  }),
                              FlatButton(
                                child: Text(
                                  AppLocalizations.of(context).detailDialogDeleteItemAction,
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  model.deleteItem(AppLocalizations.of(context).detailItemDeleted);
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: model.pendingChanges ? () {
                    model.updateItem(AppLocalizations.of(context).detailItemUpdated);
                  } : null,
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.item.body),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                model.randomizeItem();
              },
              child: Icon(Icons.casino),
            ),
          ),
          model.state == ViewState.Busy ? LoadingOverlay() : Container(),
        ]),
      ),
    );
  }
}
