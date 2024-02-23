import 'package:flutter/material.dart';
import 'package:mybabymylife/module/home/models/home_models.dart';
import '../services/home_services.dart';

class HomeStore extends ChangeNotifier {
  final HomeServices homeServices = HomeServices();
  String? selectedGenerer;

  List<Filho> _listaDeFilhos = [];

  List<Filho> get listaDeFilhos => _listaDeFilhos;

  Future<void> getfilhos(int userId) async {
    _listaDeFilhos = await homeServices.getFilhos(userId);
    notifyListeners();
  }

  Future<bool> cadastrarFilho(
      {required int usuarioId,
      required String nome,
      required String genero,
      required int idadeAnos,
      required int idadeMeses,
      required String imagePath}) async {
    try {
      // Chama o serviço para cadastrar o filho na API
      final success = await homeServices.cadastrarFilho(
          usuarioId: usuarioId,
          nome: nome,
          idadeAnos: idadeAnos,
          idadeMeses: idadeMeses,
          gerero: genero,
          imagePath: imagePath);

      if (success) {
        await getfilhos(usuarioId);
      }

      return success;
    } catch (e) {
      print('Erro ao cadastrar filho: $e');
      return false;
    }
  }

  Future<void> deleteFilho(idfilho, usuarioId) async {
    await homeServices.deleteFilho(idfilho);
    await getfilhos(usuarioId);
    notifyListeners();
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
      final success = await homeServices.updateFilho(
          idFilho: idFilho,
          usuarioId: usuarioId,
          nome: nome,
          idadeAnos: idadeAnos,
          idadeMeses: idadeMeses,
          genero: genero);

      await getfilhos(usuarioId);

      return success;
    } catch (e) {
      print('Erro ao atualizar filho: $e');
      return false;
    }
  }

  void valueGenero(String? value) {
    selectedGenerer = value;
    notifyListeners();
  }
}
