import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peekaboo/components/chat_bubble.dart';
import 'package:peekaboo/components/text_field.dart';
import 'package:peekaboo/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
	final String receiverUserEmail;
	final String receiverUserId;
  const ChatPage({
		super.key,
		required this.receiverUserEmail,
		required this.receiverUserId
	});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
	final TextEditingController _messageController = TextEditingController();
	final ChatService _chatService = ChatService();
	final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

	void sendMessage() async {
		if (_messageController.text.isNotEmpty) {
			await _chatService.sendMessage(
				widget.receiverUserId, _messageController.text);
			// clear controller
			_messageController.clear();
		}
	}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			appBar: AppBar(
				title: Text(widget.receiverUserEmail),
			),

			body: Column(
				children: [
					const SizedBox(height: 10,),

					// messages
					Expanded(child: _buildMessageList(),),

					// input box
					_buildMessageInput(),
				],
			),
		);
  }

	// build message list
	Widget _buildMessageList() {
		return StreamBuilder(
			stream: _chatService.getMessages(
				_firebaseAuth.currentUser!.uid, widget.receiverUserId),

			builder: (context, snapshot) {
				if (snapshot.hasError) {
					return Text("Error ${snapshot.error}");
				}

				if (snapshot.connectionState == ConnectionState.waiting) {
					return const Text('Loading..');
				}

				return ListView(
					children: 
					snapshot.data!.docs
							.map((document) => _buildMessageItem(document))
							.toList(),
				);
			},
		);
	}

	// build message item
	Widget _buildMessageItem(DocumentSnapshot document) {
		Map<String, dynamic> data = document.data() as Map<String, dynamic>;

		// align the message to the right if it is sent by current user
		// to the left otherwise
		var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid);
		var align = alignment? Alignment.centerRight:Alignment.centerLeft;
		var clr = alignment? Colors.blue
				:const Color.fromARGB(255, 196, 196, 196);
		var fontClr = alignment? Colors.white: Colors.black;
		var crossAlgn = alignment? CrossAxisAlignment.end:CrossAxisAlignment.start;
		var mainAlgn = alignment? MainAxisAlignment.end:MainAxisAlignment.start;

		return Padding(
			padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
			child: Container(
				padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
				alignment: align,
				// decoration: BoxDecoration(
				// 	color: Colors.white,
				// 	borderRadius: BorderRadius.circular(7),
				// ),
				child: Column(
					crossAxisAlignment: crossAlgn,
					mainAxisAlignment: mainAlgn,
					children: [
						ChatBubble(message: data['message'], clr: clr, fontClr: fontClr)
					],
				),
			),
		);
	}

	// build user input
	Widget _buildMessageInput() {
		return Row(
			children: [
				// text input
				Expanded(
					child: MyTextField(
						controller: _messageController,
						hintText: "Message",
						obscureText: false,
					),
				),

				IconButton(
					onPressed: sendMessage,
					icon: const Icon(
						Icons.send,
						size: 30,
						color: Colors.blue,
					),
				)
			],
		);
	}
}
