import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Opciones'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  //Navigator.push(context,
                  //    MaterialPageRoute(builder: (context) => operaciones()));
                  Navigator.pushNamed(context, 'Consultas Clima por Coordenadas');
                },
                child: const Text('Clima')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  //Navigator.push(context,
                  //    MaterialPageRoute(builder: (context) => operaciones()));
                  Navigator.pushNamed(context, 'clima2');
                },
                child: const Text('consultas')),
          ],
        ),
      ),
    );
  }
}