import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // L'utilisateur est connecté avec succès, vous pouvez effectuer des actions supplémentaires ici
      print('Utilisateur connecté: ${userCredential.user!.uid}');
    } catch (e) {
      // Gérer les erreurs de connexion ici
      print('Erreur de connexion: $e');
    }
  }

  Future<void> _registerWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('Utilisateur inscrit: ${userCredential.user!.uid}');
    } catch (e) {
      print('Erreur d\'inscription: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de connexion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: Text('Se connecter'),
            ),
            SizedBox(height: 8.0),
            Text('ou'),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _registerWithEmailAndPassword,
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}