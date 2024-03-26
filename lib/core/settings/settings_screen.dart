// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/constant/color_constant.dart';
import 'package:movie_app/core/home/screens/home_screen.dart';
import 'package:movie_app/core/settings/bloc/anjay_bloc.dart';
import 'package:movie_app/utils/extension.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isError = false;
  SelectedCard select = SelectedCard();
  ToogleVisible toogleVisible = ToogleVisible();
  TextEditingController controller = TextEditingController();
  RealTimeCubit realTimeCubit = RealTimeCubit();
  final _key = GlobalKey<FormState>();

  List<int> nominalList = [
    10000,
    20000,
    15000,
    25000,
    50000,
    100000,
  ];

  @override
  void initState() {
    controller.text = nominalList[0].toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return BlocBuilder<ToogleVisible, bool>(
      bloc: toogleVisible,
      builder: (context, themeState) {
        return Scaffold(
          backgroundColor: themeState ? Colors.white : AppColors.kPrimaryColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: BlocBuilder<RealTimeCubit, String>(
              bloc: realTimeCubit..start(),
              builder: (context, state) {
                return AppBar(
                  title: Text(state),
                  actions: [
                    IconButton(
                        onPressed: () {
                          toogleVisible.visible();
                        },
                        icon: themeState ? Icon(Icons.light_mode) : Icon(Icons.dark_mode))
                  ],
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<SelectedCard, int>(
                    bloc: select,
                    builder: (context, state) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 5 / 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: nominalList.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            controller.text = nominalList[index].toString();
                            select.select(index);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: state == index
                                    ? Colors.red
                                    : themeState
                                        ? Colors.black.withOpacity(0.5)
                                        : Colors.white.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(nominalList[index].toRupiah()),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _key,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: controller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeState ? Colors.black : Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeState ? Colors.black : Colors.white,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade500),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red.shade500),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value == '') {
                          return 'Tidak Boleh Kosong';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (_key.currentState!.validate()) {
                          int index = nominalList.indexOf(int.parse(value));
                          index != -1 ? select.select(index) : select.select(-1);
                        }
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      print('done');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    }
                  },
                  child: const Text('Next'),
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'plus',
                onPressed: () {
                  context.read<AnjayBloc>().add(IncrementEvent());
                },
                child: const Text('+'),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                heroTag: 'minus',
                onPressed: () {
                  context.read<AnjayBloc>().add(DecrementEvent());
                },
                child: const Text('-'),
              )
            ],
          ),
        );
      },
    );
  }
}

class ToogleVisible extends Cubit<bool> {
  ToogleVisible() : super(false);

  void visible() {
    emit(!state);
  }
}

class SelectedCard extends Cubit<int> {
  SelectedCard() : super(-1);

  void select(int index) {
    emit(index);
  }
}

class RealTimeCubit extends Cubit<String> {
  RealTimeCubit() : super(DateFormat.Hms().format(DateTime.now()));

  void start() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      var format = DateFormat.Hms().format(DateTime.now());
      emit(format);
    });
  }
}
