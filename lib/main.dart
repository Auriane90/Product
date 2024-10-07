import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produtos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProdutoPage(),
    );
  }
}

class Produto {
  String nome;
  double preco;

  Produto(this.nome, this.preco);
}

class ProdutoPage extends StatefulWidget {
  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final _formKey = GlobalKey<FormState>();
  final List<Produto> _produtos = [];
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();

  void _adicionarProduto() {
    if (_formKey.currentState!.validate()) {
      final nome = _nomeController.text;
      final preco = double.tryParse(_precoController.text) ?? 0.0;

      setState(() {
        _produtos.add(Produto(nome, preco));
      });

      _nomeController.clear();
      _precoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome do Produto'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome do produto';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _precoController,
                    decoration: InputDecoration(labelText: 'Preço'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o preço do produto';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um número válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _adicionarProduto,
                    child: Text('Adicionar Produto'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _produtos.isEmpty
                  ? Center(child: Text('Nenhum produto cadastrado'))
                  : ListView.builder(
                      itemCount: _produtos.length,
                      itemBuilder: (context, index) {
                        final produto = _produtos[index];
                        return ListTile(
                          title: Text(produto.nome),
                          subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
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
