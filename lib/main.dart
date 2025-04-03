import 'package:flutter/material.dart';
import 'package:sa06_3telas/views/Tela_Inicio_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => TelaInicioView(),
        //colocar atela de tarefas
        //colocar a tela do resumo
      },
    ),
  );
}
