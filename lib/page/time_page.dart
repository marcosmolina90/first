import 'package:first/model/time.dart';
import 'package:first/service/rest_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/menu_component.dart';

class TimePage extends StatefulWidget {
  const TimePage({Key? key}) : super(key: key);

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  List<Time> times = [];

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
                      title: Text(e.nome.toString()),
                      subtitle: Text(e.id.toString()),
                    )))
                .toList()) //Row(
        //children: times.map((e) => Text(e.nome.toString())).toList(),
        // )

        );
  }
}
