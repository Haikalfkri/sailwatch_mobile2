import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalSensorCard extends StatelessWidget {
  final String title;
  final String condition;
  final String value;
  final String imagePath;

  const LocalSensorCard({
    required this.title,
    required this.condition,
    required this.value,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 342,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF34354f).withOpacity(0.9)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${value}",
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            condition,
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        imagePath, // Replace with your humidity-related image
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
