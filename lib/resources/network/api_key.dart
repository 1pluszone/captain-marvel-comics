class ApiKey implements MustHave {
  String publicKey = "yourPublicKeyHere";
  String privateKey = "yourPrivateKeyHere";
}

//final _apiKey = ApiKey();

abstract class MustHave {
  String publicKey;
  String privateKey;
}
