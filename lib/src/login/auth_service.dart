import 'dart:async';

import 'package:angular/angular.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/src/auth.dart';
import 'package:langcab_ui/src/message/message.dart';
import 'package:langcab_ui/src/message/message_service.dart';

@Injectable()
class AuthService {
  Future<String> idToken;
  fb.User user;
  fb.Auth _fbAuth;
  fb.GoogleAuthProvider _fbGoogleAuthProvider;
  fb.FacebookAuthProvider _fbFacebookAuthProvider;
  fb.TwitterAuthProvider _fbTwitterAuthProvider;
  fb.GithubAuthProvider _fbGithubAuthProvider;
  final MessageService _messageService;

  AuthService(this._messageService) {
    fb.initializeApp(
      apiKey: "AIzaSyCdfJN9WVpmYGXvL5V5XRxnW8sXdi74WjY",
      authDomain: "auth.langcab.com"
    );

    _fbGoogleAuthProvider = new fb.GoogleAuthProvider();
    _fbFacebookAuthProvider = new fb.FacebookAuthProvider();
    _fbTwitterAuthProvider = new fb.TwitterAuthProvider();
    _fbGithubAuthProvider = new fb.GithubAuthProvider();
    _fbAuth = fb.auth();
    _fbAuth.onAuthStateChanged.listen(_authChanged);
  }

  void _authChanged(fb.User fbUser) {
    user = fbUser;
    getToken();
  }

  Future googleSignIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGoogleAuthProvider);
    }
    catch (error) {
      _messageService.add(new Message('An error occurred: ', '$error', 'danger'));
      print("$runtimeType::login() -- $error");
    }
  }

  Future facebookSignIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbFacebookAuthProvider);
    }
    catch (error) {
      _messageService.add(new Message('An error occurred: ', '$error', 'danger'));
      print("$runtimeType::login() -- $error");
    }
  }

  Future twitterSignIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbTwitterAuthProvider);
    }
    catch (error) {
      _messageService.add(new Message('An error occurred: ', '$error', 'danger'));
      print("$runtimeType::login() -- $error");
    }
  }

  Future gitHubSignIn() async {
    try {
      await _fbAuth.signInWithPopup(_fbGithubAuthProvider);
    }
    catch (error) {
      _messageService.add(new Message('An error occurred: ', '$error', 'danger'));
      print("$runtimeType::login() -- $error");
    }
  }

  Future emailSignUp(String email, String password) async {
    try {
      await _fbAuth.createUserWithEmailAndPassword(email, password);
      user.sendEmailVerification();
    }
    catch (error) {
      _messageService.add(new Message('An error occurred: ', '$error', 'danger'));
      print("$runtimeType::login() -- $error");
    }
  }

  Future emailSignIn(String email, String password) async {
    try {
      await _fbAuth.signInAndRetrieveDataWithEmailAndPassword(email, password);
    }
    catch (error) {
      _messageService.add(new Message('An error occurred: ', '$error', 'danger'));
      print("$runtimeType::login() -- $error");
    }
  }

  void signOut() {
    _fbAuth.signOut();
  }

  isEmailUser(fb.User user) {
    for (UserInfo u in user.providerData) {
      if (u.providerId == 'password')
        return true;
      else
        return false;
    }
  }

  Future<String> getToken() async {
    if (user != null) {
      if (!isEmailUser(user) || user.emailVerified)
        return user.getIdToken(true);
      else {
        _messageService.add(new Message('Sign in error: ', 'Please verify your email', 'danger'));
        _fbAuth.signOut();
        throw new Exception('Email is not verified');
      }
    } else {
      for (int i=0;i<20;i++) {
        await new Future.delayed(const Duration(milliseconds: 50));
        if (user != null)
          return user.getIdToken(true);
      }
      _messageService.add(new Message('Warning: ', 'Please sign in or register a new account.', 'warning'));
      throw new Exception('Please sign in or register a new account.');
    }
  }
}