import 'package:alura_dart_assincronismo/screens/screens.dart';

void main() async {
  AccountScreen accountScreen = AccountScreen();
  accountScreen.initializeStream();
  await accountScreen.runChatBot();
}
