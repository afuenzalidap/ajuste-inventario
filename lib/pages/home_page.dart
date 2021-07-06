import 'package:ajuste_inventario/controller/barcode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final _barcodeController = Get.put(BarcodeController());

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Card(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Text(
                      (_barcodeController
                                  .inventarioList.value.inventario.length ==
                              0)
                          ? 'Nombre de Producto'
                          : _barcodeController
                              .inventarioList.value.inventario[0].producto,
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(70.0),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Ingrese Cantidad',
                          labelStyle: TextStyle(color: Colors.blue)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: _barcodeController.textEditing.value,
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Ajustar Stock',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        _barcodeController.updateStock();

                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        _barcodeController.inventarioList.value.inventario = [];

                        Get.snackbar('Ajuste Inventario', 'Datos Actualizados',
                            backgroundColor: Colors.blue,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM);
                      }),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () {
              _barcodeController.scanBarcodeNormal();
            },
          ),
        ),
      );
}
