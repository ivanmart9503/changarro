import 'package:changarro/src/providers/lista_provider.dart';
import 'package:changarro/src/widgets/dialogo_cambiar_deuda.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:provider/provider.dart';

class ListaPersonas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listado = Provider.of<ListaProvider>(context);
    print(listado.personas);
    return Container(
      color: Theme.of(context).backgroundColor,
      child: listado.personas.isNotEmpty
          ? _buildList(context, listado)
          : Center(
              child: Text(
                'Hoy no fío, mañana sí',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 24.0,
                ),
              ),
            ),
    );
  }

  Widget _buildList(BuildContext context, ListaProvider listado) {
    return ListView.builder(
      itemCount: listado.personas.length,
      itemBuilder: (context, int i) {
        String nombre = listado.personas.keys.elementAt(i);
        String deuda = listado.personas[nombre];
        return GestureDetector(
          onTap: () =>
              DialogoCambiarDeuda(nombre, deuda).mostrarDialogo(context),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.all(15.0),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    foregroundColor: Colors.white,
                    child: Text(
                      nombre[0],
                    ),
                    maxRadius: 25.0,
                  ),
                  title: Text(
                    nombre,
                    style: TextStyle(
                      color: Colors.brown.shade400,
                      fontSize: 20.0,
                    ),
                  ),
                  subtitle: Text(
                    "Debe: \$$deuda",
                    style: TextStyle(
                      color: Colors.brown.shade400,
                    ),
                  ),
                  trailing: _buildPagar(context, listado, nombre),
                ),
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPagar(
      BuildContext context, ListaProvider listado, String nombre) {
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: FloatingActionButton(
        onPressed: () => listado.pagar(nombre),
        child: Icon(
          EvaIcons.checkmarkCircle2,
          size: 30.0,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        foregroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
        tooltip: 'Deuda saldada',
      ),
    );
  }
}
