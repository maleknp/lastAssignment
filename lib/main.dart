import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

// void main() {
//
//   runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "First Screen",
//       theme: ThemeData(
//         fontFamily: 'Cairo',
//         primarySwatch: const MaterialColor(
//             0xFF019798,
//             {
//               50: Color(0xFF019798),
//               100: Color(0xFF019798),
//               200: Color(0xFF019798),
//               300: Color(0xFF019798),
//               400: Color(0xFF019798),
//               500: Color(0xFF019798),
//               600: Color(0xFF019798),
//               700: Color(0xFF019798),
//               800: Color(0xFF019798),
//               900: Color(0xFF019798),
//             },
//           ),
//       ),
//       home: _isLoggedIn ? Counter() : HomeScreen()
//   ));
//
// }



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  Future<void> _checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  void _onLoginSuccess() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "First Screen",
        theme: ThemeData(
          fontFamily: 'Cairo',
          primarySwatch: const MaterialColor(
            0xFF019798,
            {
              50: Color(0xFF019798),
              100: Color(0xFF019798),
              200: Color(0xFF019798),
              300: Color(0xFF019798),
              400: Color(0xFF019798),
              500: Color(0xFF019798),
              600: Color(0xFF019798),
              700: Color(0xFF019798),
              800: Color(0xFF019798),
              900: Color(0xFF019798),
            },
          ),
        ),
        home: _isLoggedIn ? Counter() : HomeScreen()
    );

  }
}






class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF019798),
              Colors.white,
              Colors.white,
            ],
          )),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/loggo.png",
                      width: 250,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                     const Text(
                      "Diollo System",
                      style: TextStyle(fontSize: 30, color: Color(0xFF019798)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "manage your orders from here...",
                      style: TextStyle(fontSize: 16, color: Color(0xFF019798)),
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, top: 0.0, right: 35.0, bottom: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              // side: BorderSide(color: Colors.red)
                            ))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, top: 10.0, right: 35.0, bottom: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    const MaterialStatePropertyAll(Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: const BorderSide(
                                            color: Color(0xFF019798),
                                            width: 2)))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF019798)),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
