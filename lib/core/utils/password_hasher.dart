import 'dart:convert';
import 'package:crypto/crypto.dart';

/// One-way hashing so Firestore never stores a plaintext password.
/// Not equivalent to Firebase Auth's guarantees (no per-user salt, no
/// rate limiting) — good enough to avoid plaintext for now, not a
/// long-term substitute for real auth.
class PasswordHasher {
  PasswordHasher._();

  static String hash(String plainPassword) {
    return sha256.convert(utf8.encode(plainPassword.trim())).toString();
  }
}