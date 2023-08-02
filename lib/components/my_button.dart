import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyButton extends StatelessWidget {
	final void Function()? onTap;
	final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
			padding: const EdgeInsets.all(10.0),
			child: GestureDetector(
					onTap: onTap,
					child: Container(
						padding: const EdgeInsets.all(25.0),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(9),
							color: HexColor('#5271ff'),
						),
						child: Center(
							child: Text(
								text,
								style: const TextStyle(
									color: Colors.white,
									fontWeight: FontWeight.bold,
								),
							),
						),
					),
				),
		);
  }
}
