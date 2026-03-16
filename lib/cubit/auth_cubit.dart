import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/utility/secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http; // Make sure to add this package if you don't have it

class AuthState {
  final bool isLoading;
  final bool isLoggedIn;
  final bool isGuestMode;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.isGuestMode = false,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    String? error,
    bool? isGuestMode,
    bool? wasErrorDisplayed
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isGuestMode: isGuestMode ?? this.isGuestMode,
      error: error ?? this.error,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final HfflApi hfflApi;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  AuthCubit(this.hfflApi) : super(const AuthState());

  Future<void> login(String email, String password, BuildContext context) async {
    emit(state.copyWith(isLoading: true, error: null));
    try{
      final authResult = await hfflApi.login(email, password);
      if (authResult != null && authResult.result && authResult.token != null && authResult.refreshToken != null) {
        await SecureStorage.saveTokens(authResult.token!, authResult.refreshToken!);
        emit(state.copyWith(isLoading: false, isLoggedIn: true));
      } else {
        emit(state.copyWith(isLoading: false, error: authResult?.errors?.join(', ') ?? 'Login failed'));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login nije ispravan'),
            backgroundColor: Colors.red,
          ),
        );
      }

    } catch(e){
      emit(state.copyWith(isLoading: false, error: 'Login failed', wasErrorDisplayed: false));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login nije ispravan'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> loginWithGoogle(BuildContext context) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      await _googleSignIn.initialize(
        serverClientId: '869637610427-2vq4usedrukna3c99dlkdr2tk5in1sn3.apps.googleusercontent.com',
      );
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        emit(state.copyWith(isLoading: false));
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(state.copyWith(isLoading: false, error: 'Neuspješno dohvaćanje Google tokena.'));
        return;
      }
      final response = await http.post(
        Uri.parse('https://90d5-93-142-72-149.ngrok-free.app/api/Authentication/GoogleLogin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String token = responseData['token'];
        final String refreshToken = responseData['refreshToken'];

        bool isAdmin = false;
        try {
          final parts = token.split('.');
          if (parts.length == 3) {
            final String payloadStr = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
            final Map<String, dynamic> payloadMap = jsonDecode(payloadStr);
            isAdmin = payloadMap['IsAdmin'] == 'True';
          }
        } catch (e) {
          print('Greška pri čitanju tokena: $e');
        }
        await SecureStorage.saveTokens(token, refreshToken);
        if (isAdmin) {
          emit(state.copyWith(isLoading: false, isLoggedIn: true, isGuestMode: false));
        } else {
          emit(state.copyWith(isLoading: false, isLoggedIn: true, isGuestMode: true));
        }

      } else {
        emit(state.copyWith(isLoading: false, error: 'Login failed'));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseData['errors']?.first ?? 'Dogodila se pogreška pri prijavi.'),
          backgroundColor: Colors.red,
        ));
        await _googleSignIn.signOut();
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Pogreška: $e'));
      try { await _googleSignIn.signOut(); } catch(_) {}
    }
  }

  Future<bool> refresh() async {
    final refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken == null) {
      emit(state.copyWith(isLoggedIn: false, error: 'No refresh token'));
      return false;
    }
    final token = await SecureStorage.getToken() ?? "";
    final authResult = await hfflApi.refreshToken(TokenRequest(token: token, refreshToken: refreshToken));
    if (authResult != null && authResult.result && authResult.token != null && authResult.refreshToken != null) {
      await SecureStorage.saveTokens(authResult.token!, authResult.refreshToken!);
      return true;
    } else {
      emit(state.copyWith(isLoggedIn: false, error: authResult?.errors?.join(', ') ?? 'Refresh failed'));
      await SecureStorage.deleteTokens();
      return false;
    }
  }

  Future<void> logout() async {
    //TODO potencijalno dodat overlay loading
    await _googleSignIn.signOut(); // Make sure to sign out of Google too!
    await SecureStorage.deleteTokens();
    emit(state.copyWith(isLoggedIn: false, isGuestMode: false));
  }

  Future<void> tokenCheck() async {
    final token = await SecureStorage.getToken();

    if (token != null && token.isNotEmpty) {
      bool isAdmin = true;

      try {
        final parts = token.split('.');
        if (parts.length == 3) {
          final String payloadStr = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
          final Map<String, dynamic> payloadMap = jsonDecode(payloadStr);

          if (payloadMap.containsKey('IsAdmin')) {
            isAdmin = payloadMap['IsAdmin'] == 'True';
          }
        }
      } catch (e) {
        print('Greška pri čitanju tokena pri pokretanju: $e');
      }

      emit(state.copyWith(
          isLoggedIn: true,
          isGuestMode: !isAdmin
      ));
    }
    else {
      bool isGuestMode = await SecureStorage.isGuestModeOn();
      emit(state.copyWith(
          isLoggedIn: false,
          isGuestMode: isGuestMode
      ));
    }
  }

  Future<String?> getToken() async => await SecureStorage.getToken();

  void loginAsGuest() async {
    await SecureStorage.deleteTokens();
    await SecureStorage.saveGuestMode();
    emit(state.copyWith(isGuestMode: true));
  }
}