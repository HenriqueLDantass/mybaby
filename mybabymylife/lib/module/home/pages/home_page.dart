import 'package:flutter/material.dart';
import 'package:mybabymylife/module/auth/stores/login_stores.dart';
import 'package:mybabymylife/module/home/pages/add_filho_page.dart';
import 'package:mybabymylife/module/home/pages/atualizar_filho_page.dart';
import 'package:mybabymylife/module/home/pages/teste.dart';
import 'package:mybabymylife/module/home/stores/home_store.dart';
import 'package:provider/provider.dart';

import '../models/home_models.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Obtenha a instância de HomeStore
    final homeStore = Provider.of<HomeStore>(context, listen: false);
    final loginStore = Provider.of<LoginStore>(context, listen: false);

    // Obtenha os filhos do usuário
    homeStore.getfilhos(loginStore.loggedInUser!.userId);
  }

  @override
  Widget build(BuildContext context) {
    final homeStore = Provider.of<HomeStore>(context);
    final loginStore =
        Provider.of<LoginStore>(context, listen: false); // Adicione esta linha

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seus filhos'),
      ),
      body: Consumer<HomeStore>(
        builder: (context, homeStore, _) {
          return PageView.builder(
            itemCount: homeStore.listaDeFilhos.length +
                1, // +1 para a página de adicionar filho
            itemBuilder: (context, index) {
              if (index < homeStore.listaDeFilhos.length) {
                return _buildFilhoPage(homeStore.listaDeFilhos[index]);
              } else {
                return _buildAdicionarFilhoPage(context);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildFilhoPage(Filho filho) {
    final homeStore = Provider.of<HomeStore>(context, listen: false);
    final loginStore = Provider.of<LoginStore>(context, listen: false);
    print("id filho ${filho.idfilho}");

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width, // Largura da tela
          height: 50, // Altura da tela
          decoration: BoxDecoration(
            color: filho.genero == "Masculino" ? Colors.blue : Colors.pink,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    PopupMenuButton<String>(
                      icon: Icon(Icons.settings),
                      onSelected: (String value) {
                        if (value == 'Editar') {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => AtualizarFilho(
                              filho: filho,
                            ),
                          ));
                        } else if (value == 'Excluir') {
                          homeStore.deleteFilho(
                              filho.idfilho, loginStore.loggedInUser!.userId);
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'Editar',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: 8),
                              Text('Editar'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'Excluir',
                          child: Row(
                            children: [
                              Icon(Icons.delete),
                              SizedBox(width: 8),
                              Text('Excluir'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Image.network(
          filho.imagePath,
          width: 150,
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: filho.genero == "Masculino" ? Colors.blue : Colors.pink,
          ),
          child: Text(
            filho.nome,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Text("Responsavel: Henrique Dantas"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("idade:${filho.idadeAnos}"),
            Text("meses:${filho.idadeMeses}"),
          ],
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  filho.genero == "Masculino" ? Colors.blue : Colors.pink,
              onPrimary: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
            child: Text("Acessar dados da crianca"))
      ],
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SecondScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildAdicionarFilhoPage(BuildContext context) {
    final loginStore = Provider.of<LoginStore>(context, listen: false);

    return Center(
      child: IconButton(
        icon: Icon(Icons.add),
        onPressed: () async {
          // Navegue para a página AddFilhoPage e aguarde o resultado
          final success = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddFilhoPage()),
          );

          // Se o cadastro do filho foi bem-sucedido, atualize a lista de filhos
          if (success != null && success) {
            // Atualize a lista de filhos
            Provider.of<HomeStore>(context, listen: false)
                .getfilhos(loginStore.loggedInUser!.userId);
          }
        },
      ),
    );
  }
}
