import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen.dart';

import '../components/task.dart';
import '../data/taskDao.dart';

class InitialScreen extends StatefulWidget {
  InitialScreen({Key? key}) : super(key: key);

  double nivelGeral = 0;

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  calculaNivelGeral() {
    // Colocar if para verificar mudança de barra
    double level = 0;
    for (Task task in TaskInherited.of(context).taskList) {
      level += (task.nivel / 10) * task.dificuldade;
    }
    widget.nivelGeral = level;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Container(),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.refresh))
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Tarefas'),
                // SizedBox(
                //   width: 150,
                // ),
                // IconButton(
                //   onPressed: () {
                //     setState(() {
                //       calculaNivelGeral();
                //     });
                //   },
                //   icon: Icon(Icons.sync),
                // )
              ],
            ),
            // bottom: PreferredSize(
            //   preferredSize: Size.zero,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: SizedBox(
            //           width: 220,
            //           child: LinearProgressIndicator(
            //             color: Colors.white,
            //             value: widget.nivelGeral / 10,
            //           ),
            //         ),
            //       ),
            //       Text(
            //         'Nível: ${widget.nivelGeral.toStringAsFixed(2)}',
            //         style: TextStyle(color: Colors.white, fontSize: 14),
            //       ),
            //     ],
            //   ),
            // ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            )),
        body: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder(
              future: TaskDao().findAll(),
              builder: (context, snapshot) {
                List<Task>? items = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ]),
                    );
                    break;
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ]),
                    );
                    break;
                  case ConnectionState.active:
                    return Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        Text('Carregando')
                      ]),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData && items != null) {
                      if (items.isNotEmpty) {
                        return ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final Task tarefa = items[index];
                              return tarefa;
                            });
                      }
                      return Center(
                          child: Column(
                        children: [
                          Icon(Icons.error_outline, size: 128),
                          Text(
                            'Não há nenhuma tarefa',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ));
                    }
                    return Text('Erro ao carregar Tarefas');
                    break;
                }
                return Text('Erro desconhecido');
              }),
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
