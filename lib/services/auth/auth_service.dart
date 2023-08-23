import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
	// instance of auth
	final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

	// sign in method
	Future<UserCredential> signInWithEmailAndPassword(
			String email, String password) async {
		try {
			// sign in
			UserCredential userCredential = 
					await _firebaseAuth.signInWithEmailAndPassword(
				email: email, 
				password: password
			);

			return userCredential;
		} 
		
		on FirebaseAuthException catch (e) {
			throw Exception(e.code);
		}
	}

	// sign out method
}
