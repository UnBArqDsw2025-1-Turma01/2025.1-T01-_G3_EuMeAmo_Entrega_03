// views/calendario/calendario_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

// Import the model and controller
import '../../models/calendario_evento_model.dart';
import '../../controllers/calendario_controller.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({super.key});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  // Instantiate the controller
  final CalendarioController _controller = CalendarioController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<CalendarioEvento> _selectedEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // Get initial events from the controller
    _selectedEvents = _controller.getEventosParaDia(_selectedDay!);
  }

  // Use the controller's method to get events
  List<CalendarioEvento> _getEventsForDay(DateTime day) {
    return _controller.getEventosParaDia(day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // Get events for the newly selected day from the controller
        _selectedEvents = _controller.getEventosParaDia(selectedDay);
      });
    }
  }

  void _showAddEventDialog() {
    // Simple dialog for adding a mock event
    final TextEditingController eventTitleController = TextEditingController();
    TipoEventoCalendario selectedType = TipoEventoCalendario.outro;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Novo Evento'),
          content: StatefulBuilder( // Use StatefulBuilder for dropdown state
            builder: (BuildContext context, StateSetter setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: eventTitleController,
                    decoration: const InputDecoration(hintText: 'Título do Evento'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<TipoEventoCalendario>(
                    value: selectedType,
                    isExpanded: true,
                    hint: const Text("Tipo de Evento"),
                    onChanged: (TipoEventoCalendario? newValue) {
                      if (newValue != null) {
                        setStateDialog(() { // Use setState from StatefulBuilder
                          selectedType = newValue;
                        });
                      }
                    },
                    items: TipoEventoCalendario.values
                        .map<DropdownMenuItem<TipoEventoCalendario>>((TipoEventoCalendario value) {
                      return DropdownMenuItem<TipoEventoCalendario>(
                        value: value,
                        // Display enum value nicely (e.g., "Treino", "Consulta")
                        child: Text(value.toString().split('.').last[0].toUpperCase() + value.toString().split('.').last.substring(1)),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Adicionar'),
              onPressed: () {
                if (eventTitleController.text.isNotEmpty && _selectedDay != null) {
                  final novoEvento = CalendarioEvento(
                    titulo: eventTitleController.text,
                    data: _selectedDay!, // Use the currently selected day
                    tipo: selectedType,
                  );
                  // Add event using the controller
                  _controller.adicionarEvento(novoEvento);
                  // Refresh the events list for the selected day
                  setState(() {
                    _selectedEvents = _controller.getEventosParaDia(_selectedDay!);
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Evento "${novoEvento.titulo}" adicionado (mock)!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, insira um título para o evento.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final Color cardBackgroundColor = Theme.of(context).colorScheme.surface;
    final Color textColor = Theme.of(context).colorScheme.onSurface;
    final Color secondaryColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário'),
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Adicionar Evento',
            onPressed: _showAddEventDialog, // Call the dialog function
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar<CalendarioEvento>(
            locale: 'pt_BR',
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: primaryColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: secondaryColor, // Event marker color
                shape: BoxShape.circle,
              ),
              // Use onPrimaryColor for text on selected/today dates for better contrast
              selectedTextStyle: TextStyle(color: onPrimaryColor),
              todayTextStyle: TextStyle(color: onPrimaryColor),
              // Default text style
              defaultTextStyle: TextStyle(color: textColor),
              weekendTextStyle: TextStyle(color: textColor.withOpacity(0.7)),
              outsideTextStyle: TextStyle(color: textColor.withOpacity(0.4)),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 18.0, color: textColor, fontWeight: FontWeight.bold),
              leftChevronIcon: Icon(Icons.chevron_left, color: textColor),
              rightChevronIcon: Icon(Icons.chevron_right, color: textColor),
            ),
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              _selectedDay != null
                  ? 'Eventos para ${DateFormat('dd/MM/yyyy', 'pt_BR').format(_selectedDay!)}:'
                  : 'Selecione um dia',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          Expanded(
            child: _selectedEvents.isNotEmpty
                ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              itemCount: _selectedEvents.length,
              itemBuilder: (context, index) {
                final evento = _selectedEvents[index];
                IconData iconData;
                // Assign icon based on event type
                switch (evento.tipo) {
                  case TipoEventoCalendario.treino:
                    iconData = Icons.fitness_center;
                    break;
                  case TipoEventoCalendario.consulta:
                    iconData = Icons.medical_services_outlined;
                    break;
                  case TipoEventoCalendario.hidratacao:
                    iconData = Icons.water_drop_outlined;
                    break;
                  case TipoEventoCalendario.meditacao:
                    iconData = Icons.self_improvement;
                    break;
                  default:
                    iconData = Icons.event_note;
                }
                return Card(
                  color: cardBackgroundColor,
                  margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                  child: ListTile(
                    leading: Icon(iconData, color: primaryColor),
                    title: Text(evento.titulo, style: TextStyle(color: textColor)),
                    subtitle: evento.descricao != null
                        ? Text(evento.descricao!, style: TextStyle(color: textColor.withOpacity(0.7)))
                        : null,
                    onTap: () {
                      // TODO: Implementar navegação ou detalhe do evento
                      print('Evento selecionado: ${evento.titulo}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Detalhes do evento "${evento.titulo}" (Placeholder)')),
                      );
                    },
                  ),
                );
              },
            )
                : Center(
              child: Text(
                'Nenhum evento para este dia.',
                style: TextStyle(color: textColor.withOpacity(0.7)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

