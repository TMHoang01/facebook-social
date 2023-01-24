import 'package:fb_copy/constants.dart';
import 'package:flutter/material.dart';

void showModal(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Column(
            children: widget,
          ),
          decoration: BoxDecoration(color: Theme.of(context).cardColor));
    },
  );
}

void showModalFullSheet(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return SafeArea(
        minimum: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),

        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Báo cáo',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColor.kColorTextNormal),
            ),
            backgroundColor: AppColor.backgroundColor,
          ),
        ),
        // child: Container(
        // height: double.infinity,
        // child: Expanded(
        //     child: Column(
        //       children: widget,
        //     )),
        // decoration: BoxDecoration(color: Theme.of(context).canvasColor))
      );
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Báo cáo',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.kColorTextNormal),
          ),
          backgroundColor: AppColor.backgroundColor,
        ),
      );
    },
  );
}
