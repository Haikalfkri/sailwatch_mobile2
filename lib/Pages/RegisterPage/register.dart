import 'package:sailwatch_mobile2/LoginPage/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(229, 235, 243, 1),
        body: ListView(
          children: [
            SizedBox(height: 10), // Adjust the height as needed
            Center(
              child: Image.asset(
                'assets/images/logo_auth.png',
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // INPUT NAMA
                  Text(
                    'Nama',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Masukkan nama lengkap',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/name_icon.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // INPUT EMAIL
                  Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'user123@gmail.com',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/email_icon.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // INPUT SANDI
                  Text(
                    'Kata sandi',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/password.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  // INPUT KOMFIRMASI SANDI
                  Text(
                    'Konfirmasi kata andi',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/images/password.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
                ],
              ),
            ),

            // SUBMIT
            SizedBox(height: 20.0),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF023E8A),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 120.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  // Untuk submit
                },
                child: Text(
                  'Daftar Akun',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),

            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Sudah memiliki akun? ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'Montserrat',
                  ),
                  children: [
                    TextSpan(
                      text: 'Masuk sekarang',
                      style: TextStyle(
                        color: Color(0xFF023E8A),
                        fontSize: 14.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to the login page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Login(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}