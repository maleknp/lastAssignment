import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/home.dart';
import 'package:login/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/services/AuthService.dart';

// void main() {
//   runApp(MaterialApp(home: Counter(),));
// }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _CounterState();
}

class _CounterState extends State<Login> {
  bool _isLoggedIn = false;

  static const NAME_KEY = "name";
  static const EMAIL_KEY = "email";
  static const PASSWORD_KEY = "password";
  static const TOKEN_KEY = "token";
  SharedPreferences? pref;

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

  _CounterState() {
    getSharePref();
  }

  Future<void> getSharePref() async {
    pref = await SharedPreferences.getInstance();
  }


  Future<void> setData(String name,String email,String password,String token) async {
    await pref?.setString(NAME_KEY, name);
    await pref?.setString(EMAIL_KEY, email);
    await pref?.setString(PASSWORD_KEY, password);
    await pref?.setString(TOKEN_KEY, token);
  }

  int x = 0;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordObs = true;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {

  if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      setState(() {
        _errorMessage = "";
      });
      try {
        final data = await AuthService.login(
          emailController.text,
          passwordController.text,
        );

        final responseBody = json.decode(data.body);

        if (data.statusCode == 401) {
          setState(() {
            _errorMessage = responseBody['errors']['email'][0];
            _isLoading = false;
          });
          return;
        }

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', responseBody['data']['access_token']);
        prefs.setString('email', responseBody['data']['user']['email']);
        prefs.setString('password', passwordController.text);
        prefs.setString('name', responseBody['data']['user']['name']);
        prefs.setBool('isLoggedIn', true);

        // Navigate to main screen if login is successful
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Counter()),
        );
      } catch (error) {
        setState(() {
          _isLoading = false;
        });

        // Show error message to user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to login'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
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
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
              child: Form(
                key: formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Image.asset(
                          "assets/images/loggo.png",
                          width: 150,
                        ),
                        const Text(
                          "Diollo System",
                          style:
                          TextStyle(fontSize: 30, color: Color(0xFF019798)),
                        ),
                        const Text(
                          "manage your orders from here...",
                          style:
                          TextStyle(fontSize: 16, color: Color(0xFF019798)),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Login to Continue",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF019798),
                              fontWeight: FontWeight.w600),
                        ),
                        if (_errorMessage != null)
                          Text(
                            _errorMessage!,textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, top: 0.0, right: 35.0, bottom: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                                label: Text("Email"),
                                hintText: "Enter your email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                prefixIcon: Icon(Icons.email)),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (email) {
                              if (email?.isEmpty == true) {
                                return "Email can't be empty";
                              }else if (email?.contains("@") == false) {
                                return "Most enter a Email";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35.0, top: 0.0, right: 35.0, bottom: 10.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

                              label: Text("Password"),
                              hintText: "Enter your password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    isPasswordObs = !isPasswordObs;
                                    setState(() {});
                                  },
                                  icon: isPasswordObs
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off)),
                            ),
                            obscureText: isPasswordObs,
                            onChanged: (text) {
                              print(text);
                            },
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.go,
                            validator: (pass) {
                              if (pass?.isEmpty == true) {
                                return "Password can't be empty";
                              }else if(pass != null && pass.length < 8){
                                return "Password can't be less then 8 digits";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                  if(formKey.currentState?.validate() == true){
                                    _isLoading ? null : _login();
                                  }
                                },
                                child: _isLoading
                                    ? CircularProgressIndicator()
                                    : const Text(
                                  "LOGIN",
                                  style: TextStyle(fontSize: 18),
                                )),

                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const HomeScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Sign Up  ",
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF019798)),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: const [
                                Text(
                                  "Don’t have account? ",
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xFFB5B3B3)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
