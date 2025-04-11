import 'dart:convert';
import 'package:adventures_app/models/adventure.dart';
import 'package:adventures_app/providers/adventures_provider.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AdventureCardAdd extends StatelessWidget {
  const AdventureCardAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final adventuresProvider = Provider.of<AdventuresProvider>(context);
    String? currentRoute = ModalRoute.of(context)?.settings.name;

    return GestureDetector(
      onTap: () async {
        if (currentRoute == 'home') {
          adventuresProvider.currentAdventure = Adventure(
              title: '', date: DateTime.now().toString(), place: '', add: true);
          Navigator.pushNamed(context, 'details');
        } else {
          adventuresProvider.currentAdventure.img = await selectImage();
        }
      },
      child: Hero(
        tag: 'add',
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          padding: const EdgeInsets.all(0),
          color: Colors.grey,
          dashPattern: const [4],
          strokeWidth: 2,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              height: currentRoute == 'home' ? 180 : 200,
              child: const AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '+',
                            style: TextStyle(fontSize: 55, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future selectImage() async {
    final ImagePicker picker = ImagePicker();
    final headerImage = await picker.pickImage(source: ImageSource.gallery);
    if (headerImage != null) {
      final croppedImage = await ImageCropper().cropImage(
          sourcePath: headerImage.path,
          aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "Crop your event's image",
              lockAspectRatio: true,
              initAspectRatio: CropAspectRatioPreset.ratio16x9,
            ),
            IOSUiSettings(
                title: "Crop your event's image", aspectRatioLockEnabled: true)
          ]);
      if (croppedImage != null) {
        final compressedImage = await FlutterImageCompress.compressWithFile(
            croppedImage.path,
            quality: 100);
        if (compressedImage != null) {
          final base64Image = base64Encode(compressedImage);
          return base64Image;
        }
      }
    }
  }
}
