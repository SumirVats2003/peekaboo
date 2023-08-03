import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:peekaboo/components/my_button.dart';
import 'package:peekaboo/components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	// controllers
	final emailController = TextEditingController();
	final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Colors.grey[300],
			body: SafeArea(
				child: Center(
					child: Padding(
						padding: const EdgeInsets.all(25.0),
						child: SingleChildScrollView(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									// logo,
									Image.asset(
										'assets/logoText.png',
										width: 100,
									),

									const SizedBox(
										height: 20,
									),
	
									// welcome back message
									const Text(
										"Welcome Back! You've been missed!!!"
									),

									const SizedBox(
										height: 40,
									),
	
									// email
									MyTextField(
										controller: emailController, 
										hintText: 'Email', 
										obscureText: false
									),
	
									// password
									MyTextField(
										controller: passwordController, 
										hintText: 'Password', 
										obscureText: true
									),

									// sign in button
									const MyButton(onTap: null, text: 'Sign In'),

									const SizedBox(
										height: 20,
									),
	
									// not a member? register now
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											const Text('Not a member? '),
											Text(
												'Register Now',
												style: TextStyle(
													fontWeight: FontWeight.bold,
													color: HexColor('#5271ff')
												),
											)
										],
									)
								],
							),
						),
					),
				),
			),
		);
  }
}
