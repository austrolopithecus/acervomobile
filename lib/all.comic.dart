import 'package:flutter/material.dart';

class AllComicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos os quadrinhos'),
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
            // DC Comics
            _buildComicCategory('DC Comics', [
              null,
              null,
              null,
            ]),
            // Marvel Comics
            _buildComicCategory('Marvel Comics', [
              null,
              null,
              null,
            ]),
            // Mangás
            _buildComicCategory('Mangás', [
              null,
              null,
              null,
            ]),
            // Outros
            _buildComicCategory('Outros', [
              null,
              null,
              null,
            ]),
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
      ),
    );
  }

  Widget _buildComicCategory(String category, List<String?> comics) {
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

  Widget _buildComicCard(String? imagePath) {
    return Container(
      width: 140,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: imagePath != null
          ? Column(
              children: [
                Image.asset(imagePath, height: 150, fit: BoxFit.cover),
                SizedBox(height: 8.0),
              ],
            )
          : Center(
              child: Text(
                'Espaço em branco',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          
    );
  }
}
