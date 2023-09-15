import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
	final String message;
	final Color clr;
	final Color fontClr;
  const ChatBubble({
		super.key,
		required this.message,
		required this.clr,
		required this.fontClr
	});

  @override
  Widget build(BuildContext context) {
    return Container(
				padding: const EdgeInsets.all(8.0),
				decoration: BoxDecoration(
					color: clr,
					borderRadius: BorderRadius.circular(7),
				),
				child: FittedBox(
					fit: BoxFit.fill,
					child: Text(
						message,
						style: TextStyle(
							color: fontClr,
							fontSize: 16,
						),
					),
				),
			);
  }
}
