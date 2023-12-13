import 'package:book_grocer/view/login/help_us_view.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/color_extenstion.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final snackBar = const SnackBar(
    content: Text('Account Created'),
  );
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtCode = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isStay = false;

  final _formKey = GlobalKey<FormState>();

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
                  "Sign up",
                  style: TextStyle(
                      color: TColor.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: txtFirstName,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "First Name",
                    prefixIcon: Icon(
                      Icons.person,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Email",
                    prefixIcon: const Icon(
                      Icons.email,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: txtMobile,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 2, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Mobile",
                    prefixIcon: const Icon(
                      Icons.phone,
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
                          width: 2, color: Colors.greenAccent), //<-- SEE HERE
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
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
                    Expanded(
                      child: Text(
                        "Please sign me up for the monthly newsletter.",
                        style: TextStyle(
                          color: TColor.subTitle.withOpacity(0.3),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                RoundLineButton(
                  title: "Sign Up",
                  onPressed: () {
                    try {
                      if (_formKey.currentState?.validate() ?? false) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: txtEmail.text,
                                password: txtPassword.text)
                            .then((value) => {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HelpUsView()),
                                  ),
                                })
                            .onError((error, stackTrace) => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(error.toString()),
                                    ),
                                  ),
                                });
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
