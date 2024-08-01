import 'package:flutter/material.dart';
import 'home.dart';

class ProfileScreen extends StatelessWidget {
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
                    'Arthur Costa',
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
                      children: [
                        _buildComicCard(null),
                        _buildComicCard(null),
                        _buildComicCard(null),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Lendo no momento
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
                  _buildComicCard(null),
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
          }
        },
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
