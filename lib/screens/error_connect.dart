import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ErrorConnect extends StatefulWidget {
  final AppBar? appBar;
  Function? onTap;

  ErrorConnect({this.appBar, this.onTap});

  @override
  _ErrorConnectState createState() => _ErrorConnectState(appBar: appBar, onTap: onTap);
}

class _ErrorConnectState extends State<ErrorConnect> {
  final AppBar? appBar;
  Function? onTap;

  _ErrorConnectState({this.appBar, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 150),
          IconButton(
              icon: Icon(MdiIcons.wifiOff),
              iconSize: 70,
              onPressed: () {
                print("Er connect");
              }),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Đã xảy ra lỗi. Nhấp để thử lại")],
            ),
            onTap: () {
              print(" Nhấp để thử lại");
              onTap!();
            },
          )
        ],
      ),
    );
  }
}
