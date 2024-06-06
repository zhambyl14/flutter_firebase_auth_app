import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'login_page.dart'; // Import LoginPage
import 'home_page.dart'; // Import HomePage

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _register() async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? user = userCredential.user;

      if (user != null) {
        String? imageUrl;

        if (_image != null) {
          imageUrl = await _uploadImageToFirebase(user.uid, _image!);
        }

        await addUserDetails(
          user.uid,
          _emailController.text.trim(),
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          int.parse(_ageController.text.trim()),
          imageUrl,
        );

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      print('Error during registration: $e');
    }
  }

  Future<String?> _uploadImageToFirebase(String userId, File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('avatar/$userId.jpg'); // Store in "avatar" folder

      await ref.putFile(imageFile);

      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> addUserDetails(
      String userId, 
      String email, 
      String firstName, 
      String lastName, 
      int age, 
      [String? imageUrl]) async {

    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      if (imageUrl != null) 'profileImageUrl': imageUrl, 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50.0,
                          backgroundImage: FileImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 50.0,
                          child: Icon(Icons.person),
                        ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Choose Profile Picture'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ),
            SizedBox(height: 10.0), // Add some space
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())); // Navigate to LoginPage
                },
                child: Text('Already have an account? Login'), // Text for the button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
