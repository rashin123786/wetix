import 'package:flutter/material.dart';
import 'package:wetix/view/LoadingProgress/loading_screen.dart';
import 'package:wetix/view/widgets/otp.dart';

final firsController = TextEditingController();
final seecondController = TextEditingController();
final thirdController = TextEditingController();
final fourthController = TextEditingController();
final fiveController = TextEditingController();
final sixControllere = TextEditingController();

class verficationScreen extends StatelessWidget {
  const verficationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    'Verification',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Enter 6 digit verification',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                otpRow(controller: firsController),
                otpRow(controller: firsController),
                otpRow(controller: firsController),
                otpRow(controller: firsController),
                otpRow(controller: firsController),
                otpRow(controller: firsController),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            RichText(
              text: const TextSpan(
                text: "Dont't recieve code? ",
                style: TextStyle(color: Color.fromARGB(255, 86, 86, 86)),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Resend Code',
                    style: TextStyle(
                      color: Color.fromARGB(255, 143, 104, 101),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoadingScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(20, 50),
                      backgroundColor: const Color.fromRGBO(139, 87, 92, 1)),
                  child: const Text('Verify Code'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
