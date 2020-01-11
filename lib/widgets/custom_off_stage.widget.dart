import 'package:flutter/material.dart';

class CustomOffStageWidget extends StatelessWidget {
  final _blackVisible;

  CustomOffStageWidget(this._blackVisible);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: _blackVisible,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedOpacity(
          opacity: _blackVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
