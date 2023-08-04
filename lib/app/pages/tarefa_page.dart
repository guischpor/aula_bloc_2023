import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Pattern Tarefas'),
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return _buildTarefas();
  }

  Widget _buildTarefas() {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            child: Center(
              child: Text('${index + 1}'),
            ),
          ),
          title: Text('Tarefa ${index + 1}'),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
