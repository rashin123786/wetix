import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wetix/controller/services/auth_service.dart';
import 'package:wetix/model/user_model.dart';
import 'package:wetix/view/Authentication/Login/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final _formKey = GlobalKey<FormState>();
final fullNameController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    bool isLoading = false;
    AutherServices autherServices = AutherServices();
    void signupOntap() {
      setState(() {
        isLoading = true;
      });
      if (_formKey.currentState!.validate()) {
        if (passwordController.text == confirmPasswordController.text) {
          UserModel user = UserModel(
              fullName: fullNameController.text,
              userName: fullNameController.text,
              email: emailController.text,
              password: passwordController.text);
          autherServices.signUp(context, user.fullName ?? '',
              user.fullName ?? '', user.email ?? '', user.password ?? '');
        } else {
          Fluttertoast.showToast(
              msg: "Password and Confirm Doesn't Match",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.brown,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
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
                        'Register',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const ListTile(
                  title: Text(
                    'Welcome !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text('All your needs for event experience.'),
                ),
                ListTile(
                  title: const Text(
                    'Your full name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        controller: fullNameController,
                        validator: (username) =>
                            username!.isEmpty ? 'Enter Full Name' : null,
                        decoration: InputDecoration(
                            hintText: 'Enter your full name',
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
                    'Email',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        controller: emailController,
                        validator: (email) =>
                            email!.isEmpty && !EmailValidator.validate(email)
                                ? 'Enter email'
                                : null,
                        decoration: InputDecoration(
                            hintText: 'Enter your email',
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
                        controller: passwordController,
                        validator: (confrimpassword) =>
                            confrimpassword!.isEmpty ||
                                    confrimpassword.length < 6
                                ? 'Enter password more than 6'
                                : null,
                        decoration: InputDecoration(
                            hintText: ' Your password',
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
                    'Confirm password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: SizedBox(
                      height: 65,
                      child: TextFormField(
                        controller: confirmPasswordController,
                        validator: (password) =>
                            password!.isEmpty || password.length < 6
                                ? 'Enter password more than 6'
                                : null,
                        decoration: InputDecoration(
                            hintText: ' Your Confirm password',
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: signupOntap,
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 50),
                          backgroundColor:
                              const Color.fromRGBO(139, 87, 92, 1)),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Register'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                            'Register with Google',
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: const Text(
                    'Already have an account : Login',
                    style: TextStyle(color: Color.fromARGB(255, 138, 138, 138)),
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
