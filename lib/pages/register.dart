import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../components/my_button.dart';
import '../components/text_field.dart';

class Register extends StatefulWidget {
	final void Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // controllers
	final emailController = TextEditingController();
	final passwordController = TextEditingController();
	final confirmPasswordController = TextEditingController();

	void register() {}

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
	
									// register message
									const Text(
										"Register Yourself to the Peekaboo App"
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
	
									// confirm password
									MyTextField(
										controller: confirmPasswordController, 
										hintText: 'Confirm Password', 
										obscureText: true
									),

									// register button
									MyButton(
										onTap: register, 
										text: 'Register'
									),

									const SizedBox(
										height: 20,
									),
	
									// already a member? sign in
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											const Text('Already a user? '),
											GestureDetector(
												onTap: widget.onTap,
												child: Text(
													'Sign In',
													style: TextStyle(
														fontWeight: FontWeight.bold,
														color: HexColor('#5271ff')
													),
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
