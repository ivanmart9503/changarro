import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListaProvider with ChangeNotifier {
  Map<String, dynamic> _personas = {};
  File _archivoJson;
  Directory _directorio;
  String _nombreArchivo = 'adeudos.json';
  bool _existe = false;

  // Getter
  get personas {
    return _personas;
  }

  // Setter
  set personas(Map<String, dynamic> listaNueva) {
    this._personas = listaNueva;
  }

  // Constructor
  ListaProvider() {
    // Inicializar el archivo y la lista de personas
    getApplicationDocumentsDirectory().then((Directory directory) {
      _directorio = directory;
      _archivoJson = new File(_directorio.path + "/" + _nombreArchivo);
      _existe = _archivoJson.existsSync();
      if (_existe) {
        personas = json.decode(_archivoJson.readAsStringSync());
        notifyListeners();
      }
    });
  }

  // Crear el archivo con contenido en caso de que no exista
  void _crearArchivo(Map<String, dynamic> contenido, Directory directorio,
      String nombreArchivo) {
    print('Creating file');
    File archivo = File('${directorio.path}/$nombreArchivo');
    archivo.createSync();
    _existe = true;
    archivo.writeAsStringSync(json.encode(contenido));
    personas = contenido;
  }

  // Guardar datos en el archivo
  void escribirDatos(String nombre, dynamic deuda) {
    //Verificar si el nombre y la deuda no estan vacios
    if (nombre.isNotEmpty || deuda.toString().isNotEmpty) {
      // Crear un nuevo map con los datos de la nueva persona
      Map<String, dynamic> nuevaPersona = {nombre: deuda};
      // Verificar si existe el archivo donde guardar la lista
      if (_existe) {
        // Obtener en forma de map el contenido del archivo local json
        Map<String, dynamic> lista =
            json.decode(_archivoJson.readAsStringSync());
        // Agregar la nueva persona a la lista obtenida
        lista.addAll(nuevaPersona);
        // Escribir nuevamente el archivo
        _archivoJson.writeAsStringSync(json.encode(lista));
        personas = lista;
      } else {
        // Si no existe el archivo, crearlo con la informacion de la persona a agregar
        _crearArchivo(nuevaPersona, _directorio, _nombreArchivo);
      }

      // Actualizar todos los widgets que esten escuchando este provider
      notifyListeners();
    }
  }

  // Funcion para quitar una persona de la lista negra
  // en caso de que haya pagado
  void pagar(String nombre) {
    if (nombre.isNotEmpty) {
      Map<String, dynamic> listaModificada = Map.of(_personas);
      listaModificada.remove(nombre);
      _archivoJson.writeAsStringSync(json.encode(listaModificada));
      personas = listaModificada;
      notifyListeners();
    }
  }

  // Funcion para modificar una deuda, disminuirla o aumentarla
  void modificarDeuda(String nombre, String nuevaDeuda) {
    if (nuevaDeuda.isNotEmpty) {
      Map<String, dynamic> listaModificada = Map.of(_personas);
      listaModificada[nombre] = nuevaDeuda;
      _archivoJson.writeAsStringSync(json.encode(listaModificada));
      personas = listaModificada;
      notifyListeners();
    }
  }
}
