import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/ui/views/base_view.dart';

class TemplateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<BaseModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Container(),
    );
  }
}
