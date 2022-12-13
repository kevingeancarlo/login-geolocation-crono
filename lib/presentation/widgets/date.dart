import 'package:animated_login/presentation/widgets/date_range_form_field.dart';
import 'package:animated_login/presentation/widgets/messages_screen.dart';
import 'package:flutter/material.dart';

import 'package:animated_login/presentation/widgets/messages_list.dart';

/* const List<String> list = <String>[
  'Carolina Alvarez',
  'Andrea Suarez',
  'Leandro Paredes',
  'Ezequiel Palacios',
  'Juan Foyth',
  'Andres Martinez',
  'Rodrigo de Paul',
  'Samy Batistuta'
]; */

const List<String> list = <String>[
  'Mantener y actualizar los programas existentes con requerimientos especificos',
  'Reparación de cable coaxial, fibra óptica y multipar de cobre',
  'Realizar pruebas básicas a líneas para localizar fallas',
  'Interactuar con los clientes de acuerdo con los protocolos y niveles de servicio',
  'Asistir el proceso de empalme',
  'Operar el equipo de computación, terminales e impresoras',
  'Coordinar y programar el uso de terminales y redes',
  'Verificar conexiones mecánicas, eléctricas y electrónicas del sistema',
  'Diagnóstico de fallas',
  'Reparación de equipo',
  'Atender solicitudes de usuarios del sistema'
];

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyFormField(),
    );
  }
}

class MyFormField extends StatefulWidget {
  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

GlobalKey<FormState> myFormKey = new GlobalKey();

class _MyFormFieldState extends State<MyFormField> {
  DateTimeRange? myDateRange;

  void _submitForm() {
    final FormState? form = myFormKey.currentState;
    form!.save();
  }

  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Programa de técnicos en la semana"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: myFormKey,
          child: Column(
            children: [
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new TextField(
                      decoration: InputDecoration(
                          /* hintText: 'Carolina Alvarez', */
                          border: OutlineInputBorder(),
                          labelText: 'Nombre del técnico',
                          contentPadding: EdgeInsets.all(10))),
                ),
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              /* new Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new TextField(
                      decoration:
                          InputDecoration(contentPadding: EdgeInsets.all(10))),
                ),
              ),
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new TextField(
                      decoration:
                          InputDecoration(contentPadding: EdgeInsets.all(10))),
                ),
              ), */
              SafeArea(
                child: DateRangeField(
                    firstDate: DateTime(1990),
                    enabled: true,
                    initialValue: DateTimeRange(
                        start: DateTime.now(),
                        end: DateTime.now().add(Duration(days: 5))),
                    decoration: InputDecoration(
                      labelText: 'Rango de fecha',
                      prefixIcon: Icon(Icons.date_range),
                      hintText:
                          'Por favor selecciona una fecha de inicio de campo y de fin para el técnico',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.start.isBefore(DateTime.now())) {
                        return 'Please enter a later start date';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        myDateRange = value!;
                      });
                    }),
              ),
              ElevatedButton(
                child: Text('Enviar cronograma'),
                onPressed: _submitForm,
              ),
              if (myDateRange != null)
                Text("Cronograma registrado: ${myDateRange.toString()}")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MessagesScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
