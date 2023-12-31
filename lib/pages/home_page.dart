import 'package:flutter/material.dart';
import 'package:todolist/data/database.dart';
import 'package:todolist/util/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controler
  final _contorller = TextEditingController();
  final _mybox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the first time ever opening this app, then create defaut data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // Case if there is already a database
      db.loadData();
    }
    super.initState();
  }

  // CheckBox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

// Save a task

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_contorller.text, false]);
    });

    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create new task

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        _contorller.clear();
        return DialogBox(
          controller: _contorller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Center(
            child: Text(
          'TO DO',
          style: TextStyle(fontWeight: FontWeight.w700),
        )),
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
