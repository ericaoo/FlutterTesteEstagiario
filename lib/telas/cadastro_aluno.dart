import 'package:flutter/material.dart';
import 'tela_lista.dart';

class TelaCadastroAluno extends StatefulWidget {
  @override
  _TelaCadastroAlunoState createState() => _TelaCadastroAlunoState();
}

class _TelaCadastroAlunoState extends State<TelaCadastroAluno> {
  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerSegunda = TextEditingController();
  final TextEditingController _controllerTerca = TextEditingController();
  final TextEditingController _controllerQuarta = TextEditingController();
  final TextEditingController _controllerQuinta = TextEditingController();
  final TextEditingController _controllerSexta = TextEditingController();

  String? _errorNome;
  String? _errorSegunda;
  String? _errorTerca;
  String? _errorQuarta;
  String? _errorQuinta;
  String? _errorSexta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastre o Aluno',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(123, 134, 156, 1),
      ),
      backgroundColor: Color.fromRGBO(0, 27, 48, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              TextField(
                controller: _controllerNome,
                style: TextStyle(color: Colors.white), 
                decoration: InputDecoration(
                  labelText: 'Nome do Aluno',
                  labelStyle: TextStyle(color: Colors.white), 
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), 
                  ),
                  errorText: _errorNome,
                ),
              ),
              SizedBox(height: 20),
              
              for (var i = 0; i < 5; i++)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: i == 0
                          ? _controllerSegunda
                          : i == 1
                              ? _controllerTerca
                              : i == 2
                                  ? _controllerQuarta
                                  : i == 3
                                      ? _controllerQuinta
                                      : _controllerSexta,
                      style: TextStyle(color: Colors.white), 
                      decoration: InputDecoration(
                        labelText: 'Treino de ${_getDayOfWeek(i)}',
                        labelStyle: TextStyle(color: Colors.white), 
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), 
                        ),
                        errorText: _getErrorText(i),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: _cadastrarAluno,
                child: Text(
                  'CADASTRAR',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromRGBO(123, 134, 156, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDayOfWeek(int index) {
    switch (index) {
      case 0:
        return 'Segunda';
      case 1:
        return 'Terça';
      case 2:
        return 'Quarta';
      case 3:
        return 'Quinta';
      case 4:
        return 'Sexta';
      default:
        return '';
    }
  }

  String? _getErrorText(int index) {
    switch (index) {
      case 0:
        return _errorSegunda;
      case 1:
        return _errorTerca;
      case 2:
        return _errorQuarta;
      case 3:
        return _errorQuinta;
      case 4:
        return _errorSexta;
      default:
        return null;
    }
  }

  void _cadastrarAluno() {
    setState(() {
      _errorNome = _controllerNome.text.isEmpty ? 'Campo obrigatório' : null;
      _errorSegunda = _controllerSegunda.text.isEmpty ? 'Campo obrigatório' : null;
      _errorTerca = _controllerTerca.text.isEmpty ? 'Campo obrigatório' : null;
      _errorQuarta = _controllerQuarta.text.isEmpty ? 'Campo obrigatório' : null;
      _errorQuinta = _controllerQuinta.text.isEmpty ? 'Campo obrigatório' : null;
      _errorSexta = _controllerSexta.text.isEmpty ? 'Campo obrigatório' : null;
    });

    if (_errorNome == null &&
        _errorSegunda == null &&
        _errorTerca == null &&
        _errorQuarta == null &&
        _errorQuinta == null &&
        _errorSexta == null) {
      Map<String, String> treino = {
        'Segunda-feira': _controllerSegunda.text,
        'Terça-feira': _controllerTerca.text,
        'Quarta-feira': _controllerQuarta.text,
        'Quinta-feira': _controllerQuinta.text,
        'Sexta-feira': _controllerSexta.text,
      };

      Aluno novoAluno = Aluno(nome: _controllerNome.text, treino: treino);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Cadastro feito com sucesso!', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));

      print('Novo Aluno:');
      print('Nome: ${novoAluno.nome}');
      print('Treino:');
      novoAluno.treino.forEach((dia, treino) {
        print('$dia: $treino');
      });

      Navigator.pop(context, novoAluno);
    }
  }
}
