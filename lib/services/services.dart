import 'package:ajuste_inventario/models/inventario_model.dart';
import 'package:http/http.dart' as http;

class Services {
  var client = http.Client();

  Future<Inventarios> fetchInventario(String cod) async {
    var response = await client.get('http://192.168.1.37:4000/inventario/$cod');
    if (response.statusCode == 200) {
      return inventariosFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<void> updateInventario(String id, String cantidad) async {
    await client.put('http://192.168.1.37:4000/inventario/$id',
        body: {'Cantidad': '$cantidad'});
  }
}
