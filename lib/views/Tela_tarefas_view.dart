import 'package:flutter/material.dart';

/// Tela principal que exibe a lista de tarefas
class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

/// Estado da tela TaskListPage (controla mudanças e atualizações)
class _TaskListPageState extends State<TaskListPage> {
  final TextEditingController _controller =
      TextEditingController(); // Controlador do campo de texto

  // Lista de tarefas
  List<Task> tasks = [
    Task(title: 'Estudar para a prova'),
    Task(title: 'Comprar mantimentos'),
    Task(title: 'Lavar o carro'),
  ];

  /// Função para adicionar nova tarefa
  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: _controller.text)); // Adiciona nova tarefa
      });
      _controller.clear(); // Limpa o campo de texto
    }
  }

  /// Alterna entre tarefa concluída e não concluída
  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted; // Inverte o estado da tarefa
    });
  }

  /// Remove a tarefa da lista
  void _removeTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  int _selectedIndex = 0; // Aba selecionada

  /// Controla o clique nas abas do BottomNavigationBar
  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.pushNamed(context, '/resumo'); // Vai para a aba Resumo
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tela de configurações em construção')),
        );
        break;
    }
  }

  /// Função para construir cada item da tarefa
  Widget _buildTaskTile(Task task) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: task.isCompleted ? Colors.green : Colors.grey,
        ),
        onPressed: () => _toggleTaskCompletion(task),
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          color: task.isCompleted ? Colors.grey : Colors.black,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => _removeTask(task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Divide tarefas em concluídas e não concluídas
    final incompletas = tasks.where((task) => !task.isCompleted).toList();
    final completas = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Lista de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Nenhuma nova notificação')),
              );
            },
          ),
        ],
      ),

      // Drawer (menu lateral)
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/resumo');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Configurações em construção')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Central de ajuda em breve')),
                );
              },
            ),
          ],
        ),
      ),

      // Corpo principal com as listas
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Container para tarefas pendentes
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tarefas Pendentes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...incompletas
                      .map(_buildTaskTile)
                      .toList(), // Lista de tarefas não concluídas
                ],
              ),
            ),
            SizedBox(height: 16),

            // Container para tarefas concluídas
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tarefas Concluídas",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...completas
                      .map(_buildTaskTile)
                      .toList(), // Lista de tarefas concluídas
                ],
              ),
            ),
            SizedBox(height: 16),

            // Campo de adicionar nova tarefa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Adicionar nova tarefa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask, // Adiciona a tarefa
                ),
              ],
            ),
          ],
        ),
      ),

      // Barra inferior com navegação
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tarefas'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Resumo'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

/// Modelo de dados da tarefa
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}
