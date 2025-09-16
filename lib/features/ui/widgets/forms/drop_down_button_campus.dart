// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/core/helpers/helpers.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownButtonCampus extends StatefulWidget {
  final String? campus;
  final ValueChanged<String?> onCampusChanged;
  const DropDownButtonCampus({
    super.key,
    this.campus,
    required this.onCampusChanged,
  });

  @override
  State<DropDownButtonCampus> createState() => _DropDownButtonCampusState();
}

class _DropDownButtonCampusState extends State<DropDownButtonCampus> {
  final List<String> allCampus = Campus.allCampus;
  String? _selectedCampus;

  @override
  void initState() {
    super.initState();
    _selectedCampus = widget.campus;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(8),
        color: theme.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButtonFormField<String>(
          initialValue: _selectedCampus,
          isExpanded: true,
          // Define uma altura máxima para o menu dropdown
          menuMaxHeight: 300.0,
          borderRadius: BorderRadius.circular(8),
          dropdownColor: theme.primaryColor,
          style: theme.textTheme.bodyMedium,
          elevation: 10,
          validator: (value) {
            if (value == null || value.isEmpty) return "Insira um campus";
            return null;
          },
          icon: const Icon(Icons.arrow_downward),
          decoration: InputDecoration(
            labelText: "Insira o campus:",
            labelStyle: theme.textTheme.bodyMedium,
            // Controla a altura do campo
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            border: InputBorder.none, // Remove a borda padrão do FormField
          ),
          items: allCampus.map((String campus) {
            return DropdownMenuItem<String>(
              value: campus,
              // Simplificando o item para melhor controle de layout e performance
              child: Center(child: Text(campus)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCampus = value;
            });
            widget.onCampusChanged(value);
          },
        ),
      ),
    );
  }
}
