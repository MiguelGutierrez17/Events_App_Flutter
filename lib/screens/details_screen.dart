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
    // final Adventure adventure = ModalRoute.of(context)!.settings.arguments as Adventure;
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    final currentAdventure = adventuresProvider.currentAdventure;
    return Scaffold(
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
              const MyForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _adventureKey = GlobalKey<FormState>();
  late TextEditingController dateController;
  late TextEditingController titleController;
  late TextEditingController placeController;
  @override
  void initState() {
    super.initState();
    final adventure = Provider.of<AdventuresProvider>(context, listen: false)
        .currentAdventure;
    final adding = adventure.add ?? false;

    titleController = TextEditingController(
      text: adding ? '' : adventure.title,
    );
    dateController = TextEditingController(
      text: adding ? '' : adventure.date,
    );
    placeController = TextEditingController(
      text: adding ? '' : adventure.place,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _adventureKey,
      child: Column(
        children: [
          CustomField(
              controller: titleController,
              isDate: false,
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
              controller: dateController,
              isDate: true,
              fieldLabel: 'Time',
              hintLabel: 'Select a date',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Date field is missing';
                }
                return null;
              }),
          const SizedBox(height: 10),
          CustomField(
              controller: placeController,
              isDate: false,
              fieldLabel: 'Place',
              hintLabel: 'Type place of adventure',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Place field is missing';
                }
                return null;
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class CustomField extends StatelessWidget {
  final bool isDate;
  final String fieldLabel;
  final String hintLabel;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomField(
      {super.key,
      required this.fieldLabel,
      required this.hintLabel,
      this.initialValue,
      this.validator,
      required this.isDate,
      this.controller});

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
            readOnly: isDate,
            decoration: _FieldStyle.newStyle(placeholderText: hintLabel),
            validator: validator,
            onTap: () async {
              if (isDate) {
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
                        context: context,
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
                    }
                  }
                }
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
