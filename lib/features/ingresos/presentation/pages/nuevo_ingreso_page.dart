import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/ingreso_entity.dart';
import '../cubits/lista_ingresos_cubit.dart';

class NuevoIngresoPage extends StatefulWidget {
  const NuevoIngresoPage({super.key});

  @override
  State<NuevoIngresoPage> createState() => _NuevoIngresoPageState();
}

class _NuevoIngresoPageState extends State<NuevoIngresoPage> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  final _cantidadController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();

  // Definimos las "Fuentes" de ingreso
  final List<String> _fuentesDisponibles = [
    'Nómina',
    'Freelance',
    'Regalo',
    'Otro',
  ];

  String _fuenteSeleccionada = 'Nómina'; // Valor por defecto

  @override
  void dispose() {
    _descripcionController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  /// Muestra el DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _fechaSeleccionada) {
      setState(() {
        _fechaSeleccionada = picked;
      });
    }
  }

  void _guardarIngreso() {
    if (_formKey.currentState!.validate()) {
      final double? cantidad = double.tryParse(_cantidadController.text);
      if (cantidad == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, introduce una cantidad válida'),
          ),
        );
        return;
      }

      // Creamos una IngresoEntity
      final nuevoIngreso = IngresoEntity(
        // id: null (drift/DB se encargará de generarlo)
        cantidad: cantidad,
        descripcion: _descripcionController.text,
        fecha: _fechaSeleccionada,
        fuente: _fuenteSeleccionada,
      );

      context.read<ListaIngresosCubit>().agregarIngreso(nuevoIngreso);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Ingreso'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _guardarIngreso),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // --- CAMPO DESCRIPCIÓN ---
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- CAMPO CANTIDAD ---
              TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(
                  labelText: 'Cantidad',
                  prefixText: '€ ',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una cantidad';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Introduce un número válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 💡 13. --- CAMPO FUENTE ---
              DropdownButtonFormField<String>(
                value: _fuenteSeleccionada,
                decoration: const InputDecoration(
                  labelText: 'Fuente',
                  border: OutlineInputBorder(),
                ),
                // Mapea la lista de Strings a la lista de DropdownMenuItem
                items: _fuentesDisponibles.map((String fuente) {
                  return DropdownMenuItem<String>(
                    value: fuente,
                    child: Text(fuente),
                  );
                }).toList(),

                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _fuenteSeleccionada = newValue;
                    });
                  }
                },

                // Validación
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona una fuente';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- CAMPO FECHA ---
              ListTile(
                title: const Text('Fecha'),
                subtitle: Text(DateFormat.yMd().format(_fechaSeleccionada)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
