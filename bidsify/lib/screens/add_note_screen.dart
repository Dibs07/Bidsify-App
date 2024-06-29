import 'dart:ffi';
import 'dart:io';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/widgets/auction_card.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int _selectedIndex = 0;



      final _formKey = GlobalKey<FormState>();
      final TextEditingController _bidController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(StateSetter setState) async {
  setState(() {
    _isLoading = true;
  });
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _imageFile = File(pickedFile.path);
      _isLoading = false;
    });
  } else {
    setState(() {
      _isLoading = false;
    });
  }
}

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final bid = _bidController.text;
      // Process the extracted values
      print('Title: $title');
      print('Description: $description');
      print('Image: ${_imageFile?.path ?? 'No image selected'}');
      // You can also use the extracted values to update the UI or navigate to another page
    }
  }


  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Profile Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Profile Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var value = 0;

  onAuctionClick() {
    Navigator.pushNamed(context, '/create_auction_page');
  }

  Future<void> onClick(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add Bid Details',
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : _imageFile == null
                              ? Center(
                                  child: Text(
                                    'No image selected.',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              : Center(
                                  child: SizedBox(
                                    height: 80,
                                    child: Image.file(_imageFile!),
                                  ),
                                ),
                      ElevatedButton(
                        onPressed: () => _pickImage(setState),
                        child: Text('Pick Image'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Enter Initial Bid',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _bidController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please place a bid';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _submitForm();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

  placeBid() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Place your Bid Here',
                style: kHeadingTextStyle.copyWith(
                  fontSize: 35
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              content: SizedBox(
                height: 130,
                child: Column(
                  children: [
                    
                    TextField(
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    myButton(width: double.infinity, height: 50, text: 'Save', onClick: (){})

                  ],
                ),
              ),
              // actions: [
              //   TextButton(
              //     child: Text('Close'),
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //   ),
              // ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OptionsCard(
                    onClick: () {
                      onClick(context);
                    },
                    title: 'Create a Bid',
                    icon: Icon(EneftyIcons.card_add_outline),
                    height: 90,
                    width: 175),
                OptionsCard(
                    onClick: onAuctionClick,
                    title: 'Create an\nAuction',
                    icon: Icon(EneftyIcons.courthouse_outline),
                    height: 90,
                    width: 175),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BidCard(
              title: 'Here Goes Auction 1',
              bidder: {"Sayan": ""},
              initialBid: 0.0,
              currentBid: 10.2,
              onClick: placeBid
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BidCard(
              title: 'Here Goes Auction 1',
              bidder: {"Sayan": ""},
              initialBid: 0.0,
              currentBid: 10.2,
              onClick: placeBid
            ),
          ),
        ],
      ),
    );
  }
}
