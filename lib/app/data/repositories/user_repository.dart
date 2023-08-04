import 'package:aula_bloc_2023/app/data/models/tarefa_model.dart';

class TarefaRepository {
  final List<TarefaModel> _tarefas = [];

  Future<List<TarefaModel>> getTarefas() async {
    _tarefas.addAll([
      const TarefaModel(nome: 'Compras no mercado'),
      const TarefaModel(nome: 'Estudar Bloc'),
      const TarefaModel(nome: 'Jogar The Last Of Us'),
      const TarefaModel(nome: 'Trabalhar na Empresa'),
      const TarefaModel(nome: 'Criar o nosso projeto'),
    ]);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas,
    );
  }

  Future<List<TarefaModel>> postTarefas({required TarefaModel tarefa}) async {
    _tarefas.add(tarefa);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas,
    );
  }

  Future<List<TarefaModel>> delteTarefas({required TarefaModel tarefa}) async {
    _tarefas.remove(tarefa);

    return Future.delayed(
      const Duration(seconds: 2),
      () => _tarefas,
    );
  }

  clearListTarefas() {
    _tarefas.clear();
  }
}
