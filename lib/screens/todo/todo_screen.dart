import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kinzy_club/common/validators.dart';
import 'package:kinzy_club/repository/local_storage_repository.dart';
import 'package:kinzy_club/screens/auth/login_screen.dart';
import 'package:kinzy_club/screens/todo/cubit/todo_state.dart';
import 'package:kinzy_club/screens/todo/cubit/todolist_cubit.dart';

import 'models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<String> items = ["Recent", "A Week Ago", "A Month Ago", "Custom"];
  String? selectedItem;
  final ScrollController _mainListScrollController = ScrollController();
  Timer? _timer;
  bool? _lastMoveRight;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff6c5ce7),
        leading: const Icon(
          FontAwesomeIcons.clipboardList,
          color: Colors.white,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              context.read<LocalStorageRepository>().clearSession();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AddEditTastDialog(
                                title: "Add Todo",
                                onTap: (todo) {
                                  context.read<TodolistCubit>().addTodo(todo);
                                },
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Add Task",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Search: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Search...",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(),
                                      isDense: true, // Adjust height
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Sort By: ",
                                  style: TextStyle(fontSize: 16),
                                ),
                                DropdownButton<String>(
                                  value: selectedItem,
                                  hint: const Text("Select an option"),
                                  icon: const Icon(Icons.arrow_drop_down),
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.purple,
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedItem = newValue;
                                    });
                                  },
                                  items: items.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<TodolistCubit, List<TodoState>>(
                    builder: (context, state) {
                      return CustomScrollView(
                        scrollDirection: Axis.horizontal,
                        controller: _mainListScrollController,
                        slivers: [
                          ...Status.values.map(
                            (status) => SliverToBoxAdapter(
                              child: RowStatusCard(
                                tasks:
                                    state.singleWhereOrNull((e) => e.status == status)?.todoList ??
                                        [],
                                taskStatus: status,
                                screenSize: screenSize,
                                taskAccepted: (task, newStatus) {
                                  context.read<TodolistCubit>().replaceTodo(task, status);
                                },
                                onDrag: (isRight) {
                                  if (_lastMoveRight == isRight) {
                                    return;
                                  }

                                  _lastMoveRight = isRight;
                                  _moveMainList(isRight);
                                },
                                cancelDrag: () {
                                  _lastMoveRight = null;
                                  _timer?.cancel();
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _moveMainList(bool isRight) {
    _timer?.cancel();

    _timer = Timer(const Duration(milliseconds: 100), () {
      if (_mainListScrollController.offset <= 20 && !isRight) {
        _timer?.cancel();
        return;
      }

      if (_mainListScrollController.offset > (_mainListScrollController.position.maxScrollExtent)) {
        _timer?.cancel();
        return;
      }

      _mainListScrollController.animateTo(
        _mainListScrollController.offset + (isRight ? 50 : -50),
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeIn,
      );

      _moveMainList(isRight);
    });
  }
}

class AddEditTastDialog extends StatefulWidget {
  final String title;
  final Todo? todo;
  final void Function(Todo todo) onTap;

  const AddEditTastDialog({
    super.key,
    required this.title,
    this.todo,
    required this.onTap,
  });

  @override
  State<AddEditTastDialog> createState() => _AddEditTastDialogState();
}

class _AddEditTastDialogState extends State<AddEditTastDialog> {
  final fkey = GlobalKey<FormState>();
  Todo todo = Todo.empty();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: fkey,
        child: SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title",
                style: TextStyle(fontSize: 16),
              ),
              TextFormField(
                initialValue: widget.todo?.name,
                decoration: const InputDecoration(
                  hintText: "Task",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                validator: Validators.validate("Title can't be empty"),
                onSaved: (newValue) {
                  todo = todo.copyWith(name: newValue);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Description ",
                style: TextStyle(fontSize: 14),
              ),
              TextFormField(
                initialValue: widget.todo?.description,
                decoration: const InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                validator: Validators.validate("Description can't be empty"),
                onSaved: (newValue) {
                  todo = todo.copyWith(description: newValue);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 170, 170, 171),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          onPressed: () {
            if (fkey.currentState!.validate()) {
              fkey.currentState!.save();
              widget.onTap(todo);
              Navigator.of(context).pop();
            }
          },
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 124, 124, 125),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final int index;
  const TodoItem({super.key, required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.maxFinite,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                todo.description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Text(
                todo.createdAt.toString(),
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      context.read<TodolistCubit>().removeTodo(todo);
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddEditTastDialog(
                            title: "Edit Todo",
                            todo: todo,
                            onTap: (todo) {
                              context.read<TodolistCubit>().updateTodo(todo, index);
                            },
                          );
                        },
                      );
                    },
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Task Details"),
                            content: SizedBox(
                              height: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todo.name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Description : ${todo.description}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Created at: ${todo.createdAt.toString()}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xff6c5ce7),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5))),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Close", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "View",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// in a list view
class RowStatusCard extends StatelessWidget {
  final void Function(Todo task, Status newStatus) taskAccepted;
  final void Function(bool isRight) onDrag;
  final void Function() cancelDrag;

  final Status taskStatus;
  final List<Todo> tasks;
  final Size screenSize;

  const RowStatusCard({
    required this.tasks,
    required this.taskStatus,
    required this.screenSize,
    required this.taskAccepted,
    required this.onDrag,
    required this.cancelDrag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height * 0.8,
      width: screenSize.width * 0.85,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).colorScheme.primary,
            child: Text(
              taskStatus.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: DragTarget<Todo>(
              builder:
                  (BuildContext context, List<Todo?> candidateData, List<dynamic> rejectedData) {
                return ListStatusColumnWidget(
                  tasks: tasks,
                  taskStatus: taskStatus,
                  screenSize: screenSize,
                  onDrag: onDrag,
                  cancelDrag: cancelDrag,
                );
              },
              onWillAcceptWithDetails: (details) => true,
              onAcceptWithDetails: (details) {
                taskAccepted(details.data, taskStatus);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 7. Created a ListView that shows the tasks
class ListStatusColumnWidget extends StatelessWidget {
  final void Function(bool isRight) onDrag;
  final void Function() cancelDrag;

  final Status taskStatus;
  final List<Todo> tasks;
  final Size screenSize;

  const ListStatusColumnWidget({
    required this.tasks,
    required this.taskStatus,
    required this.screenSize,
    required this.onDrag,
    required this.cancelDrag,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: SizedBox(
          width: 200,
          height: 200,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Draggable<Todo>(
            data: tasks[index],
            dragAnchorStrategy: (draggable, context, position) {
              return pointerDragAnchorStrategy(draggable, context, position);
            },
            onDragUpdate: (details) {
              if (details.globalPosition.dx > screenSize.width * 0.8) {
                onDrag(true);
              } else if (details.globalPosition.dx < screenSize.width * 0.2) {
                onDrag(false);
              } else {
                cancelDrag();
              }
            },
            onDragEnd: (_) => cancelDrag(),
            onDragCompleted: () => cancelDrag(),
            onDraggableCanceled: (velocity, offset) => cancelDrag(),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: TodoItem(todo: tasks[index], index: index),
            ),
            feedback: TodoItem(todo: tasks[index], index: index),
            child: TodoItem(todo: tasks[index], index: index),
          ),
        );
      },
      itemCount: tasks.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(color: Colors.white, height: 10);
      },
    );
  }
}
