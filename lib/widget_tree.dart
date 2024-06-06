import 'package:flutter/material.dart';
import 'package:imag/pages/register_page.dart';
import 'auth.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';


class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 1.0),
                      child: Image.asset(
                        'assets/imglogo.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        'Puzzle\nEscape',
                        style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: SizedBox(
                        width: 200,
                        height: 50.0, // Set desired height here
                        child: ElevatedButton(
                          onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                            },
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20),
                      child: SizedBox(
                        width: 200,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              },
                          child: Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20),
                      child: SizedBox(
                        width: 200,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Guest', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Times New Roman')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return HomePage();
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
