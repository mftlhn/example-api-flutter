import 'package:example_api/login_page.dart';
import 'package:example_api/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _passwordConfirmationController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    bool isObscure1 = true;
    bool isObscure2 = true;

    handleSignUp() async {
      if (_passwordController.text != _passwordConfirmationController.text) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Password dan Konfirmasi Passwod tidak sama!',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xffED6363),
        ));
      } else {
        if (await authProvider.register(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text)) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Registrasi berhasil',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xff52BF90),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Registrasi gagal',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Color(0xffED6363),
          ));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Register Page')),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name'),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Input Name'),
                  controller: _nameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Email'),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Input Email'),
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Password'),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: isObscure1,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Input Password',
                      suffixIcon: IconButton(
                          onPressed: (() {
                            setState(() {
                              isObscure1 = !isObscure1;
                              // print(isObscure1);
                            });
                          }),
                          icon: Icon(isObscure1
                              ? Icons.visibility
                              : Icons.visibility_off))),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Password Confirmation'),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: isObscure2,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Input Password Confirmation',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure2 = !isObscure2;
                            });
                          },
                          icon: isObscure2
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off))),
                  controller: _passwordConfirmationController,
                ),
                const SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  onPressed: () {
                    handleSignUp();
                  },
                  child: const Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 40)),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah memiliki akun? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Masuk',
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
