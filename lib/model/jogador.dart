class Jogador {
  String? id;
  int? numero;
  String? posicao;
  String? nome;

  Jogador({this.id, this.numero, this.posicao, this.nome});

  Jogador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numero = json['numero'];
    posicao = json['posicao'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['numero'] = this.numero;
    data['posicao'] = this.posicao;
    data['nome'] = this.nome;
    return data;
  }

  @override
  bool equals(Jogador e1, Jogador e2) => e1.id == e2.id;
}
