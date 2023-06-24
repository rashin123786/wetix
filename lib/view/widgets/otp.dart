import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class otpRow extends StatelessWidget {
  otpRow({super.key, required this.controller});
  final TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 50,
        width: 40,
        child: TextFormField(
          controller: controller,
          onChanged: (value) {
            FocusScope.of(context).nextFocus();
          },
          style: Theme.of(context).textTheme.titleLarge,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            fillColor: Colors.white,
            filled: true,
          ),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      ),
    );
  }
}
