import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sailwatch_mobile/Pages/SearchPage/widget/searchWeatherCard.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      child: Column(
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  "Pick Location",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  Text(
                    "Find the are or city that you want to know",
                    style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                  Text(
                    "the detailed weather info",
                    style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                height: 55,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFFFFFFF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Cari...',
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
        ]
      )
    ));
  }
}
