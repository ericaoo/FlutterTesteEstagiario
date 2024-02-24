import 'package:flutter/material.dart';
import 'tela_lista.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(123, 134, 156, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.home, size: 30, color: Color.fromRGBO(0, 27, 48, 1)), 
            Text(
              "Bem-vindo!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Confirmação',
                      style: TextStyle(
                        color: Color.fromRGBO(123, 134, 156, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Deseja realmente sair?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Color.fromRGBO(0, 27, 48, 1),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Color.fromRGBO(123, 134, 156, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(); // Fecha a tela principal
                        },
                        child: Text(
                          'Sair',
                          style: TextStyle(
                            color: Color.fromRGBO(123, 134, 156, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.logout, 
                  size: 30, 
                  color: Color.fromRGBO(0, 27, 48, 1),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(0, 27, 48, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaDeTransicao()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                backgroundColor: Color.fromRGBO(123, 134, 156, 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ENTRAR',
                    style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.login, size: 30, color: Color.fromRGBO(0, 27, 48, 1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaDeTransicao extends StatefulWidget {
  @override
  _TelaDeTransicaoState createState() => _TelaDeTransicaoState();
}

class _TelaDeTransicaoState extends State<TelaDeTransicao>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaLista()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 27, 48, 1),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center, 
                size: 50,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              SizedBox(height: 20),
              Text(
                'Bem-vindo, Professor!',
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
