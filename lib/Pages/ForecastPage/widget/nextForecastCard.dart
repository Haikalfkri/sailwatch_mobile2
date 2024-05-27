import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class nextForecastCard extends StatelessWidget {
  final String day;
  final String date;
  final String temperature;
  final String iconPath;

  const nextForecastCard({
    required this.day,
    required this.date,
    required this.temperature,
    required this.iconPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Color(0xFF34354f).withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              temperature,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.normal,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            Image.asset(
              iconPath,
              width: 50,
            )
          ],
        ),
      ),
    );
  }
}