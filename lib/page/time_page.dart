import 'package:first/model/jogador.dart';
import 'package:first/model/time.dart';
import 'package:first/page/app_page.dart';
import 'package:first/service/rest_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:first/global.dart' as globals;
import '../components/menu_component.dart';

class TimePage extends StatefulWidget {
  const TimePage({Key? key}) : super(key: key);

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  List<Time> times = [];
  Time timeEdit = Time();
  List<Jogador> jogadores = [];
  String idJogagor = "";
  List<DropdownMenuItem<String>> lista = [];
  bool load = true;
  @override
  initState() {
    init();
  }

  init() async {
    List list = await RestService().list('/time/list', null);
    setState(() {
      times = list.map((e) => Time.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuComponente(),
      appBar: AppBar(
        title: Text('Time lista versão 1'),
      ),
      body: ListView(
          children: times
              .map((e) => Card(
                      child: ListTile(
                    trailing: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.close),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(CircleBorder()),
                        padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.red), // <-- Button color
                      ),
                    ),
                    onTap: () async {
                      timeEdit = e;
                      idJogagor = e.id!;
                    },
                    title: Text(e.nome.toString()),
                    subtitle: Text(e.id.toString()),
                  )))
              .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/addTime");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
