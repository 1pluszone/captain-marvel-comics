//import 'api_key.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:marvel_comics/providers/comics_provider.dart';

class ApiCalls {
  //  http://gateway.marvel.com/v1/public/comics?ts=1&apikey=1234&hash=ffd275c5130566a2916217b101f26150

  final String baseUrl = "http://gateway.marvel.com/v1/public/";
  //final String comicsApi = "comics?";
  //final String charactersApi = "characters?";
  final String captainMarvelAppearance = "characters/1010338/comics?";
  final String captainMarvelComics = "characters/1010338?";
  final String publicKey = "c002e74122d2a21cf576c369fb693cb5";
  final privateKey = "ce6177476efab6390596869875ddbcc1c6b3135c";

  final String comics = "comics?characters=1010338&";

  HashTs hashValued() {
    String ts = DateTime.now().toString();
    var bytes = utf8.encode("$ts$privateKey$publicKey"); // data being hashed

    Digest hashValue = md5.convert(bytes);
    print(hashValue);
    print(hashValue.toString());
    HashTs hashts = HashTs();
    hashts.ts = ts;
    hashts.hash = hashValue;
    return hashts;
  }

//comics in which captain appears
  Future<http.Response> getAppearance(
      [int offset = 0, Sorting sorting = Sorting.descending]) async {
    String orderBy;
    HashTs hashTs = hashValued();
    orderBy = (sorting == Sorting.descending) ? "onsaleDate" : "-onsaleDate";

    final url =
        "$baseUrl${captainMarvelAppearance}ts=${hashTs.ts}&apikey=$publicKey&hash=${hashTs.hash}&offset=$offset&orderBy=$orderBy";
    final response = await http.get(url);
    print(response);
    return response;
  }

  //captain marvin comics....
  Future<http.Response> getCaptainMarvelComicsOnly([int offset = 0]) async {
    HashTs hashTs = hashValued();

    final url =
        "$baseUrl${comics}ts=${hashTs.ts}&apikey=$publicKey&hash=${hashTs.hash}&offset=$offset";
    final response = await http.get(url);
    print(response);
    return response;
  }
}

class HashTs {
  String ts;
  Digest hash;
}
