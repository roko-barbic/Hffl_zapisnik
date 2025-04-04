import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/utility/secure_storage.dart';

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

  AuthState copyWith({bool? isLoading, bool? isLoggedIn, String? error, bool? isGuestMode, bool? wasErrorDisplayed}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isGuestMode: isGuestMode ?? this.isGuestMode,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final HfflApi hfflApi;

  AuthCubit(this.hfflApi) : super(const AuthState()) {}

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
    if(state.isLoggedIn){
      await SecureStorage.deleteTokens();
      emit(state.copyWith(isLoggedIn: false));
    }
    else{
      emit(state.copyWith(isGuestMode: false));
    }
  }

  Future<void> tokenCheck() async {
    bool isTokenSaved = await SecureStorage.isThereToken();
    emit(state.copyWith(isLoggedIn: isTokenSaved));
  }

  Future<String?> getToken() async => await SecureStorage.getToken();

  void loginAsGuest(){
    emit(state.copyWith(isGuestMode: true));
  }
}