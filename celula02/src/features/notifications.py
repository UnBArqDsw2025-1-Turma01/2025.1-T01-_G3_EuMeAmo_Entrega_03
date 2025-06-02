from datetime import datetime
from src.core.singleton.config_manager import AppConfigManager

class NotificationService:
    def __init__(self):
        self.config = AppConfigManager()
    
    def check_scheduled_notifications(self, user_id):
        current_time = datetime.now().strftime("%H:%M")
        notifications = self.config.get_user_notifications(user_id)
        
        # Verificar notificações de hidratação
        if current_time in notifications['hydration']:
            self.trigger_notification(user_id, "💧 Hora de se hidratar!")
        
        # Verificar notificações personalizadas
        for custom in notifications['custom']:
            if custom['time'] == current_time:
                self.trigger_notification(user_id, f"🔔 {custom['name']}: {custom['message']}")
    
    def trigger_notification(self, user_id, message):
        # Salvar estado atual do cursor
        print("\033[s", end="")
        
        # Limpar tela e mostrar notificação
        print("\033[2J\033[H")  # Código ANSI para clear screen
        print(f"\n\033[93m⭐ NOVA NOTIFICAÇÃO ⭐\n{message}\033[0m\n")
        input("Pressione Enter para continuar...")
        
        # Restaurar tela anterior
        print("\033[u", end="")
        
    def send_alert(self, user_id, message):
        """Dispara notificação imediata"""
        self.config.send_notification(user_id, message)
    
    def custom_alert(self, user_id, alert_type):
        """Notificações personalizadas por tipo"""
        messages = {
            'hydration': "Lembrete de hidratação!",
            'posture': "Hora de corrigir a postura!",
            'meditation': "Momento para meditar 🧘"
        }
        self.send_alert(user_id, messages.get(alert_type, "Novo alerta"))

# Exemplo de uso rápido
if __name__ == "__main__":
    service = NotificationService()
    service.custom_alert("test@user.com", "posture")