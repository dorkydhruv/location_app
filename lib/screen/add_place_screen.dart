import 'dart:io';
import 'package:location_app/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:location_app/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});
  static const routeName = '/add-place-screen';
  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        maintainBottomViewPadding: true,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add a New Place you visited'),
          ),
          body: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(labelText: 'Title'),
                            controller: _titleController,
                            autocorrect: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ImageInput(
                            onSelectImage: _selectImage,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LoactionInput()
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _savePlace,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    'Add place',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.green),
                )
              ]),
        ));
  }
}
