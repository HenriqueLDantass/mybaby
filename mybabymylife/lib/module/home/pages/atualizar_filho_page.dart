import 'package:flutter/material.dart';
import 'package:mybabymylife/module/auth/stores/login_stores.dart';
import 'package:mybabymylife/module/home/models/home_models.dart';
import 'package:mybabymylife/module/home/stores/home_store.dart';
import 'package:provider/provider.dart';

class AtualizarFilho extends StatefulWidget {
  final Filho filho;
  AtualizarFilho({Key? key, required this.filho}) : super(key: key);

  @override
  _AtualizarFilhoState createState() => _AtualizarFilhoState();
}

class _AtualizarFilhoState extends State<AtualizarFilho> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeAnosController = TextEditingController();
  TextEditingController idadeMesesController = TextEditingController();
  String? selectedGenero;
  final List<String> generos = ["Masculino", "Feminino"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedGenero = widget.filho.genero;
    nomeController.text = widget.filho.nome;
    idadeAnosController.text = widget.filho.idadeAnos.toString();
    idadeMesesController.text = widget.filho.idadeMeses.toString();
  }

  @override
  Widget build(BuildContext context) {
    final homeStore = Provider.of<HomeStore>(context);
    final loginStore = Provider.of<LoginStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Atualizar filho Filho'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome do Filho'),
            ),
            DropdownButton<String>(
              value: selectedGenero,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                setState(() {
                  selectedGenero = value!;
                });
              },
              items: generos.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              controller: idadeAnosController,
              decoration: InputDecoration(labelText: 'Idade (anos)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: idadeMesesController,
              decoration: InputDecoration(labelText: 'Idade (meses)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await homeStore.updateFilho(
                  nome: nomeController.text,
                  genero: selectedGenero!,
                  idadeAnos: int.tryParse(idadeAnosController.text) ?? 0,
                  idadeMeses: int.tryParse(idadeMesesController.text) ?? 0,
                  idFilho: widget.filho.idfilho,
                  usuarioId: loginStore.loggedInUser!.userId,
                );

                Navigator.pop(context); // Fecha a tela de cadastro de filho
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Dados do filho atualizado')),
                );
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
