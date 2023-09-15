import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peekaboo/model/message.dart';

class ChatService extends ChangeNotifier {
	// instance of auth and firestore
	final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
	final FirebaseFirestore _firestore = FirebaseFirestore.instance;

	// Send Messages
	Future<void> sendMessage(String receiverId, String message) async {
		// get current user info
		final String currentUserId = _firebaseAuth.currentUser!.uid;
		final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
		final Timestamp timestamp = Timestamp.now();

		// create new message
		Message newMessage = Message(
			senderId: currentUserId, 
			senderEmail: currentUserEmail, 
			receiverId: receiverId, 
			message: message, 
			timestamp: timestamp
		);

		// construct chat room id from current user id and receiver id
		// sorter to ensure uniqueness
		List<String> ids = [currentUserId, receiverId];
		ids.sort();
		String chatRoomId = ids.join("_");

		// add new message to database
		await _firestore
				.collection('chat_rooms')
				.doc(chatRoomId)
				.collection('messages')
				.add(newMessage.toMap());
	}

	// Get Messages
	Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
		List<String> ids = [userId, otherUserId];
		ids.sort();
		String chatRoomId = ids.join("_");

		return _firestore
				.collection('chat_rooms')
				.doc(chatRoomId)
				.collection('messages')
				.orderBy('timestamp', descending: false)
				.snapshots();
	}
}
