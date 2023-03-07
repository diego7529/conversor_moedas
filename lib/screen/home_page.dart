import 'package:conversor_moedas/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double? dolar;
  double? euro;

  void _clearAll() {
    realController.clear();
    euroController.clear();
    dolarController.clear();
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar!).toStringAsFixed(2);
    euroController.text = (real / euro!).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar!).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar! / euro!).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro!).toStringAsFixed(2);
    dolarController.text = (euro * this.euro! / dolar!).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Conversor de Moedas"),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: FutureBuilder<Map?>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                      child: Text(
                    "Carregando Dados...",
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                      "Erro ao Carregar Dados :(",
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar =
                        snapshot.data!["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Icon(Icons.monetization_on_rounded,
                              size: 150.0, color: Colors.green),
                          const Divider(),
                          buildTextField(
                              "Reais", "R\$", realController, _realChanged),
                          const Divider(),
                          buildTextField("Dólares", "US\$", dolarController,
                              _dolarChanged),
                          const Divider(),
                          buildTextField(
                              "Euros", "€", euroController, _euroChanged),
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: const OutlineInputBorder(),
        prefixText: prefix),
    style: const TextStyle(color: Colors.green, fontSize: 25.0),
    onChanged: f as void Function(String)?,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
  );
}
