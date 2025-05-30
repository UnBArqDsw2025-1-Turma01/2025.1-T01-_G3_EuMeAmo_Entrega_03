from threading import Lock
from datetime import datetime


class AppConfigManager:
    _instance = None
    _lock: Lock = Lock()
    
    def __new__(cls):
        with cls._lock:
            if not cls._instance:
                cls._instance = super().__new__(cls)
                # Inicialização de configurações
                cls._instance.notification_prefs = {}
                cls._instance.users = {}
                cls._instance.default_hydration_times = ['09:00', '12:00', '15:00', '18:00']
                cls._instance.notification_types = {
                    'hydration': "💧 Hora de se hidratar!",
                    'custom': {}
                }
            return cls._instance
    
    def add_custom_notification(self, user_id, name, time, message):
        if user_id not in self.notification_types['custom']:
            self.notification_types['custom'][user_id] = []
        
        self.notification_types['custom'][user_id].append({
            'name': name,
            'time': time,
            'message': message
        })
    
    def get_user_notifications(self, user_id):
        return {
            'hydration': self.users[user_id].get('hydration_schedule', []),
            'custom': self.notification_types['custom'].get(user_id, [])
        }
    
    def update_hydration_schedule(self, user_id, times):
        if user_id in self.users:
            self.users[user_id]['hydration_schedule'] = times
    
    def add_user(self, user_type, user_data):
        user_id = user_data['email']
        if user_id in self.users:
            raise ValueError("Usuário já existe")
        self.users[user_id] = {
            'type': user_type,
            'data': user_data,
            # Inicializa com os valores padrão
            'hydration_schedule': self.default_hydration_times.copy(),
            'alerts_enabled': True
        }
        return user_id
    
    def update_notification_prefs(self, user_id, prefs):
        if user_id in self.users:
            self.users[user_id]['notifications'] = prefs
    
    def get_hydration_schedule(self, user_id):
        # Garantir retorno de lista válida
        schedule = self.users.get(user_id, {}).get(
            'hydration_schedule',
            self.default_hydration_times.copy()
        )
        return [t.strip() for t in schedule if isinstance(t, str)]
    
    def send_notification(self, user_id, log_message):
        # Método para registrar atividades
        if user_id not in self.notification_prefs:
            self.notification_prefs[user_id] = []
        self.notification_prefs[user_id].append({
            'timestamp': datetime.now().isoformat(),
            'message': log_message
        })
