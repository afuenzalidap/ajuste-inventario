import 'package:ajuste_inventario/models/inventario_model.dart';
import 'package:ajuste_inventario/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class BarcodeController extends GetxController {
  var isLoading = true.obs;
  Rx<Inventarios> inventarioList = Inventarios(inventario: []).obs;
  Services _services = Services();
  RxString barCode = ''.obs;
  Rx<TextEditingController> textEditing = TextEditingController().obs;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    barCode.value = await FlutterBarcodeScanner.scanBarcode(
        "#004297", "Cancel", true, ScanMode.BARCODE);
    //print(barCode.value);
    fetchInventario();
  }

  void fetchInventario() async {
    try {
      isLoading(true);
      var inventarios = await _services.fetchInventario(barCode.value);

      if (inventarios != null) {
        inventarioList.value = inventarios;
        textEditing.value.text = inventarios.inventario[0].cantidad.toString();
      }
    } finally {
      isLoading(false);
    }
  }

  void updateStock() async {
    print('BarCode = ${barCode.value}');
    print('Cantidad = ${textEditing.value.text}');

    try {
      isLoading(true);
      await _services.updateInventario(barCode.value, textEditing.value.text);
      textEditing.value.text = '';
    } finally {
      isLoading(false);
    }
  }
}
