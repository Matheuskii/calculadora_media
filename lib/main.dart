import 'dart:math';

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
  final TextEditingController nota4Controller = TextEditingController();

  String nomeAluno = '';
  String situacao = '';
  double media = 0;
  double maiorNota = 0;
  double menorNota = 0;
  double faltante = 0;
  List<double> lista = [];
  late bool toPassThenote = media >= 7;

  @override
  Widget build(BuildContext context) {
    void mostrarMensagem(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }

    void calcularMedia() {
      String nome = nomeController.text.trim();

      double? nota1 = double.tryParse(
        nota1Controller.text.replaceAll(',', '.'),
      );
      double? nota2 = double.tryParse(
        nota2Controller.text.replaceAll(',', '.'),
      );
      double? nota3 = double.tryParse(
        nota3Controller.text.replaceAll(',', '.'),
      );
      double? nota4 = double.tryParse(
        nota4Controller.text.replaceAll(',', '.'),
      );

      double maiorNotaCalculada = 0;
      double menorNotaCalculada = 0;
      double? faltanteCalculado = 0;

      int frequencia = 0;

      if (nome.isEmpty ||
          nota1 == null ||
          nota2 == null ||
          nota3 == null ||
          nota4 == null) {
        mostrarMensagem("Preencha todos os camposs corretamente");
        return;
      }
      if (nota1 < 0 ||
          nota1 > 10 ||
          nota2 < 0 ||
          nota2 > 10 ||
          nota3 < 0 ||
          nota3 > 10 ||
          nota4 < 0 ||
          nota4 > 10) {
        mostrarMensagem("As notas devem estar entre 0 e 10");
        return;
      }

      lista.addAll([nota1, nota2, nota3, nota4]);

      double mediaCalculada = (nota1 + nota2 + nota3 + nota4) / 4;

      String situacaoCalculada;

      switch (mediaCalculada) {
        case >= 7:
          situacaoCalculada = "APROVADO";
        case <= 5:
          situacaoCalculada = "RECUPERAÇÃO";
        default:
          situacaoCalculada = "REPROVADO";
      }

      maiorNotaCalculada = lista.reduce(max);
      print(maiorNotaCalculada);
      menorNotaCalculada = lista.reduce(min);

      if (!toPassThenote) {
        double faltanteCalculado = 7 - mediaCalculada;
        print(faltanteCalculado);
      }
      setState(() {
        nomeAluno = nome;
        situacao = situacaoCalculada;
        media = mediaCalculada;
        maiorNota = maiorNotaCalculada;
        menorNota = menorNotaCalculada;
        faltante = faltanteCalculado;
      });
    }

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
            const Icon(Icons.school, size: 80),
            const SizedBox(height: 10),
            const Text(
              'Média Escolar',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Digite o nome e as três notas do aluno',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Aluno',
                hintText: 'Matheus',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: nota1Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Nota 1',
                hintText: 'Digite uma nota de 0 a 10',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: nota2Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Nota 2',
                hintText: 'Digite uma nota de 0 a 10',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: nota3Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Nota 3',
                hintText: 'Digite uma nota de 0 a 10',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: nota4Controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Nota 4',
                hintText: 'Digite uma nota de 0 a 10',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton.icon(
              onPressed: calcularMedia,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular média'),
            ),

            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: limparCampos,
              icon: const Icon(Icons.delete),
              label: const Text("Limpar"),
            ),

            const SizedBox(height: 25),

            if (situacao.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(escolherIcone(), size: 60),
                      Text(
                        nomeAluno,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Média: ${media.toStringAsFixed(1)}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        situacao,

                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Maior nota calculada: ${maiorNota.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Menor nota calculada: ${menorNota.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (!toPassThenote)
                          Text(
                            'Falta isso seu bosta: ${menorNota.toStringAsFixed(1)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void limparCampos() {
    nomeController.clear();
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();
    nota4Controller.clear();

    setState(() {
      nomeAluno = "";
      media = 0;
      situacao = '';
    });
  }

  IconData escolherIcone() {
    switch (situacao) {
      case "APROVADO":
        return Icons.check_circle;
      case "RECUPERAÇÃO":
        return Icons.warning;
      case "REPROVADO":
        return Icons.sms_failed;
      default:
        return Icons.drive_file_rename_outline;
    }
  }
}
