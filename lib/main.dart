import 'package:flutter/material.dart';
// Importa as telas que serão utilizadas como rotas no app
import 'package:sa06_3telas/views/Tela_Inicio_view.dart';
import 'package:sa06_3telas/views/tela_tarefas_view.dart';
import 'package:sa06_3telas/views/tela_resumotarefas_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/", // Define a rota inicial como sendo a tela de início
      routes: {
        // Mapeamento de rotas do aplicativo
        "/": (context) => TelaInicioView(),
        "/tarefas": (context) => TaskListPage(),
        "/resumo": (context) => TaskInfoScreen(),
      },
    ),
  );
}
