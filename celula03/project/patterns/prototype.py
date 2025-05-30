from __future__ import annotations
import copy
from abc import ABC, abstractmethod

class Plan(ABC):
    def __init__(self, name: str, details: dict):
        self.name = name
        self.details = details

    @abstractmethod
    def clone(self) -> Plan:
        ...

class WorkoutPlan(Plan):
    def clone(self) -> WorkoutPlan:
        return copy.deepcopy(self)

class MealPlan(Plan):
    def clone(self) -> MealPlan:
        return copy.deepcopy(self)
