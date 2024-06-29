import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/constants/constants.dart';

class AuctionPage extends StatefulWidget {
  const AuctionPage({super.key});

  @override
  State<AuctionPage> createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;

      // print('Title: $title');
      // print('Description: $description');
      // print('Image: $_image');

      // _formKey.currentState!.reset();
      // setState(() {
      //   _image = null;
      // });

      Navigator.pop(context, {
        'title': title,
        'description': description,
        'image': _image,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 40),
          child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0x663348B5)
                  ),
                  child: _image == null
                      ? Icon(Icons.add_a_photo, size: 100, color: Color(0xFF3348B5))
                      : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: kInputTextFieldStyle,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Title',
                  border: OutlineInputBorder(),
                ),
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Container(
                height: 150,
                child: TextFormField(
                  style: kInputTextFieldStyle,
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  controller:  _descriptionController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16.0),
              myButton(width: double.infinity, height: 50, text: 'Submit', onClick: _submitForm)
            ],
          ),
                ),
        )
    );
  }
}
