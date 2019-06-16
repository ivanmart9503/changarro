import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class ListaPersonas extends StatelessWidget {
  final Map<String, dynamic> _personas;
  final Function _pagado;

  ListaPersonas(this._personas, this._pagado);

  @override
  Widget build(BuildContext context) {
    print(_personas);
    return Container(
      color: Theme.of(context).backgroundColor,
      child: _personas.isNotEmpty
          ? ListView.builder(
              itemCount: _personas.length, itemBuilder: _buildTile)
          : Center(
              child: Text(
                'Hoy no fío, mañana sí',
                style: TextStyle(
                    color: Theme.of(context).accentColor.withAlpha(80),
                    fontSize: 24.0),
              ),
            ),
    );
  }

  Widget _buildTile(BuildContext context, int i) {
    String nombre = _personas.keys.elementAt(i);
    return Padding(
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
              "Debe: \$${_personas[nombre]}",
              style: TextStyle(
                color: Colors.brown.shade400,
              ),
            ),
            trailing: _buildPagar(nombre, context),
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildPagar(String nombre, BuildContext context) {
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: FloatingActionButton(
        onPressed: () => _pagado(nombre),
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
