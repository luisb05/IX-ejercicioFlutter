import 'dart:convert';
import 'dart:developer';

import 'package:ejercicioflutter/src/const/api_constanst.dart';
import 'package:ejercicioflutter/src/models/clima.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClimaPage extends StatefulWidget {
  const ClimaPage({super.key});

  @override
  State<ClimaPage> createState() => _ClimaPageState();
}

class _ClimaPageState extends State<ClimaPage> {
  String temperatura = '';
  String descripcion = '';

  @override
  void initState() {
    super.initState();
    obtenerClima();
    //obtenerClimaActual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consulta del clima')),
      body: Center(
        child: temperatura.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Consulta del clima'),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Temperatura:'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Temperatura:$temperatura',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'timezone:$descripcion',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> obtenerClima() async {
    const latitude = 52.52;
    const longitude = 13.41;

    final url = Uri.parse(
        '${ApiConstanst.baseurl}?latitude=$latitude&longitude=$longitude&hourly=temperature_2m');

    try {
      final response = await http.get(url);
      log('response: $descripcion');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final climarespuesta = Clima.fromJson(data);
        setState(() {
          temperatura = '';
          descripcion = climarespuesta.timezone.toString();
          log('Desc: $descripcion');
        });
      } else {
        setState(() {
          temperatura = 'error de consulta';
          descripcion = 'error de consulta';
        });
      }
    } catch (e) {
      print('Error:$e');
    }
  }

  Future<void> obtenerClimaActual() async {
    final latitude = 52.52;
    final longitude = 13.41;

    final url = Uri.parse(
        '${ApiConstanst.baseurl}?latitude=$latitude&longitude=$longitude&current_weather=true');

    try {
      final response = await http.get(url);
      log('response: $response');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('data: $data');
        final climarespuesta = Clima.fromJson(data);
        setState(() {
          //temperatura = climarespuesta.hourly.temperature2M[0].toString();
          descripcion = climarespuesta.timezone.toString();
          print('Desc: $descripcion');
        });
      } else {
        setState(() {
          temperatura = 'error de consulta';
          descripcion = 'error de consulta';
        });
      }
    } catch (e) {
      log('Error:$e');
    }
  }
}