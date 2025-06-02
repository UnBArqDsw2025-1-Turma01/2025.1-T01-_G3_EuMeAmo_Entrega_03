from __future__ import annotations
from abc import ABC, abstractmethod
import datetime
from typing import TYPE_CHECKING, List
from dataclasses import dataclass, field
import threading

if TYPE_CHECKING:
    from domain.user import User

class NotificationSender(ABC):
    @abstractmethod
    def send(self, msg: str, user_email: str) -> None:
        ...

class EmailSender(NotificationSender):
    def send(self, msg: str, user_email: str) -> None:
        print(f"[EMAIL → {user_email}] {msg}")

class PushSender(NotificationSender):
    def send(self, msg: str, user_email: str) -> None:
        print(f"[PUSH → {user_email}] {msg}")

class Notification(ABC):
    def __init__(self, sender: NotificationSender):
        self.sender = sender

    @abstractmethod
    def notify(self, user: User) -> None:
        ...

class HydrationNotification(Notification):
    def notify(self, user: User) -> None:
        now = datetime.datetime.now().strftime('%H:%M')
        self.sender.send(f"Hora de beber água! ({now})", user.email)

class PostureNotification(Notification):
    def notify(self, user: User) -> None:
        self.sender.send("Endireite-se e alongue-se por 2 min!", user.email)
@dataclass
class UserPreferences:
    preferences: dict = field(default_factory=dict)

    def set_preferences(self, category: str, times: List[str]) -> None:
        self.preferences[category] = times

    def get_preferences(self, category: str) -> List[str]:
        return self.preferences.get(category, [])

class NotificationScheduler:
    def __init__(self):
        self._timers: List[threading.Timer] = []

    def schedule_for_user(self, notification: Notification, user: User, prefs: UserPreferences) -> None:
        cat = notification.__class__.__name__.replace('Notification','').lower()
        for t in prefs.get_preferences(cat):
            hh, mm = map(int, t.split(':'))
            now = datetime.datetime.now()
            target = now.replace(hour=hh, minute=mm, second=0, microsecond=0)
            if target <= now:
                target += datetime.timedelta(days=1)
            delay = (target - now).total_seconds()
            timer = threading.Timer(delay, notification.notify, args=[user])
            timer.daemon = True
            timer.start()
            print(f"Scheduled {cat} notification for {user.email} at {target.time()}")