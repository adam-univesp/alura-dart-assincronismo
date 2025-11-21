import 'package:http/http.dart';

void main() {
requestData();
}

Future<void> requestData() async {
  String url =
      "https://gist.githubusercontent.com/adam-univesp/826ff7f981fe321bf5b03763c1516508/raw/bf34368e8a293ce9e52b17c9ec45056d4529a99a/accounts.json";
  Uri uri = Uri.parse(url);
  Future<Response> futureResponse = get(uri);
  futureResponse.then((response) {
    print(response.body);
  });
}
