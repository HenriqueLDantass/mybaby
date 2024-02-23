import 'package:dio/dio.dart';
import 'package:mybabymylife/module/home/models/home_models.dart';

class HomeServices {
  final dio = Dio();
  Future<bool> cadastrarFilho(
      {required int usuarioId,
      required String nome,
      required String imagePath,
      required int idadeAnos,
      required int idadeMeses,
      required String gerero}) async {
    try {
      String baseUrl = "http://10.0.2.2:3000/usuarios/$usuarioId/filhos";
      print("URL da requisição: $baseUrl");
      final response = await dio.post(baseUrl, data: {
        "nome": nome,
        "idade_anos": idadeAnos,
        "idade_meses": idadeMeses,
        "genero": gerero,
        "imagePath": imagePath
      });
      print("O user id : $nome");

      if (response.statusCode == 201) {
        print("Filho cadastrado com sucesso");
        return true;
      } else {
        print("Erro ao cadastrar filho: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro ao cadastrar filho: $e");
      return false;
    }
  }

  Future<List<Filho>> getFilhos(usuarioId) async {
    try {
      String baseUrl = "http://10.0.2.2:3000/usuarios/$usuarioId/filhos";
      final response = await dio.get(baseUrl);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Filho> filhosList = data.map((e) => Filho.fromJson(e)).toList();
        return filhosList;
      } else {
        return [];
      }
    } catch (e) {
      print("erro ao pegar filhos: $e");
      return [];
    }
  }

  Future<void> deleteFilho(idfilho) async {
    final baseUrl = "http://10.0.2.2:3000/usuarios/$idfilho/filhos";
    final response = await dio.delete(baseUrl);
    if (response.statusCode == 204) {
      print("Filho de id $idfilho deletado com sucesso");
    } else {
      print("erro ao deletar filho");
    }
  }

  Future<bool> updateFilho({
    required int idFilho,
    required int usuarioId,
    required String nome,
    required String genero,
    required int idadeAnos,
    required int idadeMeses,
  }) async {
    try {
      String baseUrl =
          "http://10.0.2.2:3000/usuarios/$usuarioId/filhos/$idFilho";
      final response = await dio.put(baseUrl, data: {
        "nome": nome,
        "idade_anos": idadeAnos,
        "idade_meses": idadeMeses,
        "genero": genero
      });

      if (response.statusCode == 200) {
        print("Filho de id $idFilho atualizado com sucesso");

        return true;
      } else {
        print("Erro ao atualizar filho: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro ao atualizar filho: $e");
      return false;
    }
  }
}
