import 'package:flutter/material.dart';

class TelaInicioView extends StatefulWidget {
  @override
  _TelaInicioState createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicioView> {
  final _formKey = GlobalKey<FormState>();
  String _nome = "";
  String _senha = "";
  bool _aceite = false;

  void _enviarFormulario() {
    if (_formKey.currentState!.validate() && _aceite) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login realizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
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
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ícone superior como botão
                      IconButton(
                        icon: Icon(Icons.person, size: 50, color: Colors.blue),
                        onPressed: () {},
                      ),
                      SizedBox(height: 20),

                      // Campo Nome com IconButton
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

                      // Campo Senha com IconButton
                      TextFormField(
                        obscureText: true,
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

                      // Aceite os termos
                      CheckboxListTile(
                        value: _aceite,
                        title: Text("Aceito os Termos de Uso"),
                        activeColor: Colors.blue.shade700,
                        onChanged: (value) => setState(() => _aceite = value!),
                      ),
                      SizedBox(height: 10),

                      // Botões de Ação com IconButton
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.grey[600],
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.login, color: Colors.white),
                            onPressed: _enviarFormulario,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.blue,
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
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
