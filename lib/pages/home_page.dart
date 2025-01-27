import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> getData() async {
  String request = "https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL";
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  late double dolar;
  late double euro;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  Widget buildTextField(String label, String prefix,
      TextEditingController controller, ValueChanged<String> function) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
        border: OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: TextStyle(
        color: Colors.blue,
        fontSize: 25,
      ),
      onChanged: function,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Currency Today"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Aguarde...",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );

              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Ops, houve uma falha ao buscar os dados",
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  // Verificar se os dados estão disponíveis e na estrutura esperada
                  var data = snapshot.data as Map<String, dynamic>;

                  if (data["USDBRL"] != null && data["EURBRL"] != null) {
                    dolar = double.parse(data["USDBRL"]["bid"]);
                    euro = double.parse(data["EURBRL"]["bid"]);

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.attach_money,
                              size: 180, color: Colors.blue),
                          buildTextField(
                              "Reais", "R\$", realController, _realChanged),
                          Divider(),
                          buildTextField(
                              "Euros", "€", euroController, _euroChanged),
                          Divider(),
                          buildTextField("Dólares", "US\$", dolarController,
                              _dolarChanged),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Dados indisponíveis",
                        style: TextStyle(color: Colors.blue, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                }
            }
          }),
    );
  }
}
