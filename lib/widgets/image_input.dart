import 'dart:io';
// import 'dart:js_interop';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectImage});
  final Function onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> _takepicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(
      () {
        imageFile == null ? null : _storedImage = File(imageFile.path);
      },
    );
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    if (imageFile != null) {
      final fileName = path.basename(imageFile.path);
      final savedImage =
          await File(imageFile.path).copy('${appDir.path}/$fileName');
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      right: true,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 210,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 1, color: Colors.indigo),
              ),
              alignment: Alignment.center,
              child: _storedImage != null
                  ? Image.file(
                      _storedImage!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : const Text(
                      'NO IMAGE RENDERED',
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: _takepicture,
                icon: const Icon(Icons.camera),
                label: const Text('Take pictures!'),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
