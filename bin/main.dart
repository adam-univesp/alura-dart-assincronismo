import 'package:http/http.dart';
import 'package:alura_dart_assincronismo/exercicios.dart';
import 'dart:convert';

void main() async {
  print("1");
  requestData();
  print("2");
  await readDataAsync();
  print("3");
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

  readDataAsync() async {
  String url =
      "https://gist.githubusercontent.com/adam-univesp/826ff7f981fe321bf5b03763c1516508/raw/bf34368e8a293ce9e52b17c9ec45056d4529a99a/accounts.json";
  Uri uri = Uri.parse(url);
  Response resposta = await get(uri);
  List<dynamic> listAccount = json.decode(resposta.body);
  Map<String, dynamic> mapAna = listAccount.firstWhere(
    (valor) => valor["name"] == "Ana",
  );
  print(mapAna);
  print("2.2");
}
