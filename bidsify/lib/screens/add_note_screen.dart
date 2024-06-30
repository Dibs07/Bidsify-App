import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/model/bid_model.dart';
import 'package:notes/model/item_model.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/services/bid_service.dart';
import 'package:notes/services/data_service.dart';
import 'package:notes/services/storage_service.dart';
import 'package:notes/widgets/auction_card.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  int _selectedIndex = 0;

  late BidService _bidService;
  late StorageService _storageService;
  late AuthService _authService;
  late DataService _dataService;
  late Future<void> _loadUserDataFuture;
  String _displayName = '';
  String _profilepic = '';
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    _bidService = GetIt.instance.get<BidService>();
    _storageService = GetIt.instance.get<StorageService>();
    _authService = GetIt.instance.get<AuthService>();
    _dataService = GetIt.instance.get<DataService>();
    if (_authService.user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, '/login');
      });
    } else {
      _loadUserDataFuture = _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    final userModelStream = _dataService.getUser();
    final event = await userModelStream.first;
    setState(() {
      _displayName = event.docs[0].data().name!;
      _profilepic = event.docs[0].data().profilePic;
    });
  }

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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final bid = _bidController.text;
      String? url = await _storageService.uploadFile(
        file: _imageFile!,
        uid: _authService.user!.uid,
      );
      if (url != null) {
        await _bidService.createitem(
          item: ItemModel(
            uid: _authService.user!.uid + DateTime.now().toString(),
            name: title,
            descrription: description,
            ownerId: _authService.user!.uid,
            price: double.parse(bid),
            lastBid: _displayName,
            bids: [],
            itemPic: url,
          ),
        );
      }
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
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Title',
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
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
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Description',
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
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
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Enter Initial Bid',
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              )),
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

  late double newBid;

  _onBidPlaced({required String bidId, required ItemModel item}) async {
    if (newBid > item.price!) {
      BidModel newbid = BidModel(
        uid: bidId + DateTime.now().toString(),
        maxBid: newBid,
        isEnded: false,
        lastBidder: _displayName,
        item: item.name,
      );
      await _bidService.createbid(bid: newbid);
      item.price = newBid;
      item.lastBid = _displayName;
      item.bids.add(newbid);
      if (await _bidService.updateItem(item: item)) {
        print('Bid updated successfully');
      } else {
        print('Failed to update bid');
      }
    } else {
      print('Bid should be greater than the current bid');
    }
  }

  placeBid(
      {required BuildContext context,
      required String bidId,
      required ItemModel item}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Text(
                  'Place your Bid Here',
                  style: kHeadingTextStyle.copyWith(fontSize: 35),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                content: SizedBox(
                  height: 130,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter your bid',
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.white)),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          newBid = double.parse(value);
                        },
                      ),
                      SizedBox(height: 20),
                      myButton(
                          width: double.infinity,
                          height: 50,
                          text: 'Save',
                          onClick: () => _onBidPlaced(bidId: bidId, item: item))
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
    });
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
          Expanded(
            child: StreamBuilder(
              stream: _bidService.getItems(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No items found'));
                }

                final items = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    ItemModel item = items[index].data();
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: BidCard(
                        title: item.name,
                        bidder: _authService.user!.uid,
                        latestBid: item.price,
                        onClick: () => placeBid(
                            bidId: item.uid, context: context, item: item),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
