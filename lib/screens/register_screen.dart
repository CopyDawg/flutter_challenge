import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_challenge_app/infrastructure/register_controller.dart';

class RegisterScreen extends StatefulWidget{

  static const name = 'register-screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _password2TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          // color: Colors.amber[600],
          padding: const EdgeInsets.all(20.0),
          child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
          
                    const Text('SIGN UP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          
                    TextFormField(
                      controller: _usernameTextController,
                      decoration:  const InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.person),
                        ),
                      ),
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
                      obscureText: true,
                    ),
          
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _password2TextController,
                      decoration:  const InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.lock),
                        ),
                      ),
                      obscureText: true,
                    ),
          
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => context.go('/login'),
                          child: const Text("Sign In", style: TextStyle(color: Color.fromARGB(255, 153, 3, 3)))
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
                        onPressed: () async {
                          
                          if(_password2TextController.text == _passwordTextController.text){
                            int statusCode = await registerController(_usernameTextController.text, _passwordTextController.text);
                            
                            if (statusCode == 200) {
                              context.go('/login');
                            } 
                            else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text("Couldn't register, try again."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                          }
                          else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text("Passwords don't match."),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          //context.go('/login')

                        },
                        child: const Text('REGISTER'),
                      ),
                    
          
          
          
                  ],
                ),
              ),
        ),
      ),
    );
  }
}