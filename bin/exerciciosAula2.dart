import 'dart:convert';
import 'package:http/http.dart';

void main() async {
  print("\n Exercicio 1! \n");
  List<dynamic> biblioteca = await solicitaJSON(
    "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/books.json",
  );

  List<dynamic> livros = livrosAutor(biblioteca, "Machado de Assis");
  for (Map<String, dynamic> livro in livros) {
    print("Titulo: ${livro['title']}");
  }

  print("\n Exercicio 2! \n");

  List<String> ingredientes = ["ovo"];
  List<dynamic> data = await solicitaJSON(
    "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/recipes.json",
  );

  List<Map<String, dynamic>> receitas = List<Map<String, dynamic>>.from(data);

  List<Map<String, dynamic>> receitasFiltradas = filtraReceitas(
    receitas,
    ingredientes,
  );

  print("\n Exercicio 3! \n");
  Map<String, dynamic> dataMap = await solicitaJSONMap(
    "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/aula05/.json/players.json",
  );
  escalaTime(dataMap);

  print("\n Exercicio 4! \n");
  data = await solicitaJSON(
    "https://raw.githubusercontent.com/alura-cursos/dart_assincronismo_api/refs/heads/aula05/.json/vet.json",
  );
  String nome = "Dra. Patrícia Gomes";
  organizadorAgendamento(data, nome);
}

void organizadorAgendamento(List consultas, String nome) {
  List consultasFiltradas = consultas
      .where((consulta) => consulta["veterinarian"] == nome)
      .toList();
  consultasFiltradas.sort(
    (a, b) => DateTime.parse(
      a["appointment"],
    ).compareTo(DateTime.parse(b["appointment"])),
  );
  for (Map<String, dynamic> consulta in consultasFiltradas) {
    print(
      'Nome: ${consulta["pet_name"]}\t--> Horario ${consulta["appointment"]}',
    );
  }
}

void escalaTime(Map<String, dynamic> dataMap) {
  int jogadoresPorTime = dataMap["rules"]["playersPerTeam"];
  List<Map<String, dynamic>> jogadores = List<Map<String, dynamic>>.from(
    dataMap["players"],
  );

  jogadores.sort(
    (a, b) =>
        (b["roundsWaiting"] as int).compareTo((a["roundsWaiting"] as int)),
  );

  for (int i = 0; i * jogadoresPorTime < jogadores.length; i++) {
    int end = (i + 1) * jogadoresPorTime;
    end = end <= jogadores.length ? end : jogadores.length - 1;
    List<Map<String, dynamic>> time = jogadores.sublist(
      i * jogadoresPorTime,
      end,
    );
    imprimeTime(i, time);
  }
}

void imprimeTime(int i, List<Map<String, dynamic>> time) {
  print("\n *** Time ${i + 1} ***");
  for (Map<String, dynamic> jogador in time) {
    print("Jogador: ${jogador['name']}");
  }
}

List<Map<String, dynamic>> filtraReceitas(
  List<Map<String, dynamic>> receitas,
  List<String> ingredientes,
) {
  List<Map<String, dynamic>> receitasFiltradas = receitas
      .where(
        (receita) => ingredientes.every(
          (ingrediente) => receita["ingredients"].any(
            (igredienteReceita) => (igredienteReceita as String)
                .toLowerCase()
                .contains(ingrediente.toLowerCase()),
          ),
        ),
      )
      .toList();
  for (Map<String, dynamic> receita in receitasFiltradas) {
    print("Receita: ${receita['name']}");
  }
  return receitasFiltradas;
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

Future<Map<String, dynamic>> solicitaJSONMap(String url) async {
  Uri uri = Uri.parse(url);
  Response resultado = await get(uri);
  return json.decode(resultado.body);
}
