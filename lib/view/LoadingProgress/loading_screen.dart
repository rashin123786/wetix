import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wetix/view/widgets/bottom_nav.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavWidget(),
                  )),
              child: Container(
                width: 40,
                height: 40,
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
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Finding best event for you',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 150,
            height: 6.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [
                  0.4,
                  0.10,
                ],
                colors: [
                  Colors.brown,
                  Colors.grey,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
