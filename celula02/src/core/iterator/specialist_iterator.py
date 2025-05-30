import random

def gerar_contato():
    prefixo = "+55 61 9"
    sufixo = "".join(str(random.randint(0, 9)) for _ in range(4))
    # Formato: +55 61 9XXXX-XXXX
    return f"{prefixo}{sufixo[:4]}-{sufixo}"

class Specialist:
    def __init__(self, name: str, specialty: str, experience: int, contact: str):
        self.name = name
        self.specialty = specialty
        self.experience = experience
        self.contact = contact

class SpecialistCatalog:
    def __init__(self):
        self.specialists = []
    
    def add_specialist(self, specialist: Specialist):
        self.specialists.append(specialist)
    
    def __iter__(self):
        return SpecialistIterator(self.specialists)

class SpecialistIterator:
    def __init__(self, specialists: list[Specialist]):
        self.specialists = specialists
        self.index = 0
    
    def __next__(self):
        if self.index < len(self.specialists):
            sp = self.specialists[self.index]
            self.index += 1
            return {
                'name': sp.name,
                'specialty': sp.specialty,
                'experience': f"{sp.experience} anos",
                'contact': sp.contact
            }
        raise StopIteration()

if __name__ == "__main__":
    catalog = SpecialistCatalog()
    catalog.add_specialist(Specialist("Dra. Ana", "Fisioterapia", 8, gerar_contato()))
    catalog.add_specialist(Specialist("Dr. Carlos", "Nutrição", 5, gerar_contato()))

    print("Especialistas disponíveis:")
    for idx, specialist in enumerate(catalog, 1):
        print(f"{idx}. {specialist['name']} - {specialist['specialty']} "
              f"- Exp: {specialist['experience']} - Contato: {specialist['contact']}")
