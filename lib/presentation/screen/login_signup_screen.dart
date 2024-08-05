import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rabbit_go/presentation/screen/login_screen.dart';
import 'package:rabbit_go/presentation/widgets/create_account_widget.dart';
import 'package:rabbit_go/presentation/widgets/custom_button_widget.dart';

class MyLoginSignScreen extends StatefulWidget {
  const MyLoginSignScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyLoginSignScreen> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<MyLoginSignScreen> {
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print('exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg-bienvenida.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.1)),
            const Text(
              '¡Bienvenido!',
              style: TextStyle(
                color: Color(0xFF01142B),
                fontWeight: FontWeight.w700,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              '¿Listo para recorrer la ciudad?, inicia sesión para \ncomenzar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF6C6C6C),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              textButton: 'Tengo una cuenta',
              width: MediaQuery.of(context).size.width * 0.9,
              height: 45,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF01142B),
              colorText: const Color(0xFFFFFFFF),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyLoginScreen()));
              },
            ),
            const SizedBox(height: 5),
            const Text(
              'ó',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF979797),
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 45,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: const Color(0xFFEBEBEB),
                    width: 2,
                  )),
              child: TextButton(
                onPressed: () {
                  signInWithGoogle();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/Google.png',
                      width: 25,
                    ),
                    const Text(
                      'Continuar con Google',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF9F9F9F),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.035))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const MyCreateAccountWidget(),
          ],
        ),
      ),
    );
  }
}
