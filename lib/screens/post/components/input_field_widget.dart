import 'package:fb_copy/constants.dart';
import 'package:flutter/material.dart';

class EmojiTextField extends StatefulWidget {
  final TextEditingController textController;

  const EmojiTextField({Key? key, required this.textController}) : super(key: key);
  @override
  _EmojiTextFieldState createState() => _EmojiTextFieldState();
}

class _EmojiTextFieldState extends State<EmojiTextField> {
  final TextEditingController _textInputController = TextEditingController();
  int lastChangedLength = 0;

  @override
  void initState() {
    _textInputController.text = widget.textController.text;
    _textInputController.addListener(() {
      widget.textController.text = _textInputController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _textInputController,
        maxLines: null,
        minLines: 2,
        maxLength: 500,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          hintText: 'Bạn đang nghĩ gì?',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: (text) {
          int cursorPos = _textInputController.selection.baseOffset;
          print("cursorPos: $cursorPos ${text[cursorPos - 1]}");

          // check new input is space or not
          if (text[cursorPos - 1] == " ") {
            // check if text before space is emoji or not

            // get text before space
            String textBeforeSpace = text.substring(0, cursorPos - 1);
            // print("textBeforeSpace: $textBeforeSpace");
            // get last word before space
            String lastWord = textBeforeSpace.substring(textBeforeSpace.lastIndexOf(" ") + 1);
            // print("lastWord: $lastWord");
            // check if last word is emoji or not
            if (emojiMap.containsKey(lastWord)) {
              // replace last word with emoji
              String newText = text.replaceFirst(lastWord, emojiMap[lastWord]!);
              print("newText: $newText");
              _textInputController.text = newText;
              _textInputController.selection = TextSelection.fromPosition(TextPosition(offset: cursorPos - 1));
            }
          }
        },
      ),
    );
  }
}
