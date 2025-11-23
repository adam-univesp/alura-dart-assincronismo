import 'dart:io';

import 'package:alura_dart_assincronismo/key.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() async {
sendDataAsync({"a": 1, "c": 7});
}

Future<void> requestData() async {
  String url =
      "https://gist.githubusercontent.com/adam-univesp/826ff7f981fe321bf5b03763c1516508/raw/bf34368e8a293ce9e52b17c9ec45056d4529a99a/accounts.json";
  Uri uri = Uri.parse(url);
  Future<Response> futureResponse = get(uri);
  futureResponse.then((response) {
    // print(response.body);
    List<dynamic> listAccount = json.decode(response.body);
    Map<String, dynamic> mapCarla = listAccount.firstWhere(
      (element) => element["name"] == "Carla",
    );
    print(mapCarla);
  });
  print("1.2");
}

Future<List<dynamic>> readDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/adam-univesp/826ff7f981fe321bf5b03763c1516508/raw/bf34368e8a293ce9e52b17c9ec45056d4529a99a/accounts.json";
  Uri uri = Uri.parse(url);
  Response resposta = await get(uri);
  List<dynamic> listAccount = json.decode(resposta.body);
  return listAccount;
}

sendDataAsync(Map<String, dynamic> account) async {
  List<dynamic> listAccount = await readDataAsync();
  print(listAccount.toString());
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
  print(json.encode(body));
  print(resposta.statusCode);
}
