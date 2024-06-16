import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;
    print('Username: $username, Password: $password');
    // Implementasi login logic di sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF060821),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Image.asset('assets/images/logo.png', height: 300.0),
                ),
                SizedBox(height: 15),
                Center(
                  child: Text(
                    "Login",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Column(
                  children: [
                    Text(
                      "Masukkan username dan password Anda",
                      style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    Text(
                      "untuk mengakses aplikasi",
                      style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
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
                    ],
                  ),
                  child: TextField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person)),
                  ),
                ),
                SizedBox(height: 20),
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
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock)),
                  ),
                ),
                              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  textStyle: TextStyle(fontSize: 16.0),
                  backgroundColor: Color(0xFF365B92),
                  foregroundColor: Colors.white, // Set the text color to white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Aksi untuk lupa password
                  },
                  child: Text(
                    'Lupa Password? Silahkan klik disini',
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Aksi untuk buat akun baru
                  },
                  child: Text(
                    'Belum memiliki akun ? Buat akun disini!',
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
