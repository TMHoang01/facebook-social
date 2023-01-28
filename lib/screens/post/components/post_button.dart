import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final Icon icon;
  final Text label;
  final Function onTap;

  const PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          InkWell(
            onTap: () => onTap(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: icon,
                ),
                const SizedBox(width: 4.0),
                label
              ],
            ),
          ),
          const SizedBox(height: 1.0),
        ],
      ),
    );
  }
}
