import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ejercicioflutter/src/const/api_constanst.dart';
import 'package:ejercicioflutter/src/models/clima.dart';

class ClimaCoordenadasPage extends StatefulWidget {
  const ClimaCoordenadasPage({super.key});

  @override
  State<ClimaCoordenadasPage> createState() => _ClimaCoordenadasPageState();
}

class _ClimaCoordenadasPageState extends State<ClimaCoordenadasPage> {
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  Clima? clima;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta del Clima')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ingrese las coordenadas:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            _buildTextField(_latitudeController, 'Latitud'),
            const SizedBox(height: 10),
            _buildTextField(_longitudeController, 'Longitud'),
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
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildWeatherInfo(String title, String value) {
    return Text('$title: $value', style: Theme.of(context).textTheme.headlineMedium);
  }

  Future<void> _consultarClima() async {
    final latitude = double.tryParse(_latitudeController.text);
    final longitude = double.tryParse(_longitudeController.text);

    if (latitude == null || longitude == null) {
      _mostrarMensaje('Ingrese coordenadas válidas.');
      return;
    }

    final url = Uri.parse(
      '${ApiConstanst.baseurl}?lat=$latitude&lon=$longitude&appid=${ApiConstanst.appid}',
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
