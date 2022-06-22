import 'package:first/components/menu_component.dart';
import 'package:first/model/jogador.dart';
import 'package:first/model/time.dart';
import 'package:first/service/rest_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddTime extends StatefulWidget {
  const AddTime({Key? key}) : super(key: key);

  @override
  State<AddTime> createState() => _AddTimeState();
}

class _AddTimeState extends State<AddTime> {
  Time timeEdit = Time();
  List<Jogador> jogadores = [];
  List<DropdownMenuItem<String>> lista = [];
  String idJogador = '';
  bool load = true;
  @override
  initState() {
    init();
  }

  init() async {
    await carregaJogadores();
  }

  carregaJogadores() async {
    List list = await RestService().list('/jogador/list', null);
    setState(() {
      jogadores = list.map((e) => Jogador.fromJson(e)).toList();
      jogadores.add(Jogador());
      lista = jogadores
          .map<DropdownMenuItem<String>>((e) => DropdownMenuItem<String>(
              value: e.id == null ? '' : e.id,
              child: Text(e.nome == null ? 'Selecione' : e.nome.toString())))
          .toList();
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuComponente(),
        appBar: AppBar(
          title: Text('Adicionar e editar'),
        ),
        body: getBody());
  }

  getBody() {
    if (load) {
      return SizedBox(
        child: Text('carregando'),
      );
    } else {
      return SizedBox(
          child: Column(
        children: [
          TextField(
              keyboardType: TextInputType.text,
              controller: TextEditingController(text: timeEdit.nome),
              onChanged: (value) => {timeEdit.nome = value},
              decoration: const InputDecoration(
                  labelText: 'Nome', border: OutlineInputBorder())),
          Container(height: 5),
          InputDecorator(
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  labelText: 'Pais',
                  border: OutlineInputBorder()),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                value: idJogador,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                hint: const Text('Pais'),
                isExpanded: true,
                onChanged: (any) {
                  setState(() {
                    idJogador = any.toString();
                    timeEdit.jogador = jogadores
                        .firstWhere((element) => element.id == idJogador);
                  });
                },
                items: lista,
              ))),
          Container(height: 5),
          ElevatedButton.icon(
              onPressed: () async {
                try {
                  if (timeEdit.id == null)
                    await RestService().save('time', timeEdit);
                  else {
                    await RestService().update('time', timeEdit);
                  }
                  Navigator.pop(context);
                  init();
                } catch (e) {
                  alerta(context, e.toString());
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('Salvar'))
        ],
      ));
    }
  }

  void alerta(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Atenção'),
              content: Text(message),
            ),
        barrierDismissible: true);
  }
}
