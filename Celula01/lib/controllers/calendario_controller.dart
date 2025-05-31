// controllers/calendario_controller.dart
import 'package:flutter/material.dart'; // Use ChangeNotifier for state management if needed
import '../models/calendario_evento_model.dart';

class CalendarioController extends ChangeNotifier {
  // Mock data using the CalendarioEvento model
  final Map<DateTime, List<CalendarioEvento>> _eventos = {
    DateTime.utc(2025, 5, 28): [
      CalendarioEvento(titulo: 'Treino de Peito', data: DateTime.utc(2025, 5, 28), tipo: TipoEventoCalendario.treino),
      CalendarioEvento(titulo: 'Meditação 10min', data: DateTime.utc(2025, 5, 28), tipo: TipoEventoCalendario.meditacao),
    ],
    DateTime.utc(2025, 5, 29): [
      CalendarioEvento(titulo: 'Consulta Nutricionista', data: DateTime.utc(2025, 5, 29), tipo: TipoEventoCalendario.consulta),
      CalendarioEvento(titulo: 'Lembrete Hidratação', data: DateTime.utc(2025, 5, 29), tipo: TipoEventoCalendario.hidratacao),
    ],
    DateTime.utc(2025, 6, 5): [
      CalendarioEvento(titulo: 'Treino de Perna', data: DateTime.utc(2025, 6, 5), tipo: TipoEventoCalendario.treino),
    ],
  };

  // Method to get events for a specific day
  List<CalendarioEvento> getEventosParaDia(DateTime dia) {
    DateTime diaNormalizado = DateTime.utc(dia.year, dia.month, dia.day);
    return _eventos[diaNormalizado] ?? [];
  }

  // Method to add an event (placeholder for now)
  void adicionarEvento(CalendarioEvento evento) {
    DateTime diaNormalizado = DateTime.utc(evento.data.year, evento.data.month, evento.data.day);
    if (_eventos.containsKey(diaNormalizado)) {
      _eventos[diaNormalizado]!.add(evento);
    } else {
      _eventos[diaNormalizado] = [evento];
    }
    // Notify listeners if using ChangeNotifier for state management
    // notifyListeners();
    print("Evento adicionado (mock): ${evento.titulo}");
  }

// TODO: Add methods for fetching events from a service (mock or real)
// TODO: Add methods for deleting or updating events
}

