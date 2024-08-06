import 'package:acervo_mobile/home.dart';
import 'package:acervo_mobile/profile.dart';
import 'package:acervo_mobile/trade.dart';
import 'package:flutter/material.dart';

class AllComicsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> comics; // Lista de quadrinhos

  AllComicsScreen({required this.comics}); // Construtor para receber a lista de quadrinhos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos os quadrinhos'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Ação para o botão de busca
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Ação para o botão de filtro
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro por editoras
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Todos os quadrinhos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text('Por editoras:'),
                      Checkbox(
                        value: false, // Valor do checkbox
                        onChanged: (bool? value) {
                          // Adicione a lógica para o checkbox
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Exibir quadrinhos por categorias
            _buildComicCategory('DC Comics', comics.where((comic) => comic['publisher'] == 'DC Comics').toList()),
            _buildComicCategory('Marvel Comics', comics.where((comic) => comic['publisher'] == 'Marvel Comics').toList()),
            _buildComicCategory('Mangás', comics.where((comic) => comic['category'] == 'Mangá').toList()),
            _buildComicCategory('Outros', comics.where((comic) => comic['category'] == 'Outro').toList()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Doar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TradeScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen(userName: userName)),
            );
          }
        },
      ),
    );
  }

  Widget _buildComicCategory(String category, List<Map<String, dynamic>> comics) {
    if (comics.isEmpty) {
      return SizedBox.shrink(); // Não exibe nada se não houver quadrinhos
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$category:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: comics.map((comic) => _buildComicCard(comic)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComicCard(Map<String, dynamic> comic) {
    return Container(
      width: 140,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(comic['imagePath'], width: 140, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              comic['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              comic['publisher'],
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
