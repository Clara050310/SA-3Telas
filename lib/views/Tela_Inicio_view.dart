import 'package:flutter/material.dart';
import 'package:sa06_3telas/views/tela_tarefas_view.dart';

// Widget principal do app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Login',
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
      home: TelaInicioView(), // Define a tela inicial
    );
  }
}

// Tela de login com estado
class TelaInicioView extends StatefulWidget {
  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicioView> {
  final _formKey = GlobalKey<FormState>(); // Chave para controlar o formulário
  String _nome = ""; // Armazena o nome do usuário
  String _senha = ""; // Armazena a senha
  bool _aceite = false; // Indica se o usuário aceitou os termos

  // Função para validar e enviar o formulário
  void _enviarFormulario() {
    if (_formKey.currentState!.validate() && _aceite) {
      _formKey.currentState!.save(); // Salva os dados do formulário

      // Mostra uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login realizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );

      // Aguarda 1 segundo e navega para a próxima tela
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushNamed(
          context,
          "/tarefas");
      });
    } else {
      // Se o formulário estiver inválido ou os termos não forem aceitos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Preencha todos os campos corretamente e aceite os termos!",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fundo com degradê azul
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8, // Sombra do card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Borda arredondada
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey, // Atribui a chave ao formulário
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ícone no topo do card
                      IconButton(
                        icon: Icon(Icons.person, size: 50, color: Colors.blue),
                        onPressed: () {},
                      ),
                      SizedBox(height: 20),

                      // Campo de nome do usuário
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Digite seu Nome",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.person, color: Colors.blue),
                            onPressed: () {},
                          ),
                        ),
                        validator:
                            (value) =>
                                value!.isEmpty ? "Campo Obrigatório" : null,
                        onSaved: (value) => _nome = value!,
                      ),
                      SizedBox(height: 15),

                      // Campo de senha
                      TextFormField(
                        obscureText: true, // Oculta os caracteres da senha
                        decoration: InputDecoration(
                          labelText: "Insira uma Senha",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.lock, color: Colors.blue),
                            onPressed: () {},
                          ),
                        ),
                        validator:
                            (value) =>
                                value!.length < 6
                                    ? "A senha deve ter pelo menos 6 caracteres"
                                    : null,
                        onSaved: (value) => _senha = value!,
                      ),
                      SizedBox(height: 15),

                      // Checkbox de aceite dos termos
                      CheckboxListTile(
                        value: _aceite,
                        title: Text("Aceito os Termos de Uso"),
                        activeColor: Colors.blue.shade700,
                        onChanged: (value) => setState(() => _aceite = value!),
                      ),
                      SizedBox(height: 10),

                      // Botões de ação
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Botão para voltar
                          ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back),
                            label: Text("Voltar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[600],
                            ),
                          ),
                          // Botão para login (redireciona usando rotas nomeadas)
                          ElevatedButton.icon(
                            onPressed: _enviarFormulario,
                            icon: Icon(Icons.login),
                            label: Text("Entrar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
