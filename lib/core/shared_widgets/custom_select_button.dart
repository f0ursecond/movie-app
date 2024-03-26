import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/constant/color_constant.dart';

class CustomSelectButton extends StatelessWidget {
  final List<FormOption> optionList;
  final Function(FormOption) onOptionSelected;
  final String hintText;
  final TextEditingController controller;

  const CustomSelectButton({
    super.key,
    required this.optionList,
    required this.onOptionSelected,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final select = SelectedCardCuy();
    return TextFormField(
      controller: controller,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 350,
              child: CustomItemList(
                select: select,
                length: optionList.length,
                option: optionList,
                onOptionSelected: onOptionSelected,
              ),
            );
          },
        );
      },
      readOnly: true,
      style: const TextStyle(color: AppColors.kPrimaryColor),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}

class CustomItemList extends StatelessWidget {
  const CustomItemList({
    super.key,
    required this.option,
    required this.length,
    required this.select,
    required this.onOptionSelected,
  });

  final List<FormOption> option;
  final int length;
  final SelectedCardCuy select;
  final Function(FormOption) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(length, (index) {
          return BlocBuilder<SelectedCardCuy, int>(
            bloc: select,
            builder: (context, state) {
              return Card(
                color: AppColors.kPrimaryColor,
                child: ListTile(
                  onTap: () {
                    select.select(index);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      onOptionSelected(option[index]);
                    });
                  },
                  title: Text(option[index].value),
                  trailing: Visibility(
                    visible: state == index,
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class FormOption {
  final String key;
  final String value;

  FormOption({required this.key, required this.value});
}

class SelectedCardCuy extends Cubit<int> {
  SelectedCardCuy() : super(-1);

  void select(int index) {
    emit(index);
  }
}
