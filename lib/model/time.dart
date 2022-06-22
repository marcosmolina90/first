import 'package:first/model/jogador.dart';

class Time {
  String? id;
  String? nome;
  DateTime? data;
  Jogador? jogador = Jogador();

  Time({this.id, this.nome, this.jogador});

  Time.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    jogador =
        json['jogador'] != null ? new Jogador.fromJson(json['jogador']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.jogador != null) {
      data['jogador'] = this.jogador!.toJson();
    }
    return data;
  }
}
