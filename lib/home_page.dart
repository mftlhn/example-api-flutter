import 'package:example_api/models/user_model.dart';
import 'package:example_api/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    UserModel? user = auth.user;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selamat datang ' + user!.name.toString() + '!'),
              const SizedBox(
                height: 50,
              ),
              Text('Nama : ' + user.name.toString()),
              Text('Email : ' + user.email.toString())
            ],
          )),
    );
  }
}
