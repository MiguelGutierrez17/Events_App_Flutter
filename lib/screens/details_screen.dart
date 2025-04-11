import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/providers/adventures_form_provider.dart';
import 'package:adventures_app/widgets/card_adventure_add.dart';
import 'package:adventures_app/widgets/header_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/adventures_provider.dart';
import 'dart:io' show Platform;

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    final currentAdventure = adventuresProvider.currentAdventure;
    final adding = currentAdventure.add ?? false;

    final titleController = TextEditingController(
      text: adding ? '' : currentAdventure.title,
    );
    final dateController = TextEditingController(
      text: adding ? '' : currentAdventure.date,
    );
    final placeController = TextEditingController(
      text: adding ? '' : currentAdventure.place,
    );
    return ChangeNotifierProvider(
      create: (_) => AdventuresFormProvider(currentAdventure),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'home'),
                      child: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                currentAdventure.add == true
                    ? const AdventureCardAdd()
                    : HeaderImage(adventure: currentAdventure),
                const SizedBox(height: 20),
                MyForm(
                  titleController: titleController,
                  dateController: dateController,
                  placeController: placeController,
                  adventuresProvider: adventuresProvider,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController dateController;
  final TextEditingController placeController;
  final AdventuresProvider adventuresProvider;

  const MyForm(
      {super.key,
      required this.titleController,
      required this.dateController,
      required this.placeController,
      required this.adventuresProvider});

  @override
  Widget build(BuildContext context) {
    final adventuresForm = Provider.of<AdventuresFormProvider>(context);
    final adventure = adventuresForm.adventure;
    return Form(
      key: adventuresForm.formKey,
      child: Column(
        children: [
          CustomField(
              adventure: adventure,
              controller: titleController,
              type: 'title',
              fieldLabel: 'Title',
              hintLabel: 'Type your event title',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title field is missing';
                }
                return null;
              }),
          const SizedBox(height: 10),
          CustomField(
              adventure: adventure,
              controller: dateController,
              type: 'date',
              fieldLabel: 'Date',
              hintLabel: 'Select a date',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date field is missing';
                }
                return null;
              }),
          const SizedBox(height: 10),
          CustomField(
              adventure: adventure,
              controller: placeController,
              type: 'place',
              fieldLabel: 'Place',
              hintLabel: 'Type place of adventure',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Place field is missing';
                }
                return null;
              }),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _SaveButton(
                formProvider: adventuresForm,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  final String type;
  final String fieldLabel;
  final String hintLabel;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Adventure adventure;

  const CustomField(
      {super.key,
      required this.fieldLabel,
      required this.hintLabel,
      this.initialValue,
      this.validator,
      this.controller,
      required this.type,
      required this.adventure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fieldLabel),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            readOnly: type == 'date',
            decoration: _FieldStyle.newStyle(placeholderText: hintLabel),
            validator: validator,
            onTap: () async {
              if (type == 'date') {
                if (Platform.isIOS) {
                  print('IOS');
                } else {
                  DateTime? pickedTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2999));

                  if (pickedTime != null) {
                    TimeOfDay? pickedHour = await showTimePicker(
                        initialEntryMode: TimePickerEntryMode.inputOnly,
                        orientation: Orientation.portrait,
                        context: (context),
                        initialTime: TimeOfDay.now());

                    if (pickedHour != null) {
                      final DateTime chosenDate = DateTime(
                          pickedTime.year,
                          pickedTime.month,
                          pickedTime.day,
                          pickedHour.hour,
                          pickedHour.minute);
                      String chosenDateFormatted =
                          DateFormat("dd/MM/yyyy HH:mm").format(chosenDate);
                      controller?.text = chosenDateFormatted;
                      adventure.date = chosenDate.toString();
                    }
                  }
                }
              }
            },
            onChanged: (value) {
              if (type == 'title') {
                adventure.title = value;
              } else if (type == 'place') {
                adventure.place = value;
              }
            },
          )
        ],
      ),
    );
  }
}

class _FieldStyle {
  static InputDecoration newStyle({
    String placeholderText = "",
  }) {
    return InputDecoration(
      hintText: placeholderText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final AdventuresFormProvider formProvider;

  const _SaveButton({required this.formProvider});

  @override
  Widget build(BuildContext context) {
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    return ElevatedButton.icon(
      label: const Text('Save'),
      icon: const Icon(Icons.save),
      style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 24))),
      onPressed: () async {
        if (!formProvider.isValidForm()) return;
        await adventuresProvider.createUpdateAdventure(adventuresProvider.currentAdventure);
      },
    );
  }
}
