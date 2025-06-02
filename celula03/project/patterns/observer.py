# patterns/observer.py
from __future__ import annotations
from abc import ABC, abstractmethod
from typing import List

class Observer(ABC):
    @abstractmethod
    def update(self, data) -> None:
        raise NotImplementedError
    
class UserHealthData:
    def __init__(self):
        self._observers: List[Observer] = []
        self.metrics: dict = {}

    def add_observer(self, obs: Observer) -> None:
        self._observers.append(obs)

    def remove_observer(self, obs: Observer) -> None:
        self._observers.remove(obs)

    def set_metric(self, key: str, value) -> None:
        self.metrics[key] = value
        self._notify_all()

    def _notify_all(self) -> None:
        for obs in self._observers:
            obs.update(self.metrics)

class HydrationAlert(Observer):
    def update(self, data) -> None:
        if data.get("hours_since_water", 0) >= 2:
            print("🔔 Alerta: faz mais de 2 h sem hidratação!")

class PlanRegistry:
    def __init__(self):
        self._observers: List[Observer] = []
        self._entries: List[dict] = []

    def add_observer(self, obs: Observer) -> None:
        self._observers.append(obs)

    def remove_observer(self, obs: Observer) -> None:
        self._observers.remove(obs)

    def register_plan(self, plan, user, specialist=None) -> None:
        entry = {'plan': plan, 'user': user, 'specialist': specialist}
        self._entries.append(entry)
        for obs in self._observers:
            obs.update(entry)

    def get_user_plans(self, user) -> List[dict]:
        return [e for e in self._entries if e['user'] == user]

class SpecialistDashboard(Observer):
    def update(self, data) -> None:
        print(f"[DASHBOARD] Novo evento: {data}")
