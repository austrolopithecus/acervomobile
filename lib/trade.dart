import 'package:acervo_mobile/home.dart';
import 'package:acervo_mobile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TradeScreen extends StatefulWidget {
  final String userName; // Adicionando o nome do usuário como parâmetro

  TradeScreen({required this.userName});

  @override
  _TradeScreenState createState() => _TradeScreenState();
}

class _TradeScreenState extends State<TradeScreen> {
  final TextEditingController _isbnController = TextEditingController();
  bool _isLoading = false;
  String? _message;

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      _message = null;
    });

    final response = await http.post(
      Uri.parse('https://api.example.com/comics/trade'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'isbn': _isbnController.text,
      }),
    );

    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        _message = 'Quadrinho doado com sucesso!';
      } else {
        _message = 'Erro ao doar quadrinho: ${response.body}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doar Quadrinho'),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/background.png', // Background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(horizontal: 32.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Insira o ISBN do quadrinho:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _isbnController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'ISBN',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    if (_isLoading)
                      Center(child: CircularProgressIndicator())
                    else
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text('Doar'),
                      ),
                    if (_message != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          _message!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _message!.contains('sucesso') ? Colors.green : Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
              MaterialPageRoute(builder: (context) => TradeScreen(userName: widget.userName)), // Navegar para TradeScreen
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
}
