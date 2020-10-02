
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';




googleFont(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.montserrat(fontSize: size, fontWeight: fw, color: color);
}

var defaultImage =
    'https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png';



const textInputDecoration = InputDecoration(
 
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);


