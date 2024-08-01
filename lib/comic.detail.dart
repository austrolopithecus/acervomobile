import 'package:flutter/material.dart';

class ComicDetailScreen extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String publisher;
  final String owner;
  final String synopsis;
  final String readingType;

  ComicDetailScreen({
    required this.imagePath,
    required this.title,
    required this.publisher,
    required this.owner,
    required this.synopsis,
    required this.readingType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Quadrinho'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey,
                  child: imagePath != null
                      ? Image.asset(imagePath!, fit: BoxFit.cover)
                      : Center(child: Text('Sem imagem')),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.lightBlueAccent.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Título: $title',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text('Editora: $publisher'),
                        Text('Proprietário: $owner'),
                        Text('Sinopse: $synopsis'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Tipo de leitura:'),
                SizedBox(width: 8.0),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.green, // Cor para o tipo de leitura
                ),
                SizedBox(width: 8.0),
                Text(readingType),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Adicione a lógica para pegar o quadrinho
              },
              child: Text('Pegar'),
            ),
          ],
        ),
      ),
    );
  }
}
