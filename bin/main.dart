import 'dart:async';
import 'dart:convert';
import 'package:alura_dart_assincronismo/key.dart';
import 'package:http/http.dart';

StreamController<String> streamController = StreamController<String>();

void main() {
  StreamSubscription subscricao = streamController.stream.listen(
    (event) => print(event),
  );
  requestData();
  readDataAsync();
}

Future<void> requestData() async {
  String url =
      "https://gist.githubusercontent.com/adam-univesp/826ff7f981fe321bf5b03763c1516508/raw/bf34368e8a293ce9e52b17c9ec45056d4529a99a/accounts.json";
  Uri uri = Uri.parse(url);
  Future<Response> futureResponse = get(uri);
  futureResponse.then((response) {
    streamController.add(
      "${DateTime.now()} | Requisicao de leitura usando then.",
    );
  });
}

Future<List<dynamic>> readDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/adam-univesp/826ff7f981fe321bf5b03763c1516508/raw/bf34368e8a293ce9e52b17c9ec45056d4529a99a/accounts.json";
  Uri uri = Uri.parse(url);
  Response resposta = await get(uri);
  List<dynamic> listAccount = json.decode(resposta.body);
  streamController.add(
    "${DateTime.now()} | Requisicao de leitura usando Future",
  );
  return listAccount;
}

sendDataAsync(Map<String, dynamic> account) async {
  List<dynamic> listAccount = await readDataAsync();
  listAccount.add(account);
  String url = "https://api.github.com/gists/826ff7f981fe321bf5b03763c1516508";
  Uri uri = Uri.parse(url);
  Map<String, String> headder = {"Authorization": "Bearer $gist_key"};
  Map<String, dynamic> body = {
    "description": "accounts.json",
    "files": {
      "accounts.json": {"content": json.encode(listAccount)},
    },
  };
  Response resposta = await post(
    uri,
    headers: headder,
    body: json.encode(body),
  );
}
