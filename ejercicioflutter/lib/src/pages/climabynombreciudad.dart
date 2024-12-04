import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ejercicioflutter/src/const/api_constanst.dart';
import 'package:ejercicioflutter/src/models/clima.dart';

class ClimaCiudadPage extends StatefulWidget {
  const ClimaCiudadPage({super.key});

  @override
  State<ClimaCiudadPage> createState() => _ClimaCiudadPageState();
}

class _ClimaCiudadPageState extends State<ClimaCiudadPage> {
  final TextEditingController _cityController = TextEditingController();
  Clima? clima;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta del Clima por Ciudad')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ingrese el nombre de la ciudad:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildTextField(_cityController, 'Ciudad'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _consultarClima,
              child: const Text('Consultar Clima'),
            ),
            const SizedBox(height: 20),
            if (clima != null) ...[
              _buildWeatherInfo('Clima', clima!.mainWeather),
              _buildWeatherInfo('Descripción', clima!.description),
              _buildWeatherInfo('Temperatura', clima!.temp.toStringAsFixed(1)),
              _buildWeatherInfo('Presión', '${clima!.pressure}'),
              _buildWeatherInfo('Humedad', '${clima!.humidity}%'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildWeatherInfo(String title, String value) {
    return Text('$title: $value', style: Theme.of(context).textTheme.headlineMedium);
  }

  Future<void> _consultarClima() async {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      _mostrarMensaje('Ingrese el nombre de una ciudad.');
      return;
    }

    final url = Uri.parse(
      '${ApiConstanst.baseurl}?q=$city&appid=${ApiConstanst.appid}&units=metric',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() => clima = Clima.fromJson(jsonDecode(response.body)));
      } else {
        _mostrarMensaje('Error al obtener datos del clima.');
      }
    } catch (e) {
      _mostrarMensaje('Error de red.');
    }
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
