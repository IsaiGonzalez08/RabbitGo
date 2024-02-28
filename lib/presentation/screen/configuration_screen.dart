import 'package:flutter/material.dart';
import 'package:rabbit_go/presentation/screen/home_screen.dart';
import 'package:rabbit_go/presentation/screen/login_signup_screen.dart';

class MyConfigurationPage extends StatelessWidget {
  const MyConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 30)),
          const Center(
            child: Text(
              'Configuración',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFB5B5B5),
                  fontSize: 12),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Column(
                children: [
                  Text(
                    'Victor Villava',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF737373),
                        fontSize: 16),
                  ),
                  Text(
                    'Prueba@gmail.com',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF737373),
                        fontSize: 10),
                  )
                ],
              ),
              const SizedBox(
                width: 120,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF01142B),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: const Text(
                  'Gratis',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    backgroundColor: Color(0xFF01142B),
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Text(
                'Perfil',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B6B6B)),
              ),
              const SizedBox(
                width: 210,
              ),
              Image.asset('assets/images/Forward.png')
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Text(
                'Suscripción',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B6B6B)),
              ),
              const SizedBox(
                width: 170,
              ),
              Image.asset('assets/images/Forward.png')
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Text(
                'Configuración',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B6B6B)),
              ),
              const SizedBox(
                width: 155,
              ),
              Image.asset('assets/images/Forward.png')
            ],
          ),
          const SizedBox(
            height: 180,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 69,
                  color: const Color(0xFFFFFFFF),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyHomeScreen(),
                                ),
                              );
                            },
                            icon: Image.asset('assets/images/homewhite.png'),
                          ),
                          const Text(
                            'Home',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF979797),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyLoginSignPage(
                                      title: 'LoginSingPage'),
                                ),
                              );
                            },
                            icon: Image.asset('assets/images/love.png'),
                          ),
                          const Text(
                            'Favoritos',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF979797),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyLoginSignPage(
                                      title: 'LoginSingPage'),
                                ),
                              );
                            },
                            icon: Image.asset('assets/images/marker.png'),
                          ),
                          const Text(
                            'Marcar',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF979797),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MyConfigurationPage(),
                                ),
                              );
                            },
                            child: Image.asset('assets/images/perfil.png'),
                          ),
                          
                          const Text(
                            'Perfil',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF979797),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
