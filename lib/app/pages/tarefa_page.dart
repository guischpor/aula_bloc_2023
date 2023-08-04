import 'package:aula_bloc_2023/app/data/blocs/tarefa_bloc.dart';
import 'package:aula_bloc_2023/app/data/blocs/tarefa_event.dart';
import 'package:aula_bloc_2023/app/data/blocs/tarefa_state.dart';
import 'package:aula_bloc_2023/app/data/models/tarefa_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late final TarefaBloc _tarefaBloc;

  @override
  void initState() {
    _tarefaBloc = TarefaBloc();
    _tarefaBloc.add(GetTarefas());
    super.initState();
  }

  @override
  void dispose() {
    _tarefaBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Pattern Tarefas'),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            _tarefaBloc.clearListTarefas();
            _tarefaBloc.add(GetTarefas());

   
          },
          child: _getBody()),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _tarefaBloc.add(
            PostTarefas(
              tarefa: const TarefaModel(
                nome: 'Terminar o Curso de Flutter',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getBody() {
    return _buildTarefas();
  }

  Widget _buildTarefas() {
    return BlocBuilder<TarefaBloc, TarefaState>(
      bloc: _tarefaBloc,
      builder: (context, state) {
        if (state is TarefaLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TarefaLoadedState) {
          final list = state.tarefas;
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = list[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Center(
                    child: Text(item.nome[0]),
                  ),
                ),
                title: Text(item.nome),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _tarefaBloc.add(
                      DeleteTarefa(
                        tarefa: item,
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
