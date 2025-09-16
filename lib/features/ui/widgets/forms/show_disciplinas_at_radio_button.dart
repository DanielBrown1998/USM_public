import 'package:app/features/controllers/disciplinas_controllers.dart';
import 'package:app/domain/models/disciplinas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowDisciplinasAtRadioButton extends StatefulWidget {
  final List<Disciplina>? disciplinas;
  final ValueChanged<List<Disciplina>> onDisciplinasChanged;
  final double height;
  const ShowDisciplinasAtRadioButton(
      {super.key,
      this.disciplinas,
      required this.onDisciplinasChanged,
      this.height = 350});

  @override
  State<ShowDisciplinasAtRadioButton> createState() =>
      _ShowDisciplinasAtRadioButtonState();
}

class _ShowDisciplinasAtRadioButtonState
    extends State<ShowDisciplinasAtRadioButton> {
  late List<Disciplina>? _disciplinasChanged;

  @override
  void initState() {
    super.initState();
    _disciplinasChanged = widget.disciplinas ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<DisciplinasController>(
      builder: (context, value, _) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.all(Radius.elliptical(8, 8)),
                color: theme.primaryColor,
                shape: BoxShape.rectangle),
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  SizedBox(
                    height: 30,
                    child: Text(
                      "Marque as Disciplinas:",
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final disciplina = value.disciplinas[index];
                        final isSelected =
                            _disciplinasChanged!.contains(disciplina);
                        return CheckboxListTile(
                          value: isSelected,
                          controlAffinity: ListTileControlAffinity.platform,
                          title: Text(
                            disciplina.nome,
                            style: theme.textTheme.bodySmall,
                          ),
                          onChanged: (bool? checked) {
                            setState(() {
                              if (checked == true) {
                                _disciplinasChanged!.add(disciplina);
                              } else {
                                _disciplinasChanged!.remove(disciplina);
                              }
                              widget.onDisciplinasChanged(_disciplinasChanged!);
                            });
                          },
                        );
                      },
                      itemCount: value.disciplinas.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
