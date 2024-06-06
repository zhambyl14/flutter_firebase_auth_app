// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String? errorMessage = '';
//   bool isLogin = true;
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();

//   Future<void> signWithEmailAndPassword() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _controllerEmail.text,
//         password: _controllerPassword.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   Future<void> createUserWithEmailAndPassword() async {
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: _controllerEmail.text,
//         password: _controllerPassword.text,
//       );
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     }
//   }

//   Future<void> signInWithGoogle() async {
//     try {
//       GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//       AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//       await FirebaseAuth.instance.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//       });
//     }
//   }

//   Future<void> signInWithGitHub() async {
//     try {
//       final provider = OAuthProvider('github.com');
//       provider.addScope('read:user');
//       provider.addScope('repo');
//       await FirebaseAuth.instance.signInWithProvider(provider);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         errorMessage = e.message;
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//       });
//     }
//   }

//   Widget _title() {
//     return const Text("Firebase auth");
//   }

//   Widget _entryField(String title, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: title,
//       ),
//     );
//   }

//   Widget _errorMessage() {
//     return Text(errorMessage == '' ? '' : "humm? $errorMessage");
//   }

//   Widget _submitButton() {
//     return ElevatedButton(
//       onPressed: isLogin ? signWithEmailAndPassword : createUserWithEmailAndPassword,
//       child: Text(isLogin ? "Login" : "Register"),
//     );
//   }

//   Widget _loginOrRegisterButton() {
//     return TextButton(
//       onPressed: () {
//         setState(() {
//           isLogin = !isLogin;
//         });
//       },
//       child: Text(isLogin ? "Register instead" : "Login instead"),
//     );
//   }

//   Widget _googleSignUpButton() {
//     return ElevatedButton(
//       onPressed: signInWithGoogle,
//       child: Text("Sign in with Google"),
//     );
//   }

//   Widget _githubSignUpButton() {
//     return ElevatedButton(
//       onPressed: signInWithGitHub,
//       child: Text("Sign in with GitHub"),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _entryField('email', _controllerEmail),
//             _entryField('password', _controllerPassword),
//             _errorMessage(),
//             _submitButton(),
//             _loginOrRegisterButton(),
//             _googleSignUpButton(),
//             _githubSignUpButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }
