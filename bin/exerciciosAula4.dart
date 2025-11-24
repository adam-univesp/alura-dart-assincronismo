import 'dart:async';

StreamController<String> streamController = StreamController<String>();

void main() {
  StreamSubscription subscricao = streamController.stream.listen(
    (event) => print(event),
  );
  TaskManager tarefas = TaskManager();
  tarefas.addTask(
    Task(
      id: '1',
      title: 'Estudar Dart',
      description: 'Completar o módulo de fundamentos de Dart',
      isCompleted: false,
    ),
  );
  tarefas.addTask(
    Task(
      id: '2',
      title: 'Fazer compras',
      description: 'Comprar frutas e legumes no mercado',
      isCompleted: false,
    ),
  );
  tarefas.addTask(
    Task(
      id: '3',
      title: 'Ir à academia',
      description: 'Treino de musculação às 18h',
      isCompleted: false,
    ),
  );
}

class TaskManager {
  final List<Task> _listTasks = []; // Perceba que "Task" ainda não existe.
  void addTask(Task task) {
  streamController.add("adicionado tarefa: $task");
    _listTasks.add(task);
  }

  void toggleTaskStatus(String id) {
    int index = _listTasks.indexWhere((task) => task.id == id);
    Task task = _listTasks[index];
    task.isCompleted = !task.isCompleted;
    _listTasks[index] = task;

    if (task.isCompleted) {
      streamController.add("Tarefa ${task.title} Completa!");
    } else {
      streamController.add("troca tarefa: $task");
    }
  }

  List<Task> getAll() {
    return _listTasks;
  }

  Task getById(String id) {
    Task tarefa = _listTasks.firstWhere((task) => task.id == id);
    streamController.add("tarefa: ${tarefa.title}");
    return tarefa;
  }

  void delete(String id) {
    streamController.add("Tarefa $id deletado!");
    _listTasks.removeWhere((task) => task.id == id);
  }
}

class Task {
  String id;
  String title;
  String description;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      isCompleted: map["isCompleted"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "description": description,
      "isCompleted": isCompleted,
    };
  }
}
