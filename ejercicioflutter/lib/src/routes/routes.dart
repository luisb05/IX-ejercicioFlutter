import 'package:ejercicioflutter/src/menu/menu.dart';
import 'package:ejercicioflutter/src/pages/climabycoordenadas.dart';
import 'package:ejercicioflutter/src/pages/climabynombreciudad.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> getRoutes()
{
  return <String,WidgetBuilder>{
    '/': (BuildContext context) => const MenuPage(),
    'Consultas Clima por Coordenadas': (BuildContext context) => const ClimaCoordenadasPage(),
    'Consultas Clima por Nombre de Ciudad': (BuildContext context) => const ClimaCiudadPage(),     
  };
}