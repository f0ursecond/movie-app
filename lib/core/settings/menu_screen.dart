// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/core/settings/second_screen.dart';
import 'package:movie_app/core/settings/settings_screen.dart';
import 'package:movie_app/core/shared_widgets/custom_select_button.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});

  final select = SelectedCardCuy();

  final controller = TextEditingController();

  final List<ResUser> testing = [
    ResUser(name: "alif", age: "20"),
    ResUser(name: "budi", age: "23"),
    ResUser(name: "bening", age: "19"),
    ResUser(name: "alex", age: "25"),
  ];

  @override
  Widget build(BuildContext context) {
    print("BUILD");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello World").animate(delay: 5.ms).fadeIn(duration: 1.seconds),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              );
            },
            icon: const Icon(
              Icons.arrow_right,
              color: Colors.white,
            ),
          ).animate(delay: 5.ms).fadeIn(duration: 1.seconds)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
        child: CustomSelectButton(
            controller: controller,
            optionList: testing.map((e) => FormOption(key: e.name, value: e.name)).toList(),
            onOptionSelected: (selectedOption) {
              controller.text = selectedOption.value;
              Navigator.pop(context);
            },
            hintText: "Isi Nama Dulu Sebelum Lanjoet"),
      ),
    );
  }
}

class ResUser {
  final String name;
  final String age;

  ResUser({required this.name, required this.age});
}
