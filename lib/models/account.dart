/*
"id": "NEW001",
"name": "Flutter",
"lastName": "Dart",
"balance": 5000,

*/
import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      lastName: map['lastName'],
      balance: map['balance'],
    );
  }

  factory Account.fromJson(String dado) => Account.fromMap(json.decode(dado));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "lastName": lastName,
      "balance": balance,
    };
  }

  String toJson() => json.encode(toMap());

  Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
    );
  }

  @override
  String toString() {
    return '\nConta $id\n$name $lastName\nSaldo: $balance\n';
  }
}
