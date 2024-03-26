// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movie_app/core/shared_widgets/custom_select_button.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({super.key});

  List<ResDeliveryOption> deliveryOption = [
    ResDeliveryOption(id: 1, name: "JNE"),
    ResDeliveryOption(id: 2, name: "JNT"),
    ResDeliveryOption(id: 3, name: "SICEPAT"),
    ResDeliveryOption(id: 4, name: "DHL"),
  ];
  final deliveryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SECOND SCREEEN").animate(delay: 5.ms).fadeIn(duration: 1.seconds),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: CustomSelectButton(
            controller: deliveryController,
            optionList: deliveryOption.map((e) => FormOption(key: e.id.toString(), value: e.name)).toList(),
            onOptionSelected: (selectedOption) {
              deliveryController.text = selectedOption.value;
            },
            hintText: "Mau Dikirim Pake Ekspedisi Apa?"),
      ),
    );
  }
}

class ResDeliveryOption {
  final int id;
  final String name;

  ResDeliveryOption({required this.id, required this.name});
}
