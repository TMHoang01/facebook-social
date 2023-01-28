import 'package:fb_copy/constants.dart';
import 'package:flutter/material.dart';

void showModal(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
    // isScrollControlled: true,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: widget,
      );
    },
  );
}

void showModalFullSheet(BuildContext context, List<Widget> widget) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (context) {
      // return Scaffold(
      //   // resizeToAvoidBottomInset: false,
      //   appBar: AppBar(
      //     title: const Text(
      //       'Báo cáo',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(color: AppColor.kColorTextNormal),
      //     ),
      //     backgroundColor: AppColor.backgroundColor,
      //   ),
      //   body: Container(
      //     color: Colors.green,
      //   ),
      // );
      return Container(
        height: MediaQuery.of(context).size.height - 32,
        // margin: EdgeInsets.only(top: 24),
        color: Colors.black12,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            // Container(
            //   height: 8,
            //   width: 50,
            //   decoration: BoxDecoration(
            //     color: Colors.grey,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
            ...widget,
          ],
        ),
      );
    },
  );
}
