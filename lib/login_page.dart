import 'package:example_api/main_page.dart';
import 'package:example_api/providers/auth_provider.dart';
import 'package:example_api/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignIn() async {
      if (_emailController.text == '' || _passwordController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Email dan password tidak boleh kosong',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xffED6363),
        ));
      } else {
        if (await authProvider.login(
            email: _emailController.text, password: _passwordController.text)) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Email atau password salah',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xffED6363),
          ));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Email'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Input Email',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('Password'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                      hintText: 'Input Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(isObscure
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  onPressed: () {
                    handleSignIn();
                  },
                  child: const Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum memiliki akun? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(color: Colors.lightBlueAccent),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
