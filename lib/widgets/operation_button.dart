import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OperationButton extends StatelessWidget {
  const OperationButton({Key? key, required this.text, required this.callback})
      : super(key: key);

  final String text;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7.0),
      child: SizedBox(
        width: 73.5,
        height: 73.5,
        child: ElevatedButton(
          onPressed: () => callback(text),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0))),
            backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
            foregroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: text == '÷'
              ? new Text(
                      text,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
              : text == '×'
                  ? new Text(
                      text,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : text == '^'
                      ? new Text(
                      text,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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
