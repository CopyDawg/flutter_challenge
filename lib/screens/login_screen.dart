import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_challenge_app/infrastructure/login_controller.dart';


class LoginScreen extends StatefulWidget{

  static const name = 'login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();


  Future<void> handleLogin(String username, String password) async {

    int statusCode = await loginController(username, password);

    if (statusCode == 200) {
      context.go('/');
    } else {
      print('Error en el inicio de sesión.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
        child: Container(
          height: 500,
          padding: const EdgeInsets.all(20.0),
          child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          
                    const Text('SIGN IN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          
                    TextFormField(
                      controller: _usernameTextController,
                      decoration:  const InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.person),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
          
                    const SizedBox(height: 20),
          
                    TextFormField(
                      controller: _passwordTextController,
                      decoration:  const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.lock),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
          
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => context.go('/register'),
                          child: const Text("Register Here", style: TextStyle(color: Color.fromARGB(255, 153, 3, 3)))
                        ),
                      ] 
                    ),

                    const SizedBox(height: 20),
          
                    ElevatedButton(
                        style: ElevatedButton.styleFrom( 
                          minimumSize: const Size(150, 40),
                          backgroundColor: Colors.black, 
                          foregroundColor: Colors.white, 
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () => {
                          handleLogin(
                            _usernameTextController.text,
                            _passwordTextController.text,
                          )
                        },
                        child: const Text('LOGIN'),
                      ),
                    
          
          
          
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

