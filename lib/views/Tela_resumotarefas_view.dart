import 'package:flutter/material.dart';

/// Tela que exibe um resumo das tarefas e uma lista detalhada de tarefas.
class TaskInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo das Tarefas'), // Título da tela no AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            /// GridView com informações resumidas sobre as tarefas
            GridView.count(
              crossAxisCount: 2, // Define 2 colunas no Grid
              shrinkWrap: true, // Garante que o Grid não ocupe toda a tela
              physics:
                  NeverScrollableScrollPhysics(), // Evita rolagem do GridView
              children: [
                TaskSummaryCard(
                  title: 'Pendentes',
                  count: 5,
                  color: Colors.orange,
                ),
                TaskSummaryCard(
                  title: 'Concluídas',
                  count: 3,
                  color: Colors.green,
                ),
                TaskSummaryCard(
                  title: 'Próximo Prazo',
                  count: 1,
                  color: Colors.red,
                ),
                TaskSummaryCard(
                  title: 'Total de Tarefas',
                  count: 9,
                  color: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 20), // Espaço entre o Grid e a Lista
            /// ListView com detalhes das tarefas
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Número de itens na lista
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Tarefa ${index + 1}'), // Nome da tarefa
                      subtitle: Text(
                        'Descrição da tarefa ${index + 1}',
                      ), // Descrição da tarefa
                      trailing: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ), // Ícone de status
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget para exibir os cartões de resumo das tarefas no GridView.
class TaskSummaryCard extends StatelessWidget {
  final String title; // Título do cartão (ex: Pendentes, Concluídas)
  final int count; // Quantidade de tarefas
  final Color color; // Cor do cartão

  TaskSummaryCard({
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color, // Define a cor do cartão
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ), // Bordas arredondadas
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title, // Exibe o título (ex: Pendentes)
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Espaço entre o título e o número
            Text(
              count.toString(), // Exibe a quantidade de tarefas
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
