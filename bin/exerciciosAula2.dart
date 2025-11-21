import 'dart:convert';
import 'package:http/http.dart';

void main() async {
  print("\n\n Exercicio 1! \n\n");
  List<dynamic> biblioteca = await solicitaJSON(
    "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/books.json",
  );

  List<dynamic> livros = livrosAutor(biblioteca, "Machado de Assis");
  for (Map<String, dynamic> livro in livros) {
    print("Titulo: ${livro['title']}");
  }
}

List<dynamic> livrosAutor(List<dynamic> biblioteca, String autor) {
  return biblioteca.where((livro) => livro['author'] == autor).toList();
}

Future<List<dynamic>> solicitaJSON(String url) async {
  Uri uri = Uri.parse(url);
  Response resultado = await get(uri);
  List<dynamic> listaResultado = json.decode(resultado.body);
  return listaResultado;
}
