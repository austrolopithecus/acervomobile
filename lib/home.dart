import 'package:flutter/material.dart';
import 'drawer.dart';
import 'profile.dart';
import 'comic.detail.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo Usuário'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/user_avatar.png'), // Substitua pelo caminho do seu avatar
          ),
        ],
      ),
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recém adicionados
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recém adicionados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
                  _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
                  _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
                  _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
                  _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
                ],
              ),
            ),
            // Todos os quadrinhos
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Todos os quadrinhos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildComicsGrid(context),
            // Opiniões dos leitores
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Opiniões dos leitores:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildOpinionsList(),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildComicCard(BuildContext context, String? imagePath, String title, String publisher, String owner, String synopsis, String readingType) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicDetailScreen(
              imagePath: imagePath,
              title: title,
              publisher: publisher,
              owner: owner,
              synopsis: synopsis,
              readingType: readingType,
            ),
          ),
        );
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildComicsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
          _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
          _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
          _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
          _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
          _buildComicCard(context, null, 'Título Exemplo', 'Editora Exemplo', 'Proprietário Exemplo', 'Sinopse Exemplo', 'Fácil'),
          // Adicione mais quadrinhos conforme necessário
        ],
      ),
    );
  }

  Widget _buildOpinionsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildOpinionCard('assets/user1.jpg', 'José Nascimento', 'Mangá muito bom, personagens engraçados e carismáticos. Obra de gênio.', 5),
          _buildOpinionCard('assets/user2.jpg', 'Maria Silva', 'Ação do começo ao fim, sem sangue, sem lacração, 4 estrelas.', 4),
          // Adicione mais opiniões conforme necessário
        ],
      ),
    );
  }

  Widget _buildOpinionCard(String avatarPath, String name, String opinion, int rating) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(avatarPath),
        ),
        title: Text(name),
        subtitle: Text(opinion),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
            );
          }),
        ),
      ),
    );
  }
}
