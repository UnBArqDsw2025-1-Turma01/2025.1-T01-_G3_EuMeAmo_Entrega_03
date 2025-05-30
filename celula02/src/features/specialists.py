from src.core.iterator.specialist_iterator import SpecialistCatalog, Specialist, gerar_contato

def setup_specialists():
    catalog = SpecialistCatalog()
    # Agora passamos gerar_contato() para preencher o campo de contato
    catalog.add_specialist(Specialist("Dra. Ana Lima", "Psicologia", 10, gerar_contato()))
    catalog.add_specialist(Specialist("Dr. João Silva", "Nutrição", 7, gerar_contato()))
    catalog.add_specialist(Specialist("Dra. Maria Oliveira", "Fisioterapia", 8, gerar_contato()))
    catalog.add_specialist(Specialist("Dr. Pedro Almeida", "Educador Físico", 5, gerar_contato()))
    return catalog
