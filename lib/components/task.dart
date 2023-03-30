import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  const Task(this.nome, this.foto, this.dificuldade, {Key? key})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  int nivel_classe = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: mudarCorClasse(nivel_classe),
              ),
              height: 140),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                height: 100,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black26,
                        ),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            widget.foto,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(
                                widget.nome,
                                style: const TextStyle(
                                    fontSize: 24,
                                    overflow: TextOverflow.ellipsis),
                              )),
                          Difficulty(difficultyLevel: widget.dificuldade)
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (nivel < widget.dificuldade * 10 || nivel_classe == 5) {
                                  nivel++;
                                } else {
                                  nivel = 1;
                                  nivel_classe++;
                                }
                              });
                              // print(nivel);
                            },
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(Icons.arrow_drop_up),
                                //Text('UP', style: TextStyle(fontSize: 12),)
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (nivel > 1) {
                                  nivel--;
                                } else if(nivel_classe > 0){
                                  nivel = widget.dificuldade * 10;
                                  nivel_classe--;
                                } 
                              });
                              // print(nivel);
                            },
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Icon(Icons.arrow_drop_down),
                                //Text('DOWN', style: TextStyle(fontSize: 8),)
                              ],
                            )),
                      )
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nível $nivel',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
  
  Color mudarCorClasse(int nivelClasse) {
    Color color = Colors.blue;
    switch (nivelClasse) {
      case 1:color = Colors.green;
        break;
      case 2:color = Colors.yellow;
        break;
      case 3:color = Colors.red;
        break;
      case 4:color = Colors.purple;
        break;        
      case 5:color = Colors.black;
        break;     
    }
    return color;
  }
}

