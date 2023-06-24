import 'package:flutter/material.dart';
import 'package:wetix/utils/constants/constants.dart';

class ExploreSlider extends StatelessWidget {
  const ExploreSlider({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sliderImg.length,
        itemBuilder: (context, index) {
          final sliderImgData = sliderImg[index];
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 249, 241, 241)),
                width: width * 0.45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      height: height * 0.045,
                      width: width * 0.08,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/rectangle.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text('Music Concert')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
