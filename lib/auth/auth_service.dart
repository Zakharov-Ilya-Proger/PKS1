import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> singInWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth.signInWithPassword(
        password: password,
        email: email
    );
  }

  Future<AuthResponse> singUpWithEmailPassword(
      String email, String password) async {
    return await _supabase.auth.signUp(
        password: password,
        email: email,
    );
  }

  Future<void> singOut() async {
    await _supabase.auth.signOut();
  }

  String? getCurrentUserEmail(){
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  String? getCurrentUserid(){
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }
}