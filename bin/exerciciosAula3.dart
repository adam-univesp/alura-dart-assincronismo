import 'dart:convert';
import 'package:http/http.dart';
import 'package:alura_dart_assincronismo/key.dart';

void main() {
  print(gist_key);
  print("\n *** Exercicio 1 ***\n");
  exercicio1();
  print("\n *** Exercicio 2 ***\n");
  //exercicio2();
  print("\n *** Exercicio 3 ***\n");
  exercicio3();
}

void exercicio3() async {
  var newProducts = [
    {"id": 5, "name": "Teclado", "price": 200.00},
    {"id": 6, "name": "Mouse", "price": 100.00},
  ];
  sendMultipleProducts(newProducts, "lista");
}

void sendMultipleProducts(
  List<Map<String, Object>> newProducts,
  String nomeLista,
) async {
  String gistId = "9ba4bf6755ae7cce74db6efdc618049c";
  String responseBody = await getGist(gistId);
  List<dynamic> listaProduct = json.decode(responseBody);
  listaProduct.addAll(newProducts);
  int resposta = await postGist(
    gistId,
    json.encode(listaProduct),
    nomeLista: nomeLista,
  );
  print(resposta);
}

void exercicio2() async {
  String gistId = "9ba4bf6755ae7cce74db6efdc618049c";
  Map<String, dynamic> newProduct = {
    "id": 4,
    "name": "Monitor",
    "price": 800.00,
  };
  sendProduct(gistId, newProduct);
}

Future<void> sendProduct(String gistId, Map<String, dynamic> newProduct) async {
  String responseBody = await getGist(gistId);
  List<dynamic> listaProduct = json.decode(responseBody);
  listaProduct.add(newProduct);
  int resposta = await postGist(gistId, json.encode(listaProduct));
  print(resposta);
}

Future<int> postGist(
  String gistId,
  String listaProduct, {
  String nomeLista = "lista.json",
}) async {
  String url = "https://api.github.com/gists/$gistId";
  Uri uri = Uri.parse(url);
  Map<String, String> header = {"Authorization": "Bearer $gist_key"};
  String body = json.encode({
  "description": nomeLista,
    "files": {
      nomeLista: {"content": listaProduct},
    },
  });
  Response resposta = await post(uri, headers: header, body: body);

  return resposta.statusCode;
}

Future<String> getGist(String gistID) async {
  String url = "https://api.github.com/gists/$gistID";
  Uri uri = Uri.parse(url);
  Response resposta = await get(uri);
  Map<String, dynamic> respostaJSON = json.decode(resposta.body);

  return respostaJSON["files"]["lista.json"]["content"];
}

void exercicio1() {
  String responseBody = '''
  [
    {"id": 1, "name": "Celular", "price": 1200.75},
    {"id": 2, "name": "Notebook", "price": 3500.10},
    {"id": 3, "name": "Tablet", "price": 1500.00}
  ]
  ''';
  responseBody = adiconaItemLista(responseBody, {
    "id": 4,
    "name": "lança",
    "price": 12.40,
  });
  print(responseBody);
}

String adiconaItemLista(String responseBody, Map<String, Object> map) {
  List<dynamic> listaItens = json.decode(responseBody);
  listaItens.add(map);
  return json.encode(listaItens);
}

Future<void> criaGist() async {
  String conteudo = '''
  [
    {"id": 1, "name": "Celular", "price": 1200.75},
    {"id": 2, "name": "Notebook", "price": 3500.10},
    {"id": 3, "name": "Tablet", "price": 1500.00}
  ]
  ''';
  String url = "https://api.github.com/gists";
  Uri uri = Uri.parse(url);
  Map<String, String> header = {"Authorization": "Bearer $gist_key"};
  String body = json.encode({
    "description": "lista.json",
    "files": {
      "lista.json": {"content": conteudo},
    },
  });
  Response resposta = await post(uri, headers: header, body: body);
  print(resposta.body);
}
