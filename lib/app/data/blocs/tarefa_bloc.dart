import 'package:aula_bloc_2023/app/data/blocs/tarefa_event.dart';
import 'package:aula_bloc_2023/app/data/blocs/tarefa_state.dart';
import 'package:aula_bloc_2023/app/data/models/tarefa_model.dart';
import 'package:aula_bloc_2023/app/data/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';

class TarefaBloc extends Bloc<TarefaEvent, TarefaState> {
  final _repository = TarefaRepository();

  TarefaBloc() : super(TarefaInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(TarefaEvent event, Emitter emit) async {
    List<TarefaModel> tarefas = [];

    emit(TarefaLoadingState());

    if (event is GetTarefas) {
      tarefas = await _repository.getTarefas();
    } else if (event is PostTarefas) {
      tarefas = await _repository.postTarefas(tarefa: event.tarefa);
    } else if (event is DeleteTarefa) {
      tarefas = await _repository.delteTarefas(tarefa: event.tarefa);
    }

    emit(TarefaLoadedState(tarefas: tarefas));
  }

  void clearListTarefas() {
    _repository.clearListTarefas();
  }
}
