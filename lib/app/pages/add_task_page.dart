import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../model/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos do formulário
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isCompleted = false; // Controle para o switch
  late DateTime _dateCreated; // Data de criação é inicializada ao abrir a tela
  DateTime? _dateComplete; // Data de conclusão, inicialmente nula

  @override
  void initState() {
    super.initState();
    _dateCreated = DateTime.now(); // Define a data de criação como a data atual
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adicionar Nova Tarefa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo: Nome da tarefa
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Tarefa',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da tarefa.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo: Descrição
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Switch: Concluído ou não
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tarefa Concluída:', style: TextStyle(fontSize: 16)),
                      Switch(
                        value: _isCompleted,
                        onChanged: (value) {
                          setState(() {
                            _isCompleted = value;
                            _dateComplete = _isCompleted ? DateTime.now() : null;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Botão: Salvar
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        // Volta para a tela anterior
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Cria uma nova tarefa e adiciona ao BLoC
                          final newTask = TaskModel(
                            nameTask: _nameController.text,
                            description: _descriptionController.text,
                            completed: _isCompleted,
                            dateCreated: _dateCreated,
                            dateComplete: _dateComplete, // Define a data de conclusão, se aplicável
                          );

                          context.read<TaskBloc>().add(AddTask(newTask));

                          // Volta para a tela anterior
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }
}
