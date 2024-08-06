import 'package:acervo_mobile/all.comic.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'trade.dart';
import 'all.comic.dart'; // Certifique-se de importar corretamente

class DrawerMenu extends StatelessWidget {
  final List<Map<String, dynamic>> comics; // Adicionando a lista de quadrinhos
  final String userName; // Adicionando o nome do usuário

  DrawerMenu({required this.comics, required this.userName}); // Adicionando a lista de quadrinhos e o nome do usuário ao construtor

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Doar'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TradeScreen(userName: userName)),
              );
            },
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(userName: userName)),
              );
            },
          ),
          ListTile(
            title: Text('Todos os quadrinhos'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AllComicsScreen(comics: comics), // Passando a lista de quadrinhos
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
