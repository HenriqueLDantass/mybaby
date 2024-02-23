import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mybabymylife/module/auth/stores/login_stores.dart';
import 'package:mybabymylife/module/home/stores/home_store.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AddFilhoPage extends StatefulWidget {
  AddFilhoPage({Key? key}) : super(key: key);

  @override
  _AddFilhoPageState createState() => _AddFilhoPageState();
}

class _AddFilhoPageState extends State<AddFilhoPage> {
  final List<String> generos = ["Masculino", "Feminino"];
  String nomeFilho = '';
  int idadeAnos = 0;
  int idadeMeses = 0;
  String? selectedGenero;
  String? imagePath;
  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      // Salvar a imagem localmente
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = basename(pickedFile.path);
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');

      // Upload da imagem para o Firebase Storage
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('images/$fileName');
      final UploadTask uploadTask = storageReference.putFile(savedImage);
      await uploadTask.whenComplete(() => null);

      // Obter a URL da imagem após o upload
      final imageUrl = await storageReference.getDownloadURL();

      setState(() {
        imagePath = imageUrl;
        // Faça algo com a URL da imagem, como armazená-la ou exibi-la
        // Exemplo: imageUrl.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeStore = Provider.of<HomeStore>(context);
    final loginStore = Provider.of<LoginStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Filho'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                        onPressed: () {
                          _selectImage();
                        },
                        icon: Icon(Icons.camera)))
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nome do Filho'),
              onChanged: (value) {
                setState(() {
                  nomeFilho = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Genero:"),
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
              ],
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Idade (anos)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  idadeAnos = int.tryParse(value) ?? 0;
                });
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Idade (meses)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  idadeMeses = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final success = await homeStore.cadastrarFilho(
                  usuarioId: loginStore.loggedInUser!.userId,
                  nome: nomeFilho,
                  idadeAnos: idadeAnos,
                  idadeMeses: idadeMeses,
                  genero: selectedGenero!,
                  imagePath: imagePath!,
                );

                if (success) {
                  Navigator.pop(context); // Fecha a tela de cadastro de filho
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Filho cadastrado com sucesso')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao cadastrar filho')),
                  );
                }
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
