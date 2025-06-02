from domain.user import User
from patterns.prototype import WorkoutPlan, MealPlan
from patterns.bridge import (
    EmailSender, PushSender,
    HydrationNotification, PostureNotification,
    UserPreferences, NotificationScheduler
)

from patterns.observer import PlanRegistry, SpecialistDashboard
import time


user = User('João', 'joao@example.com')
specialist = User('Dr. Ana', 'ana@clinic.com')

registry = PlanRegistry()
dashboard = SpecialistDashboard()
registry.add_observer(dashboard)

wp = WorkoutPlan('Treino 1', {'exercicios': ['alongamento', 'prancha'], 'freq': '3x/sem'})
mp = MealPlan('Plano Proteico', {'refeicoes': ['Peito de frango', 'Salada'], 'calorias': 1800})

registry.register_plan(wp, user, specialist)
registry.register_plan(mp, user, specialist)

print('Planos de treino:', registry.get_user_plans(user))

prefs = UserPreferences()
prefs.set_preferences('hydration', ['09:00', '12:00', '15:00'])
prefs.set_preferences('posture', ['10:00', '14:00'])

email_s = EmailSender()
push_s = PushSender()
sched = NotificationScheduler()

sched.schedule_for_user(HydrationNotification(email_s), user, prefs)
sched.schedule_for_user(PostureNotification(push_s), user, prefs)

print('Scheduler rodando...')
time.sleep(5)
