import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:peekaboo/components/my_button.dart';
import 'package:peekaboo/components/text_field.dart';
import 'package:peekaboo/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
	final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
	// controllers
	final emailController = TextEditingController();
	final passwordController = TextEditingController();

	void signIn() async {
		final authService = Provider.of<AuthService>(context, listen: false);

		try {
			await authService.signInWithEmailAndPassword(
				emailController.text,
				passwordController.text
			);
		}
		catch(e) {
			ScaffoldMessenger.of(context)
			.showSnackBar(SnackBar(content: Text(e.toString())));
		}
	}

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
									MyButton(
										onTap: signIn, 
										text: 'Sign In'
									),

									const SizedBox(
										height: 20,
									),
	
									// not a member? register now
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											const Text('Not a member? '),
											GestureDetector(
												onTap: widget.onTap,
												child: Text(
													'Register Now',
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
