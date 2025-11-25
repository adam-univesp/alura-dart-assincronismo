import 'dart:io';

import 'package:alura_dart_assincronismo/models/account.dart';
import 'package:alura_dart_assincronismo/services/account_service.dart';
import 'package:uuid/uuid.dart';

class AccountScreen {
  final AccountService _accountService = AccountService();

  void initializeStream() {
    _accountService.streamInfos.listen((infoString) {
      print(infoString);
    });
  }

  runChatBot() async {
    print("Bom dia! Eu sou o Lewis, assistente do Banco d'Ouro!");
    print("Que bom te ter aqui com a gente.\n");

    bool isRunning = true;
    while (isRunning) {
      print("Como eu posso te ajudar? (digite o número desejado)");
      print("1 - 👀 Ver todas sua contas.");
      print("2 - ➕ Adicionar nova conta.");
      print("3 - Sair\n");

      String? input = stdin.readLineSync();

      if (input != null) {
        switch (input) {
          case "1":
            {
              await _getAllAccounts();
              break;
            }
          case "2":
            {
              await _addExampleAccount();
              break;
            }
          case "3":
            {
              await _addAccount();
              break;
            }
          case "4":
            {
              isRunning = false;
              print("Te vejo na próxima. 👋");
              break;
            }
          default:
            {
              print("Não entendi. Tente novamente.");
            }
        }
      }
    }
  }

  _getAllAccounts() async {
    List<Account> listAccounts = await _accountService.getAll();
    print(listAccounts);
  }

  _addExampleAccount() async {
    Account example = Account(
      id: "ID555",
      name: "Haley",
      lastName: "Chirívia",
      balance: 8001,
    );

    await _accountService.addAccount(example);
  }

  Future<void> _addAccount() async {
    Uuid uuid = Uuid();
    String id = uuid.v1();
    print("Nome:");
    String? nome = stdin.readLineSync();
    print("Sobrenome:");
    String? sobrenome = stdin.readLineSync();
    print("Saldo:");
    String? saldo = stdin.readLineSync();

    if (nome != null && sobrenome != null && saldo != null) {
      await _accountService.addAccount(
        Account(
          id: id,
          name: nome,
          lastName: sobrenome,
          balance: double.parse(saldo),
        ),
      );
    }
  }
}
