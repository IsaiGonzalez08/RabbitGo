import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';

void main() => runApp(const MySignUpPage());

class MySignUpPage extends StatelessWidget {
  const MySignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MyLoginSignPage(title: 'LoginSingPage'),
                ),
              );
            },
            icon: Image.asset('assets/images/LeftArrow.png'),
          ),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}