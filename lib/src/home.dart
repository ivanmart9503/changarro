import 'package:changarro/src/widgets/dialogo_deuda.dart';
import 'package:changarro/src/widgets/lista_personas.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Abarrotes Doña Brisia',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: ListaPersonas(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          EvaIcons.plus,
          size: 24.0,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).backgroundColor,
        onPressed: () => DialogoDeuda().mostrarDialogo(context),
      ),
    );
  }
}
