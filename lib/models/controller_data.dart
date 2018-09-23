// To parse this JSON data, do
//
//     final controllerData = controllerDataFromJson(jsonString);

import 'dart:convert';

ControllerData controllerDataFromJson(String str) {
  final jsonData = json.decode(str);
  return ControllerData.fromJson(jsonData);
}

String controllerDataToJson(ControllerData data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ControllerData {
  String erro;
  String passo;
  String progresso;
  String direcao;
  String direitaEsquerda;

  ControllerData({
    this.erro,
    this.passo,
    this.progresso,
    this.direcao,
    this.direitaEsquerda,
  });

  factory ControllerData.fromJson(Map<String, dynamic> json) => new ControllerData(
        erro: json["erro"],
        passo: json["passo"],
        progresso: json["progresso"],
        direcao: json["direcao"],
        direitaEsquerda: json["direitaEsquerda"],
      );

  Map<String, dynamic> toJson() => {
        "erro": erro,
        "passo": passo,
        "progresso": progresso,
        "direcao": direcao,
        "direitaEsquerda": direitaEsquerda,
      };
}
