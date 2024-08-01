import 'package:flutter/material.dart';
import 'all.comic.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'O que deseja?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Todos os quadrinhos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllComicsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.house),
            title: Text('Por editoras'),
            onTap: () {
              // Adicione a navegação desejada aqui
            },
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Mais lidos'),
            onTap: () {
              // Adicione a navegação desejada aqui
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text('Fale conosco'),
            onTap: () {
              // Adicione a navegação desejada aqui
            },
          ),
        ],
      ),
    );
  }
}
