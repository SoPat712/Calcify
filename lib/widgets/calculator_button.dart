import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({Key? key, required this.text, required this.callback}) : super(key: key);

  final String text;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7.0),
      child: SizedBox(
        width: 73.5,
        height: 73.5,
        child: ElevatedButton(
          onPressed: () => callback(text),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0))),
            backgroundColor: MaterialStateProperty.all(Colors.grey),
            foregroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: Text(
            text,
            style: GoogleFonts.rubik(
              textStyle: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
