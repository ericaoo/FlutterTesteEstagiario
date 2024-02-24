import 'package:flutter/material.dart';
import 'tela_api.dart';
import 'package:flutter_application/telas/cadastro_aluno.dart';

class Aluno {
  final String nome;
  Map<String, String> treino;

  Aluno({required this.nome, required this.treino});
}

class TelaLista extends StatefulWidget {
  @override
  _TelaListaState createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  List<Aluno> alunos = [
    Aluno(
      nome: 'João',
      treino: {
        'Segunda-feira': 'Treino de inferiores',
        'Terça-feira': 'Treino de superiores',
        'Quarta-feira': 'Descanso',
        'Quinta-feira': 'Treino de inferiores',
        'Sexta-feira': 'Treino de superiores',
      },
    ),
    Aluno(
      nome: 'Maria',
      treino: {
        'Segunda-feira': 'Treino de superiores',
        'Terça-feira': 'Treino de inferiores',
        'Quarta-feira': 'Descanso',
        'Quinta-feira': 'Treino de superiores',
        'Sexta-feira': 'Treino de inferiores',
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(123, 134, 156, 1),
        title: Text(
          'Alunos',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaApi()),
              );
            },
            icon: Icon(Icons.api),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(0, 27, 48, 1),
      body: ListView.builder(
        itemCount: alunos.length,
        itemBuilder: (context, index) {
          final aluno = alunos[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center( // Centraliza o nome do aluno
                  child: Text(
                    aluno.nome,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _editarAluno(context, aluno);
                      },
                      icon: Icon(Icons.edit, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        _excluirAluno(index);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Exclusão feita com sucesso!', style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ));
                      },
                      icon: Icon(Icons.delete, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            '${aluno.nome} - Treino',
                            style: TextStyle(
                              color: Color.fromRGBO(123, 134, 156, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: aluno.treino.entries.map((entry) {
                              return Text(
                                '${entry.key}: ${entry.value}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              );
                            }).toList(),
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
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 40),
                    backgroundColor: Color.fromRGBO(123, 134, 156, 1),
                  ),
                  child: Text(
                    'Visualizar Treino',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novoAluno = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaCadastroAluno()),
          );
          if (novoAluno != null) {
            setState(() {
              alunos.add(novoAluno);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Salvo com sucesso!', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ));
            });
          }
        },
        backgroundColor: Color.fromRGBO(123, 134, 156, 1),
        child: Icon(Icons.add),
      ),
    );
  }

  void _editarAluno(BuildContext context, Aluno aluno) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaEdicaoAluno(aluno: aluno)),
    );
  }

  void _excluirAluno(int index) {
    setState(() {
      alunos.removeAt(index);
    });
  }
}

class TelaEdicaoAluno extends StatefulWidget {
  final Aluno aluno;

  TelaEdicaoAluno({required this.aluno});

  @override
  _TelaEdicaoAlunoState createState() => _TelaEdicaoAlunoState();
}

class _TelaEdicaoAlunoState extends State<TelaEdicaoAluno> {
  late TextEditingController _segundaController;
  late TextEditingController _tercaController;
  late TextEditingController _quartaController;
  late TextEditingController _quintaController;
  late TextEditingController _sextaController;

  @override
  void initState() {
    super.initState();
    _segundaController = TextEditingController(text: widget.aluno.treino['Segunda-feira']);
    _tercaController = TextEditingController(text: widget.aluno.treino['Terça-feira']);
    _quartaController = TextEditingController(text: widget.aluno.treino['Quarta-feira']);
    _quintaController = TextEditingController(text: widget.aluno.treino['Quinta-feira']);
    _sextaController = TextEditingController(text: widget.aluno.treino['Sexta-feira']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Treino - ${widget.aluno.nome}',
          style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(123, 134, 156, 1),
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(0, 27, 48, 1),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Segunda-feira', _segundaController),
            _buildTextField('Terça-feira', _tercaController),
            _buildTextField('Quarta-feira', _quartaController),
            _buildTextField('Quinta-feira', _quintaController),
            _buildTextField('Sexta-feira', _sextaController),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _salvarTreino();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Salvo com sucesso!', style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                  ));
                },
                child: Text('Salvar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)), 
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromRGBO(123, 134, 156, 1), 
                  minimumSize: Size(500, 80)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white), 
          hintStyle: TextStyle(color: Colors.white), 
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), 
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), 
          ),
        ),
        style: TextStyle(color: Colors.white), 
      ),
    );
  }

  void _salvarTreino() {
    final novoTreino = {
      'Segunda-feira': _segundaController.text,
      'Terça-feira': _tercaController.text,
      'Quarta-feira': _quartaController.text,
      'Quinta-feira': _quintaController.text,
      'Sexta-feira': _sextaController.text,
    };

    setState(() {
      widget.aluno.treino = novoTreino;
    });

    Navigator.pop(context);
  }
}
