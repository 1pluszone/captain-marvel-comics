//import 'api_key.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class ApiCalls {
  //  http://gateway.marvel.com/v1/public/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150

  final String baseUrl = "http://gateway.marvel.com/v1/public/";
  final String comicsApi = "comics?";
  final String charactersApi = "characters?";
  final String captainMarvelAppearance = "characters/1010338/comics?";
  final String captainMarvelComics = "characters/1010338?";
  String publicKey = "c002e74122d2a21cf576c369fb693cb5";
  String privateKey = "ce6177476efab6390596869875ddbcc1c6b3135c";

  Future<http.Response> getComics([int offset = 0]) async {
    String ts = currentDateTime();

    var bytes = utf8.encode("$ts$privateKey$publicKey"); // data being hashed

    Digest hashValue = md5.convert(bytes);
    print(hashValue);
    print(hashValue.toString());
    final url =
        "$baseUrl${captainMarvelAppearance}ts=$ts&apikey=$publicKey&hash=$hashValue&offset=$offset";
    final response = await http.get(url);
    print(response);
    return response;
  }

  Future<http.Response> getCaptainMarvelComics([int offset = 0]) async {
    String ts = currentDateTime();

    var bytes = utf8.encode("$ts$privateKey$publicKey");
    Digest hashValue = md5.convert(bytes);

    final url =
        "$baseUrl${captainMarvelComics}ts=$ts&apikey=$publicKey&hash=$hashValue&offset=$offset";
    final response = await http.get(url);
    print(response);
    return response;
  }

  String currentDateTime() {
    return DateTime.now().toString();
  }
}
