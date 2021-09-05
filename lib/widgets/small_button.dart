import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({Key? key, required this.text, required this.callback})
      : super(key: key);

  final String text;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: SizedBox(
        width: 50,
        height: 50,
        child: TextButton(
          onPressed: () => callback(text),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0))),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: text == 'del'
              ? new Icon(Icons.backspace, //icon data
                  size: 20, //icon size
                  color: Colors.blueGrey //icon color
                  )
              : Text(
                  text,
                  style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
