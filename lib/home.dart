import 'package:flutter/material.dart';
import 'drawer.dart';
import 'profile.dart';
import 'trade.dart';  // Importação correta da tela de doação
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'comic.detail.dart';
import 'all.comic.dart'; // Certifique-se de importar corretamente

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _comics = [];
  String _userName = ''; // Adicionando variável para o nome do usuário

  @override
  void initState() {
    super.initState();
    _fetchComics();
    _fetchUserName();
  }

  Future<void> _fetchComics() async {
    final response = await http.get(Uri.parse('https://api.example.com/comics'));

    if (response.statusCode == 200) {
      setState(() {
        _comics = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar quadrinhos: ${response.body}')),
      );
    }
  }

  Future<void> _fetchUserName() async {
    final response = await http.get(Uri.parse('https://api.example.com/user'));

    if (response.statusCode == 200) {
      setState(() {
        _userName = json.decode(response.body)['name'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar nome do usuário: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo $_userName'),
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
      drawer: DrawerMenu(comics: _comics), // Passando a lista de quadrinhos para DrawerMenu
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                children: _comics.map((comic) => _buildComicCard(context, comic)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Todos os quadrinhos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildComicsGrid(context),
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
              MaterialPageRoute(builder: (context) => TradeScreen()), // Navegar para TradeScreen
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen(userName: _userName)),
            );
          }
        },
      ),
    );
  }

  Widget _buildComicCard(BuildContext context, Map<String, dynamic> comic) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComicDetailScreen(
              imagePath: comic['imagePath'],
              title: comic['title'],
              publisher: comic['publisher'],
              owner: comic['owner'],
              synopsis: comic['synopsis'],
              readingType: comic['readingType'],
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
        child: Column(
          children: [
            Image.network(comic['imagePath'], height: 150, fit: BoxFit.cover),
            SizedBox(height: 8.0),
            Text(
              comic['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
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
        children: _comics.map((comic) => _buildComicCard(context, comic)).toList(),
      ),
    );
  }
}
