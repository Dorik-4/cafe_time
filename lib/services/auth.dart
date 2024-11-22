import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:dio/dio.dart';


String hashPassword(String password) {
  var bytes = utf8.encode(password);
  var digest = sha256.convert(bytes);
  return digest.toString();
}


String encryptHashedPassword(String hashedPassword, String publicKeyString) {
  final parser = encrypt.RSAKeyParser();
  final RSAPublicKey publicKey = parser.parse(publicKeyString) as RSAPublicKey;
  final encrypter = encrypt.Encrypter(encrypt.RSA(publicKey: publicKey));
  final encrypted = encrypter.encrypt(hashedPassword);
  return encrypted.base64;
}


Future<bool> sendAuth(String login, String password) async {
  String hashedPassword = hashPassword(password);

  String serverPublicKey = """
  -----BEGIN PUBLIC KEY-----
  MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5qEsRix0Ga8FTMaubrg0
  fzKaTh7mzTSnVlT/2iF9J2t92eJr5dV7ltrqr4dgKgZ7r6xqf6Y6HHMuGcPuHkJy
  B4lsiMCP8o19Px9uwuPy2vneI7VQdKEfYSyAD/qSNT+HRyXfgWwSFSsyKtKDRcze
  OubTVCo9+20cVAkoHKlghQq2lb481XlYOvtpiwCesPkuYFiV0Uy7TMScYT2IVjpu
  IObAjt5yXGDJNg5k10UGaJq3SF4Xwk7Uu3Di+gHASUFakoHWwnDJrqQiVgErv3W2
  P5FAsQtYzXicaHXVuShvJ1RUqFQqDcHYndxC1gCXrrhRvOMfycyQDeKbvB8t8zNr
  SwIDAQAB
  -----END PUBLIC KEY-----
  """;

  String encryptedPassword = encryptHashedPassword(
      hashedPassword,
      serverPublicKey
  );

  const String apiUrl = 'https://hackers54.ru:4433/api/v1.0/auth/login';
  final Dio dio = Dio();

  try {
    final response = await dio.post(
        apiUrl,
        data: {
          "login": login,
          "password": encryptedPassword
        }
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    throw Exception('Не удалось подключиться к API: $e');
  }
}
