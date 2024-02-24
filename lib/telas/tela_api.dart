import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TelaApi extends StatefulWidget {
  @override
  _TelaApiState createState() => _TelaApiState();
}

class _TelaApiState extends State<TelaApi> {
  Map<String, dynamic> _endereco = {};

  @override
  void initState() {
    super.initState();
    _carregarEndereco();
  }

  Future<void> _carregarEndereco() async {
    try {
      final response = await http.get(Uri.parse('https://viacep.com.br/ws/01001000/json/'));
      if (response.statusCode == 200) {
        setState(() {
          _endereco = json.decode(response.body);
        });
      } else {
        throw Exception('Falha ao carregar o endereço');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  void _mostrarDetalhes(String chave, dynamic valor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Detalhes',
            style: TextStyle(
              color: Color.fromRGBO(123, 134, 156, 1),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chave: $chave',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Valor: $valor',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Fechar',
                style: TextStyle(
                  color: Color.fromRGBO(123, 134, 156, 1),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(123, 134, 158, 1),
        title: Text(
          'Endereço do Aluno',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 27, 48, 1),
      body: _endereco.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: EdgeInsets.all(20),
              children: _endereco.entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    _mostrarDetalhes(entry.key, entry.value);
                  },
                  child: ListTile(
                    title: Text(
                      entry.key,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      entry.value.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
