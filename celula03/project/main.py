import time
from domain.user import User
from patterns.prototype import WorkoutPlan, MealPlan
from patterns.bridge import (
    EmailSender, PushSender,
    HydrationNotification)
from patterns.observer import (
    UserHealthData, HydrationAlert,
    SpecialistDashboard
)

base_plan = WorkoutPlan("Treino Postura Básico", {
    "exercicios": ["alongamento cervical", "prancha 30s"],
    "frequencia": "3x/sem"
})
clone_plan = base_plan.clone()
clone_plan.name = "Treino Postura Avançado"
clone_plan.details["exercicios"].append("superman 20x")

print(base_plan.name, base_plan.details)
print(clone_plan.name, clone_plan.details)


user = User("Maria", "maria@example.com")
email_sender = EmailSender()
push_sender = PushSender()

hydration_email = HydrationNotification(email_sender)
hydration_push = HydrationNotification(push_sender)

hydration_email.notify(user)
hydration_push.notify(user)

data = UserHealthData()
data.add_observer(HydrationAlert())
data.add_observer(SpecialistDashboard())

data.set_metric("hours_since_water", 3)
data.set_metric("weight", 70)
