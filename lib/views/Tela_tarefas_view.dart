import 'package:flutter/material.dart';

// Componente de tela principal da lista de tarefas
class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

// Estado da tela de tarefas
class _TaskListPageState extends State<TaskListPage> {
  // Controlador do campo de texto para adicionar nova tarefa
  final TextEditingController _controller = TextEditingController();

  // Lista inicial de tarefas
  List<Task> tasks = [
    Task(title: 'Estudar para a prova'),
    Task(title: 'Comprar mantimentos'),
    Task(title: 'Lavar o carro'),
  ];

  // Função para adicionar uma nova tarefa à lista
  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(title: _controller.text)); // Adiciona nova tarefa
      });
      _controller.clear(); // Limpa o campo de texto
    }
  }

  // Função para marcar/desmarcar uma tarefa como concluída
  void _toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted; // Inverte o status de conclusão
    });
  }

  // Função para remover uma tarefa da lista
  void _removeTask(Task task) {
    setState(() {
      tasks.remove(task); // Remove a tarefa da lista
    });
  }

  // Índice selecionado da BottomNavigationBar
  int _selectedIndex = 0;

  // Função chamada ao tocar em um item da BottomNavigationBar
  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index; // Atualiza o índice selecionado
    });

    switch (index) {
      case 0:
        break; // já estamos na tela de tarefas
      case 1:
        Navigator.pushNamed(context, '/resumo'); // Navega para a tela de resumo
        break;
      case 2:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tela de configurações em construção')),
        ); // Mostra mensagem para configurações
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar no topo da tela
      appBar: AppBar(
        title: Text('Minha Lista de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Ícone de notificações
            onPressed: () {
              // Mostra mensagem de notificação
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Nenhuma nova notificação')),
              );
            },
          ),
        ],
      ),
      // Drawer (menu lateral esquerdo)
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue), // Fundo azul
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ), // Título do menu
              ),
            ),
            // Item: Dashboard
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                Navigator.pushNamed(context, '/resumo'); // Vai para resumo
              },
            ),
            // Item: Configurações
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Configurações em construção')),
                ); // Mostra aviso
              },
            ),
            // Item: Ajuda
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Ajuda'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Central de ajuda em breve')),
                ); // Mostra aviso
              },
            ),
          ],
        ),
      ),
      // Corpo principal da tela
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length, // Quantidade de tarefas
                itemBuilder: (context, index) {
                  final task = tasks[index]; // Tarefa atual
                  return ListTile(
                    // Ícone de status da tarefa
                    leading: IconButton(
                      icon: Icon(
                        task.isCompleted
                            ? Icons
                                .check_circle // Ícone de concluído
                            : Icons.radio_button_unchecked, // Ícone de pendente
                        color: task.isCompleted ? Colors.green : Colors.grey,
                      ),
                      onPressed:
                          () => _toggleTaskCompletion(task), // Alterna status
                    ),
                    // Título da tarefa
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isCompleted
                                ? TextDecoration
                                    .lineThrough // Riscado se concluída
                                : null,
                        color:
                            task.isCompleted
                                ? Colors.grey
                                : Colors.black, // Cor diferente
                      ),
                    ),
                    // Botão de deletar tarefa
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTask(task), // Remove a tarefa
                    ),
                  );
                },
              ),
            ),
            // Campo de texto + botão para adicionar tarefa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // Controlador do campo
                    decoration: InputDecoration(
                      hintText: 'Adicionar nova tarefa', // Texto de dica
                      border: OutlineInputBorder(), // Borda do campo
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add), // Ícone de adicionar
                  onPressed: _addTask, // Chama função para adicionar
                ),
              ],
            ),
          ],
        ),
      ),
      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Índice atual selecionado
        onTap: _onBottomNavTap, // Função ao tocar em item
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tarefas', // Aba atual
          ),
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

// Classe que representa uma Tarefa
class Task {
  String title; // Título da tarefa
  bool isCompleted; // Status de conclusão

  // Construtor da classe Task
  Task({required this.title, this.isCompleted = false});
}
