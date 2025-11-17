import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart'; // Se necesita 'intl' para formatear fechas

import '../../../../domain/entities/gasto_entity.dart';
import '../cubits/lista_gastos_cubit.dart';

class NuevoGastoPage extends StatefulWidget {
  const NuevoGastoPage({super.key});

  @override
  State<NuevoGastoPage> createState() => _NuevoGastoPageState();
}

class _NuevoGastoPageState extends State<NuevoGastoPage> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  final _cantidadController = TextEditingController();
  DateTime _fechaSeleccionada = DateTime.now();
  final List<String> _categoriasDisponibles = [
    'Alimentación',
    'Transporte',
    'Suscripciones',
    'Ocio',
    'Suministros Hogar',
    'Otros',
  ];
  @override
  void dispose() {
    _descripcionController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  String _categoriaSeleccionada = 'Alimentación';

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

  void _guardarGasto() {
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

      // Crear la entidad
      final nuevoGasto = GastoEntity(
        // id: null (drift/DB se encargará de generarlo)
        cantidad: cantidad,
        descripcion: _descripcionController.text,
        fecha: _fechaSeleccionada,
        categoria: _categoriaSeleccionada,
      );

      context.read<ListaGastosCubit>().agregarGasto(nuevoGasto);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Gasto'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _guardarGasto),
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
                  suffixText: '€ ',
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

              // --- CAMPO CATEGORÍA ---
              DropdownButtonFormField<String>(
                initialValue: _categoriaSeleccionada, // El valor actual
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
                // Mapea la lista de Strings a la lista de DropdownMenuItem
                items: _categoriasDisponibles.map((String categoria) {
                  return DropdownMenuItem<String>(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),

                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _categoriaSeleccionada = newValue;
                    });
                  }
                },

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona una categoría';
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
