import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Média Escolar',
      theme: ThemeData(hintColor: Colors.blue, useMaterial3: true),

      home: MediaEscolarPage(),
    );
  }
}

class MediaEscolarPage extends StatefulWidget {
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState() => _MediaEscolarPageState();
}

class _MediaEscolarPageState extends State<MediaEscolarPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();

  String nomeAluno = '';
  String situacao = '';
  double media = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculador de Média'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.school,
              size: 80
            ),
            const SizedBox(height: 10),
            const Text('Média Escolar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:26,
              fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      )
    );
  }
}
