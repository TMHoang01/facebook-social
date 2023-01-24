import 'package:flutter/material.dart';

Future<void> dialogAlterBuilder(BuildContext context, String title, String content) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${title}'),
        content: Text('${content}'),
        actions: <Widget>[
          // TextButton(
          //   style: TextButton.styleFrom(
          //     textStyle: Theme.of(context).textTheme.labelLarge,
          //   ),
          //   child: const Text('Disable'),
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          // ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> dialogConfirmBuilder(
    BuildContext context, String title, String content, Widget actionWidget, Function? action) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${title}'),
        content: Text('${content}'),
        // actions: actionWidget,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              actionWidget,
              // TextButton(
              //   style: TextButton.styleFrom(
              //     textStyle: Theme.of(context).textTheme.labelLarge,
              //   ),
              //   child: const Text('OK'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //     if (action != null) {
              //       action();
              //     }
              //   },
              // ),
              // TextButton(
              //   style: TextButton.styleFrom(
              //     textStyle: Theme.of(context).textTheme.labelLarge,
              //   ),
              //   child: const Text('Cancel'),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          )
        ],
      );
    },
  );
}
