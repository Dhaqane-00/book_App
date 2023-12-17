// ignore_for_file: use_build_context_synchronously

import 'package:book_grocer/common/color_extenstion.dart';
import 'package:book_grocer/view/login/forgot_password_view.dart';
import 'package:book_grocer/view/main_tab/main_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common_widget/round_button.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final snackBar = const SnackBar(
    content: Text('Login Succesfully'),
  );

  TextEditingController txtCode = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isStay = false;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: TColor.primary,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                          color: TColor.text,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: txtEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.greenAccent), //<-- SEE HERE
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: txtPassword,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Colors.greenAccent), //<-- SEE HERE
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isStay = !isStay;
                            });
                          },
                          icon: Icon(
                            isStay
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: isStay
                                ? TColor.primary
                                : TColor.subTitle.withOpacity(0.3),
                          ),
                        ),
                        Text(
                          "Stay Logged In",
                          style: TextStyle(
                            color: TColor.subTitle.withOpacity(0.3),
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordView()));
                          },
                          child: Text(
                            "Forgot Your Password?",
                            style: TextStyle(
                              color: TColor.subTitle.withOpacity(0.3),
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RoundLineButton(
                      title: "Sign In",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: txtEmail.text,
                                  password: txtPassword.text)
                              .then(
                                (value) => {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar),
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MainTabView(),
                                    ),
                                  ),
                                },
                              )
                              .onError((error, stackTrace) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(error.toString()),
                                      ),
                                    ),
                                  });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                      ),
                      onPressed: () async {
                        try {
                          final GoogleSignInAccount? googleUser =
                              await googleSignIn.signIn();

                          if (googleUser == null) {
                            // User canceled Google Sign-In
                            return;
                          }
                          final GoogleSignInAuthentication googleAuth =
                              await googleUser.authentication;
                          final AuthCredential credential =
                              GoogleAuthProvider.credential(
                            accessToken: googleAuth.accessToken,
                            idToken: googleAuth.idToken,
                              );

                          final UserCredential authResult =
                              await _auth.signInWithCredential(credential);
                          final User? user = authResult.user;

                          if (user != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainTabView(),
                              ),
                            );
                          }
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $error'),
                            ),
                          );
                        }
                      },
                      child: Image.asset("assets/img/Google1.png"),
                    ),
                  ]),
            ),
          ),
        ));
  }
}
