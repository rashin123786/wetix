import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../controller/services/auth_service.dart';
import '../Register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final loginUserName = TextEditingController();
  final loginPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;
    AutherServices autherServices = AutherServices();
    void loginOntap() {
      if (_formKey.currentState!.validate()) {
        log("clikced");
        autherServices.loginServices(
            context, loginUserName.text, loginPassword.text);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 12),
                        child: Icon(Icons.arrow_back),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const ListTile(
                  title: Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('All your needs for event experience.'),
                ),
                ListTile(
                  title: const Text(
                    'Input email or phone number',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        controller: loginUserName,
                        validator: (username) =>
                            username!.isEmpty ? 'Enter Full Name' : null,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'Your email or phone number',
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        controller: loginPassword,
                        validator: (password) =>
                            password!.isEmpty || password.length < 6
                                ? 'Enter password more than 6'
                                : null,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'your password',
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 1),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: loginOntap,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 50),
                          backgroundColor: const Color.fromRGBO(139, 87, 92, 1)),
                      child: const Text('Sign In'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 50),
                          backgroundColor: const Color(0xFFF6E4F6)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/icons8-google-logo.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ));
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: "Dont't have account? ",
                        style:
                            TextStyle(color: Color.fromARGB(255, 86, 86, 86)),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              color: Color.fromARGB(255, 143, 104, 101),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
