import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  Task(this.nome, this.foto, this.dificuldade, {Key? key}) : super(key: key);

  int nivel = 0;
  int nivelClasse = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: mudarCorClasse(widget.nivelClasse),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                              child: assetOrNetwork()
                                  ? Image.asset(
                                      widget.foto,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      widget.foto,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Inverter Expanded com sizedbox se der erro
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Expanded(
                                  child: Text(
                                    widget.nome,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )),
                            Difficulty(difficultyLevel: widget.dificuldade)
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 52,
                              width: 52,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget.nivel <
                                              widget.dificuldade * 10 ||
                                          widget.nivelClasse == 5) {
                                        widget.nivel++;
                                      } else {
                                        widget.nivel = 1;
                                        widget.nivelClasse++;
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
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              height: 52,
                              width: 52,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget.nivel > 1) {
                                        widget.nivel--;
                                      } else if (widget.nivelClasse > 0) {
                                        widget.nivel = widget.dificuldade * 10;
                                        widget.nivelClasse--;
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
                          ],
                        ),
                      ]),
                ),
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
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nível ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
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

  // The level bar changes color if the class level goes up
  Color mudarCorClasse(int nivelClasse) {
    Color color = Colors.blue;
    switch (nivelClasse) {
      case 1:
        color = Colors.green;
        break;
      case 2:
        color = Colors.yellow;
        break;
      case 3:
        color = Colors.red;
        break;
      case 4:
        color = Colors.purple;
        break;
      case 5:
        color = Colors.black;
        break;
    }
    return color;
  }
}
