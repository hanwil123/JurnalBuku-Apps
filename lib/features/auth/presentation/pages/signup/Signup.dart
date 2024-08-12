import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jurnalbukuapps/features/auth/presentation/pages/login/Main_Login.dart';
import 'dart:convert';

import 'package:jurnalbukuapps/features/auth/presentation/widgets/Components/auth_field.dart';



class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerUser() async {
    String nama = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    var url = Uri.parse('http://10.10.9.231:3000/register');
    var response = await http.post(
      url,
      body: jsonEncode(
          {'nama': nama, 'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Registrasi berhasil
      // Navigasi ke layar login atau layar utama aplikasi
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainLogin()),
      );
    } else {
      // Tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal melakukan registrasi. Silakan coba lagi.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final heightApp = MediaQuery.of(context).size.height;
    final widthApp = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.yellow,
      height: heightApp,
      child: Center(
        child: SingleChildScrollView(
          // Tambahkan SingleChildScrollView agar konten dapat di-scroll
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up",
                    style: TextStyle(
                        fontSize: widthApp * 0.1, color: Colors.black)),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Container(
                        child: AuthField(
                          hinText: 'Username',
                          hintTextColor: Colors.black,
                          controller: usernameController,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Container(
                        child: AuthField(
                          hinText: 'Email',
                          hintTextColor: Colors.black,
                          controller: emailController,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Container(
                        child: AuthField(
                          hintTextColor: Colors.black,
                          hinText: 'Password',
                          controller: passwordController,
                          isObsecureText: true,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: registerUser,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          maximumSize: Size(500, 70),
                        ),
                        child: Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: registerUser,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          maximumSize: Size(500, 70),
                        ),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Image.asset(
                                  "assets/google_PNG19635-removebg-preview.png",
                                  width: widthApp * 0.04,
                                )
                              ),
                              SizedBox(width: widthApp * 0.007,),
                              Text(
                                "SignUp with Google",
                                style: TextStyle(fontSize: widthApp * 0.04),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: registerUser,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 50),
                        maximumSize: Size(500, 70),
                      ),
                      child: Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                child: Image.asset(
                              "assets/Facebook_Logo_2023-removebg-preview.png",
                              width: widthApp * 0.04,
                            )),
                            SizedBox(

                              width: widthApp * 0.007),
                            Text(
                              "SignUp with Facebook",
                              style: TextStyle(fontSize: widthApp * 0.04),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Text(
                              "Already have an account ?",
                              style: TextStyle(
                                  fontSize: widthApp * 0.03,
                                  color: Colors.black),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainLogin()));
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                // Sisa kode widget lainnya...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
