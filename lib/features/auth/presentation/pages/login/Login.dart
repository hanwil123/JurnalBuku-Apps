import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jurnalbukuapps/features/auth/presentation/pages/homepage/homePage_view.dart';
import 'package:jurnalbukuapps/features/auth/presentation/pages/signup/Main_Signup.dart';
import 'package:jurnalbukuapps/features/auth/presentation/widgets/Components/auth_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<void> loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;
    var url = Uri.parse('http://10.10.9.231:3000/login');
    var response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // Konversi respons JSON menjadi map
      Map<String, dynamic> responseData = jsonDecode(response.body);
      // Ambil nilai token dari map
      String token = responseData['token'];
      // Cetak token
      print('Token: $token');
      // Navigasi ke halaman utama
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePageView()),
      );
    } else {
      // Tampilkan pesan kesalahan
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal melakukan registrasi. Silakan coba lagi.'),
      ));
    }
  }

  Future<void> initiateGoogleLogin() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.auth.signInWithOAuth(OAuthProvider.google, authScreenLaunchMode: LaunchMode.inAppWebView);
    if (response == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: login error')),
      );
    } else {
      final Session? session = supabase.auth.currentSession;
      final String? token = session?.providerToken;
      final result = await http.get(
        Uri.parse('http://localhost:8080/login?token=$token'),
      );

      if (result.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${result.body}')),
        );
      }
    }
  }

  Future<void> fetchData(String accessToken) async {
   
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login",
                    style: TextStyle(
                        fontSize: widthApp * 0.1, color: Colors.black)),
                SizedBox(height: 15),
                Column(
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
                SizedBox(height: 15),
                Column(
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
                SizedBox(height: 25),
                Container(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: loginUser,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          maximumSize: Size(500, 70),
                        ),
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: initiateGoogleLogin,
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
                  child: OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: loginUser,
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
                SizedBox(height: 25),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Text(
                              "Don’t have an account ?",
                              style: TextStyle(
                                  fontSize: widthApp * 0.03,
                                  color: Colors.black),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainSignup()));
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
