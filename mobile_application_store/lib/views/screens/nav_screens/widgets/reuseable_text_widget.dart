import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReuseableTextWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const ReuseableTextWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.w600),),
          Text(subtitle, style: GoogleFonts.quicksand(fontSize:16, fontWeight: FontWeight.w500, color: Colors.blue))
        ],
      ),
    );
  }
}
