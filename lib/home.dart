import 'package:flutter/material.dart';
import 'package:login/services/PackageService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login/logout.dart';

import 'Package.dart';
import 'login.dart';

// void main() {
//   runApp(MaterialApp(home: Counter(),));
// }

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  late Future<List<Package>> _packagesFuture;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // _packagesFuture = PackageService().getPackages(_currentPage);
    _packagesFuture = PackageService().getPackages(_currentPage, 10);

    print(_packagesFuture);
  }



  SharedPreferences? pref;

  _CounterState() {
    getSharePref();
  }

  Future<void> getSharePref() async {
    pref = await SharedPreferences.getInstance();
  }

  int x = 0;
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPasswordObs = true;

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
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Counter()),
            );}, icon: Icon(Icons.refresh)),
            actions: [
              PopupMenuButton(itemBuilder: (context){
                return [
                // const PopupMenuItem(child: Text("Profile"),
                // value: 1,),
                  const PopupMenuItem(child: Text("LogOut"),
                    value: 2,),
                ];
              },
                onSelected: (value){
                    if(value == 1){
                      print("Profile");
                    }else{
                      print("Logout");
                      logout(context);
                    }
                },
              )
            ],
          ),

          body: FutureBuilder<List<Package>>(
            future: _packagesFuture,
            builder: (context, snapshot) {
              print(snapshot.data); // add this line to see the snapshot data
              if (snapshot.hasData) {
                final packages = snapshot.data!;
                print("hereeeeeeeeeeee"); // add this line to print the packages list
                print(packages); // add this line to print the packages list

                return ListView.builder(
                  itemCount: packages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final package = packages[index];
                    if (index == packages.length - 1) {
                      // User has reached the end of the list, fetch next page
                      _currentPage++;
                      PackageService().getPackages(_currentPage, 10).then((newPackages) {
                        setState(() {
                          packages.addAll(newPackages);
                        });
                      });
                    }
                    return ListTile(
                      title: Text(package.name ?? ''),
                      subtitle: Text(package.description ?? ''),
                      trailing: Text('\$${package.price?.toStringAsFixed(2) ?? ''}'),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),

        ),
    );
  }
}