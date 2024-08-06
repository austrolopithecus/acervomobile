import 'package:acervo_mobile/trade.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final String userName; // Nome do usuário passado como parâmetro

  ProfileScreen({required this.userName});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> _comicsToLend = [];
  List<Map<String, dynamic>> _comicsReading = [];

  @override
  void initState() {
    super.initState();
    _fetchComics();
  }

  Future<void> _fetchComics() async {
    // Carregar quadrinhos para empréstimo
    final responseLend = await http.get(Uri.parse('https://api.example.com/comics/lend'));
    // Carregar quadrinhos que está lendo
    final responseReading = await http.get(Uri.parse('https://api.example.com/comics/reading'));

    if (responseLend.statusCode == 200 && responseReading.statusCode == 200) {
      setState(() {
        _comicsToLend = List<Map<String, dynamic>>.from(json.decode(responseLend.body));
        _comicsReading = List<Map<String, dynamic>>.from(json.decode(responseReading.body));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar quadrinhos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar e Nome do Usuário
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/user_avatar.png'), // Substitua pelo caminho do avatar do usuário
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.userName, // Usando o nome do usuário passado como parâmetro
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Quadrinhos para empréstimo
            Container(
              color: Colors.greenAccent.withOpacity(0.3),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quadrinhos para empréstimo:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _comicsToLend.map((comic) => _buildComicCard(comic)).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Lendo no momento
            if (_comicsReading.isNotEmpty)
              Container(
                color: Colors.greenAccent.withOpacity(0.3),
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lendo no momento:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    _buildComicCard(_comicsReading[0]),
                  ],
                ),
              ),
            // Botão de Editar Perfil
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Adicione a ação para editar o perfil
                },
                child: Text('Editar Perfil'),
              ),
            ),
            // Botão para voltar para a Home
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('Voltar para Home'),
              ),
            ),
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
              MaterialPageRoute(builder: (context) => ProfileScreen(userName: widget.userName)),
            );
          }
        },
      ),
    );
  }

  Widget _buildComicCard(Map<String, dynamic>? comic) {
    if (comic == null) {
      return SizedBox.shrink();
    }
    return Container(
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
    );
  }
}
