class Filho {
  final int idfilho;
  final String nome;
  final int idadeAnos;
  final int idadeMeses;
  final String genero;
  final String imagePath;

  Filho(
      {required this.nome,
      required this.idadeAnos,
      required this.idadeMeses,
      required this.idfilho,
      required this.genero,
      required this.imagePath});

  factory Filho.fromJson(Map<String, dynamic> json) {
    return Filho(
      idfilho: json['id'],
      nome: json['nome'],
      idadeAnos: json['idade_anos'],
      idadeMeses: json['idade_meses'],
      genero: json['genero'] ?? "",
      imagePath: json['imagePath'] ?? "",
    );
  }
}
