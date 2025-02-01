import 'package:flutter/material.dart';
import 'package:flutter_currency_today/app/components/text_field_component.dart';
import 'package:flutter_currency_today/app/services/currency_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currencyService = CurrencyService();
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar = 0.0;
  double euro = 0.0;

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
    if (dolar > 0 && euro > 0) {
      dolarController.text = (real / dolar).toStringAsFixed(2);
      euroController.text = (real / euro).toStringAsFixed(2);
    }
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double dolarValue = double.parse(text);
    if (dolar > 0 && euro > 0) {
      realController.text = (dolarValue * dolar).toStringAsFixed(2);
      euroController.text = (dolarValue * dolar / euro).toStringAsFixed(2);
    }
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }

    double euroValue = double.parse(text);
    if (dolar > 0 && euro > 0) {
      realController.text = (euroValue * euro).toStringAsFixed(2);
      dolarController.text = (euroValue * euro / dolar).toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Cotação de Moedas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: FutureBuilder<Map?>(
          future: _currencyService.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text(
                  "Aguarde...",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (snapshot.hasError || snapshot.data == null) {
              return _buildMainContent(
                  "Ops, você está sem internet\nConecte-se a uma rede para fazer a cotação.");
            }

            var data = snapshot.data as Map<String, dynamic>;

            if (data["USDBRL"] != null && data["EURBRL"] != null) {
              dolar = double.tryParse(data["USDBRL"]["bid"]) ?? 0.0;
              euro = double.tryParse(data["EURBRL"]["bid"]) ?? 0.0;
            } else {
              return _buildMainContent("Dados indisponíveis");
            }

            return _buildMainContent();
          }),
    );
  }

  Widget _buildMainContent([String? errorMessage]) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20.0, top: 45.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Icon(
            size: 100,
            Icons.attach_money,
            color: Colors.indigo,
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.indigo,
                ),
              ),
            ),
          TextFieldComponent(
            label: "Reais",
            prefix: "R\$ ",
            controller: realController,
            function: _realChanged,
          ),
          const SizedBox(height: 14),
          TextFieldComponent(
            label: "Euros",
            prefix: "€ ",
            controller: euroController,
            function: _euroChanged,
          ),
          const SizedBox(height: 14),
          TextFieldComponent(
            label: "Dólares",
            prefix: "US\$ ",
            controller: dolarController,
            function: _dolarChanged,
          ),
        ],
      ),
    );
  }
}
