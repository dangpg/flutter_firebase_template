import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Opacity(
        opacity: 0.5,
        child: Container(
          color: Colors.grey[700],
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
