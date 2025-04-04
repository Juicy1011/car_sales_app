import 'package:mysql1/mysql1.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../configs/database_config.dart';

class DatabaseService {
  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: DatabaseConfig.host,
      port: DatabaseConfig.port,
      user: DatabaseConfig.user,
      password: DatabaseConfig.password,
      db: DatabaseConfig.database,
    );
    return await MySqlConnection.connect(settings);
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  static Future<bool> registerUser(
      String username, String email, String password, String phone) async {
    final conn = await getConnection();
    try {
      final hashedPassword = hashPassword(password);
      await conn.query(
          'INSERT INTO users (username, email, password, phone) VALUES (?, ?, ?, ?)',
          [username, email, hashedPassword, phone]);
      return true;
    } catch (e) {
      print('Registration error: $e');
      return false;
    } finally {
      await conn.close();
    }
  }
}
