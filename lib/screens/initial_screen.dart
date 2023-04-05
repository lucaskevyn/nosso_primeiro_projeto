import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({Key? key}) : super(key: key);

  int nivelGeral = 0;

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Container(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Tarefas'),
                SizedBox(
                  width: 150,
                ),
                IconButton(
                  onPressed: () {
                    TaskInherited.of(context).taskList[0];
                  },
                  icon: Icon(Icons.sync),
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 220,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: 0.5,
                      ),
                    ),
                  ),
                  Text(
                    'Nível 5',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            )),
        body: ListView(
          children: TaskInherited.of(context).taskList,
          padding: EdgeInsets.only(top: 8, bottom: 70),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contextNew) => FormScreen(
                    taskContext: context,
                  ),
                ));
            // TaskInherited.of(context).newTask('Jogar', 'assets/images/jogar.jpg', 1);
          },
          child: const Icon(Icons.add),
        ));
  }
}
