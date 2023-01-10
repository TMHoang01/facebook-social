import 'package:flutter/material.dart';

class DivederApp extends StatelessWidget {
  const DivederApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[400],
      width: MediaQuery.of(context).size.width,
      height: 10.0,
    );
  }
}
