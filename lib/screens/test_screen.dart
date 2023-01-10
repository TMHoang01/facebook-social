import 'package:flutter/material.dart';

import 'loading_screen.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _loadingNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _loadingNotifier,
        builder: (context, loading, child) {
          if (loading) {
            return LoadingScreen(text: 'Loading...');
          }
          return Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _loadingNotifier.value = true;
                    try {
                      // delay 5s
                      await Future.delayed(Duration(seconds: 5));
                    } finally {
                      _loadingNotifier.value = false;
                    }
                  },
                  child: Text('Make API Request'),
                ),
              ],
            ),
          );
        },
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                _loadingNotifier.value = true;
                try {
                  // perform API request
                } finally {
                  _loadingNotifier.value = false;
                }
              },
              child: Text('Make API Request'),
            ),
          ],
        ),
      ),
    );
  }
}
