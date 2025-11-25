import 'dart:async';
import 'dart:convert';
import 'package:alura_dart_assincronismo/key.dart';
import 'package:http/http.dart';

import '../models/account.dart';

class AccountService {
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfos => _streamController.stream;

  final String _gist_id = "826ff7f981fe321bf5b03763c1516508";
  late final String _url = "https://api.github.com/gists/${_gist_id}";
  late final Uri _uri = Uri.parse(_url);

  final Map<String, String> _headder = {"Authorization": "Bearer $gist_key"};
  final JsonEncoder _encoder = JsonEncoder.withIndent('  ');

  Future<List<Account>> getAll() async {
    _streamController.add("${DateTime.now()} | Requisição de leitura.");
    Response resposta = await get(_uri);
    Map<String, dynamic> respostaMap = json.decode(resposta.body);

    List<dynamic> listAccountDyn = json.decode(
      respostaMap["files"]["accounts.json"]["content"],
    );

    List<Account> listAccount = [];
    for (dynamic accountDyn in listAccountDyn) {
      Map<String, dynamic> mapAccount = accountDyn as Map<String, dynamic>;
      listAccount.add(Account.fromMap(mapAccount));
    }

    return listAccount;
  }

  addAccount(Account account) async {
    List<Account> listAccount = await getAll();
    listAccount.add(account);

    List<Map<String, dynamic>> listMapAccount = [];
    for (Account acc in listAccount) {
      listMapAccount.add(acc.toMap());
    }

    Map<String, dynamic> body = {
      "description": "accounts.json",
      "files": {
        "accounts.json": {"content": _encoder.convert(listMapAccount)},
      },
    };

    Response resposta = await post(
      _uri,
      headers: _headder,
      body: json.encode(body),
    );

    if (resposta.statusCode == 200) {
      _streamController.add("${DateTime.now()} | Adicionado ${account}.");
    } else {
      _streamController.add("${DateTime.now()} | Removido usuario ${account}.");
    }
  }
  
}
