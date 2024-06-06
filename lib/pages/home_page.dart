import 'package:firebase_auth/firebase_auth.dart';
import '../auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../bottom_nav_bar.dart';  // Update the import path accordingly

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  bool isEditing = false;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  int _selectedIndex = 1; // Assuming HomePage is the third item

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData(Map<String, dynamic> userData) async {
    setState(() {
      _firstNameController.text = userData['firstName'] ?? '';
      _lastNameController.text = userData['lastName'] ?? '';
      _ageController.text = (userData['age'] ?? '').toString();
    });
  }

  Future<void> _updateUserData() async {
    await users.doc(user!.uid).update({
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'age': int.tryParse(_ageController.text) ?? 0,
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
    setState(() {
      isEditing = false;
    });
  }

  Future<void> _signOut() async {
    await Auth().signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File imageFile = File(image.path);
    try {
      final ref = FirebaseStorage.instance.ref().child('user_avatars/${user!.uid}');
      await ref.putFile(imageFile);
      String downloadUrl = await ref.getDownloadURL();
      await users.doc(user!.uid).update({'profileImageUrl': downloadUrl});
      setState(() {});
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image')));
    }
  }

  Future<void> _deleteAvatar() async {
    try {
      final ref = FirebaseStorage.instance.ref().child('user_avatars/${user!.uid}');
      await ref.delete();
      await users.doc(user!.uid).update({'profileImageUrl': FieldValue.delete()});
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Avatar deleted')));
    } catch (e) {
      print('Error deleting avatar: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting avatar')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(user!.uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.data() == null) {
              return ElevatedButton(
                onPressed: _signOut,
                child: const Text("No data found for this user"),
              );
            } else {
              Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
              if (!isEditing) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (userData.containsKey('profileImageUrl')) ...[
                      CircleAvatar(
                        backgroundImage: NetworkImage(userData['profileImageUrl']),
                        radius: 60,
                      ),
                      SizedBox(height: 20),
                    ],
                    Text(
                      '${userData['firstName'] ?? ''} ${userData['lastName'] ?? ''}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      userData['email'] ?? "User email",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Age: ${userData['age'] ?? ''}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _loadUserData(userData);
                        setState(() {
                          isEditing = true;
                        });
                      },
                      child: Text("Edit"),
                    ),
                    ElevatedButton(
                      onPressed: _pickAndUploadImage,
                      child: Text("Change Avatar"),
                    ),
                    if (userData.containsKey('profileImageUrl')) ...[
                      ElevatedButton(
                        onPressed: _deleteAvatar,
                        child: Text("Delete Avatar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                    _signOutButton(context),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                    ),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: _ageController,
                      decoration: InputDecoration(labelText: 'Age'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateUserData,
                      child: Text('Update Profile'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isEditing = false;
                        });
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex),  // Add the BottomNavBar widget
    );
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _signOut,
      child: const Text("Sign out"),
    );
  }
}
