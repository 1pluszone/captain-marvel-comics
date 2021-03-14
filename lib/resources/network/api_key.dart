class ApiKey implements MustHave {
  String publicKey = "c002e74122d2a21cf576c369fb693cb5";
  String privateKey = "ce6177476efab6390596869875ddbcc1c6b3135c";
}

//final _apiKey = ApiKey();

abstract class MustHave {
  String publicKey;
  String privateKey;
}
