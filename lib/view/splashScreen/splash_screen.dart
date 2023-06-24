import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wetix/view/Authentication/Login/login_screen.dart';
import 'package:wetix/view/Authentication/Register/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/rectangle.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.6,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.3),
              child: Row(
                children: [
                  const Text(
                    'Your Logo',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(139, 87, 92, 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        'assets/images/shape.svg',
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Book Premuim event's ticket here",
              style: TextStyle(
                color: Color.fromARGB(255, 171, 171, 171),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(20, 50),
                      backgroundColor: const Color.fromRGBO(139, 87, 92, 1)),
                  child: const Text('Get Started'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      minimumSize: const Size(20, 50),
                      backgroundColor: const Color.fromRGBO(246, 228, 246, 1)),
                  child: const Text(
                    "i don't have account",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
