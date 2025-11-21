import 'package:http/http.dart';

String url =
    "https://gist.githubusercontent.com/adam-univesp/ee59a3f1e7ef62be5ab1d7da4e32724b/raw/4b0b4575d617e7c712db691243b2cb3a79e60549/recipes.json";

Future<void> receitas() async {
  Uri uri = Uri.parse(url);
  Future<Response> resposta = get(uri);
  resposta.then((response) {
    print(response.body);
  });
}
