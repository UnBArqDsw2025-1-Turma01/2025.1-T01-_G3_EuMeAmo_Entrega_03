// views/notificacoes/notificacoes_modal.dart
import 'package:flutter/material.dart';

// This could be shown using showDialog or as a dedicated screen/widget
class NotificacoesModal extends StatefulWidget {
  const NotificacoesModal({super.key});

  @override
  State<NotificacoesModal> createState() => _NotificacoesModalState();
}

class _NotificacoesModalState extends State<NotificacoesModal> {
  final _novaNotificacaoController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _novaNotificacaoController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        // Apply custom theme if needed to match prototype colors
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFB74C4C), // primary color for picker
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define colors based on the prototype
    const Color primaryColor = Color(0xFFB74C4C); // Dark red
    const Color backgroundColor = Color(0xFFFDF3E7); // Light beige (modal background)
    const Color cardBackgroundColor = Colors.white; // Not directly used here, modal uses beige
    const Color textColor = Colors.black87;
    const Color hintColor = Colors.grey;
    const Color iconColor = Colors.white;
    const Color disabledColor = Colors.grey;

    // Mock data for notifications
    final List<Map<String, dynamic>> notificacoesAtivas = [
      {'nome': 'Jiu-jitsu', 'hora': '10:00', 'ativa': true},
      {'nome': 'Musculação', 'hora': '15:00', 'ativa': true},
    ];
    final List<Map<String, dynamic>> notificacoesInativas = [
      {'nome': '', 'hora': '', 'ativa': false},
      {'nome': '', 'hora': '', 'ativa': false},
    ];

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5, // Adjust width as needed
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notificações',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: textColor),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Fechar',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add New Notification Row
            _buildNotificationRow(
              controller: _novaNotificacaoController,
              hintText: 'Escreva o tema da sua notificação',
              time: _selectedTime,
              isInput: true,
              isActive: true,
              primaryColor: primaryColor,
              iconColor: iconColor,
              onTimeTap: () => _selectTime(context, (newTime) {
                setState(() {
                  _selectedTime = newTime;
                });
              }),
              onAddTap: () {
                // TODO: Implement add notification logic
                print('Add notification: ${_novaNotificacaoController.text} at ${_selectedTime.format(context)}');
              },
            ),
            const SizedBox(height: 16),

            // Existing Active Notifications List
            ...notificacoesAtivas.map((notificacao) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildNotificationRow(
                text: notificacao['nome'],
                timeString: notificacao['hora'],
                isActive: notificacao['ativa'],
                primaryColor: primaryColor,
                iconColor: iconColor,
                onViewTap: () => print('View ${notificacao['nome']}'),
                onEditTap: () => print('Edit ${notificacao['nome']}'),
                onDeleteTap: () => print('Delete ${notificacao['nome']}'),
              ),
            )),

            // Disabled Notifications Placeholder
            ...notificacoesInativas.map((notificacao) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildNotificationRow(
                text: notificacao['nome'],
                timeString: notificacao['hora'],
                isActive: notificacao['ativa'],
                primaryColor: primaryColor,
                iconColor: iconColor,
                disabledColor: disabledColor,
                onViewTap: () {},
                onEditTap: () {},
                onDeleteTap: () {},
              ),
            )),
          ],
        ),
      ),
    );
  }

  // Helper widget for notification rows
  Widget _buildNotificationRow({
    TextEditingController? controller,
    String? text,
    String? hintText,
    TimeOfDay? time,
    String? timeString,
    required bool isActive,
    bool isInput = false,
    required Color primaryColor,
    required Color iconColor,
    Color? disabledColor,
    VoidCallback? onTimeTap,
    VoidCallback? onAddTap,
    VoidCallback? onViewTap,
    VoidCallback? onEditTap,
    VoidCallback? onDeleteTap,
  }) {
    Widget textWidget;
    if (isInput && controller != null) {
      textWidget = Expanded(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          style: const TextStyle(fontSize: 14),
        ),
      );
    } else {
      textWidget = Expanded(
        child: Text(
          text ?? '',
          style: TextStyle(fontSize: 14, color: isActive ? Colors.black87 : disabledColor),
        ),
      );
    }

    String displayTime = '';
    if (time != null) {
      displayTime = time.format(context); // Use context for formatting
    } else if (timeString != null) {
      displayTime = timeString;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : disabledColor?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: isActive ? Colors.grey[300]! : Colors.transparent),
      ),
      child: Row(
        children: [
          textWidget,
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: isActive ? primaryColor : disabledColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isInput)
                  InkWell(
                    onTap: onTimeTap,
                    child: Text(
                      displayTime,
                      style: TextStyle(color: iconColor, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  )
                else
                  Text(
                    displayTime,
                    style: TextStyle(color: iconColor, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                const SizedBox(width: 8),
                if (isInput)
                  InkWell(
                    onTap: onAddTap,
                    child: Icon(Icons.add, color: iconColor, size: 18),
                  )
                else ...[
                  InkWell(
                    onTap: isActive ? onViewTap : null,
                    child: Icon(Icons.visibility_outlined, color: isActive ? iconColor : iconColor.withOpacity(0.5), size: 18),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: isActive ? onEditTap : null,
                    child: Icon(Icons.edit_outlined, color: isActive ? iconColor : iconColor.withOpacity(0.5), size: 18),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: isActive ? onDeleteTap : null,
                    child: Icon(Icons.delete_outline, color: isActive ? iconColor : iconColor.withOpacity(0.5), size: 18),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}



