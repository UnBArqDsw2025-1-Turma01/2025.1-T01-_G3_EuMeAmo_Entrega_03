from abc import ABC, abstractmethod
from datetime import date
from typing import List, Optional

# ----- Interfaces de Produto (com setters) -----

class IArtigoConteudo(ABC):
    @abstractmethod
    def exibir(self) -> None:
        pass

    @abstractmethod
    def getTitulo(self) -> str:
        pass
    @abstractmethod
    def setTitulo(self, titulo: str) -> None:
        pass

    @abstractmethod
    def getDescricao(self) -> str:
        pass
    @abstractmethod
    def setDescricao(self, descricao: str) -> None:
        pass

    @abstractmethod
    def getAutor(self) -> str:
        pass
    @abstractmethod
    def setAutor(self, autor: str) -> None:
        pass

    @abstractmethod
    def getDataPublicacao(self) -> date:
        pass
    @abstractmethod
    def setDataPublicacao(self, data_publicacao: date) -> None:
        pass

class ITreinoConteudo(ABC):
    @abstractmethod
    def getNome(self) -> str:
        pass
    @abstractmethod
    def setNome(self, nome: str) -> None:
        pass

    @abstractmethod
    def getDescricao(self) -> str:
        pass
    @abstractmethod
    def setDescricao(self, descricao: str) -> None:
        pass

    @abstractmethod
    def getNivelDificuldade(self) -> str: 
        pass

    @abstractmethod
    def getVideo(self) -> Optional[str]:
        pass
    @abstractmethod
    def setVideo(self, video: Optional[str]) -> None:
        pass

    @abstractmethod
    def getTipoTreino(self) -> str:
        pass
    @abstractmethod
    def setTipoTreino(self, tipo_treino: str) -> None:
        pass

    @abstractmethod
    def getEquipamentosNecessarios(self) -> List[str]:
        pass
    @abstractmethod
    def setEquipamentosNecessarios(self, equipamentos: List[str]) -> None:
        pass


# ----- Implementações de Artigos (com setters) -----

class ArtigoIniciante(IArtigoConteudo):
    def __init__(self, titulo: str, descricao: str, autor: str, data_publicacao: date):
        self._titulo = titulo
        self._descricao = descricao
        self._autor = autor
        self._data_publicacao = data_publicacao

    def exibir(self) -> None:
        print(f"--- Artigo Iniciante ---")
        print(f"Título: {self.getTitulo()}")
        print(f"Autor: {self.getAutor()} (Publicado em: {self.getDataPublicacao()})")
        print(f"Descrição: {self.getDescricao()}")

    def getTitulo(self) -> str: return self._titulo
    def setTitulo(self, titulo: str) -> None: self._titulo = titulo

    def getDescricao(self) -> str: return self._descricao
    def setDescricao(self, descricao: str) -> None: self._descricao = descricao

    def getAutor(self) -> str: return self._autor
    def setAutor(self, autor: str) -> None: self._autor = autor

    def getDataPublicacao(self) -> date: return self._data_publicacao
    def setDataPublicacao(self, data_publicacao: date) -> None: self._data_publicacao = data_publicacao

class ArtigoAvancado(IArtigoConteudo):
    def __init__(self, titulo: str, descricao: str, autor: str, data_publicacao: date):
        self._titulo = titulo
        self._descricao = descricao
        self._autor = autor
        self._data_publicacao = data_publicacao

    def exibir(self) -> None:
        print(f"--- Artigo Avançado ---")
        print(f"Título: {self.getTitulo()}")
        print(f"Autor: {self.getAutor()} (Publicado em: {self.getDataPublicacao()})")
        print(f"Descrição: {self.getDescricao()}")
        print(f"Conteúdo com termos técnicos e aprofundados.")

    def getTitulo(self) -> str: return self._titulo
    def setTitulo(self, titulo: str) -> None: self._titulo = titulo

    def getDescricao(self) -> str: return self._descricao
    def setDescricao(self, descricao: str) -> None: self._descricao = descricao

    def getAutor(self) -> str: return self._autor
    def setAutor(self, autor: str) -> None: self._autor = autor

    def getDataPublicacao(self) -> date: return self._data_publicacao
    def setDataPublicacao(self, data_publicacao: date) -> None: self._data_publicacao = data_publicacao

# ----- Implementações de Treinos (com setters) -----

class TreinoIniciante(ITreinoConteudo):
    def __init__(self, nome_treino: str, descricao: str, # nivel_dificuldade é fixo
                 video: Optional[str], tipo_treino: str, equipamentos: List[str],
                 exercicios_internos: Optional[List[str]] = None): # exercicios internos não terão setter na interface
        self._nome = nome_treino
        self._descricao = descricao
        self._nivel_dificuldade = "Iniciante" # Fixo para esta classe
        self._video = video
        self._tipo_treino = tipo_treino
        self._equipamentos = equipamentos
        self._exercicios_internos = exercicios_internos if exercicios_internos else []
        self._id_interno = f"trn_{nome_treino.lower().replace(' ', '_')}_ini"

    def getNome(self) -> str: return self._nome
    def setNome(self, nome: str) -> None: 
        self._nome = nome
    


    def getDescricao(self) -> str: return self._descricao
    def setDescricao(self, descricao: str) -> None: self._descricao = descricao

    def getNivelDificuldade(self) -> str: return self._nivel_dificuldade
    
    def getVideo(self) -> Optional[str]: return self._video
    def setVideo(self, video: Optional[str]) -> None: self._video = video

    def getTipoTreino(self) -> str: return self._tipo_treino
    def setTipoTreino(self, tipo_treino: str) -> None: self._tipo_treino = tipo_treino

    def getEquipamentosNecessarios(self) -> List[str]: return self._equipamentos
    def setEquipamentosNecessarios(self, equipamentos: List[str]) -> None: self._equipamentos = equipamentos
    

    def exibirDetalhesCompletos(self) -> None:
        print(f"--- Detalhes Completos: Treino Iniciante ---")
        print(f"ID Interno: {self._id_interno}")
        print(f"Nome: {self.getNome()} ({self.getNivelDificuldade()})")
        print(f"Tipo: {self.getTipoTreino()}")
        if self.getVideo():
            print(f"Vídeo Geral: {self.getVideo()}")
        print(f"Descrição: {self.getDescricao()}")
        print(f"Equipamentos: {', '.join(self.getEquipamentosNecessarios()) if self.getEquipamentosNecessarios() else 'Nenhum específico'}")
        if self._exercicios_internos:
            print("Exercícios (Interno):")
            for ex_nome in self._exercicios_internos:
                print(f"  - {ex_nome}")
        print("-" * 20)


class TreinoAvancado(ITreinoConteudo):
    def __init__(self, nome_treino: str, descricao: str,
                 video: Optional[str], tipo_treino: str, equipamentos: List[str],
                 exercicios_internos: Optional[List[str]] = None):
        self._nome = nome_treino
        self._descricao = descricao
        self._nivel_dificuldade = "Avançado" 
        self._video = video
        self._tipo_treino = tipo_treino
        self._equipamentos = equipamentos
        self._exercicios_internos = exercicios_internos if exercicios_internos else []
        self._id_interno = f"trn_{nome_treino.lower().replace(' ', '_')}_av"


    def getNome(self) -> str: return self._nome
    def setNome(self, nome: str) -> None: 
        self._nome = nome
       

    def getDescricao(self) -> str: return self._descricao
    def setDescricao(self, descricao: str) -> None: self._descricao = descricao

    def getNivelDificuldade(self) -> str: return self._nivel_dificuldade
    

    def getVideo(self) -> Optional[str]: return self._video
    def setVideo(self, video: Optional[str]) -> None: self._video = video

    def getTipoTreino(self) -> str: return self._tipo_treino
    def setTipoTreino(self, tipo_treino: str) -> None: self._tipo_treino = tipo_treino

    def getEquipamentosNecessarios(self) -> List[str]: return self._equipamentos
    def setEquipamentosNecessarios(self, equipamentos: List[str]) -> None: self._equipamentos = equipamentos

    def exibirDetalhesCompletos(self) -> None:
        print(f"--- Detalhes Completos: Treino Avançado ---")
        print(f"ID Interno: {self._id_interno}")
        print(f"Nome: {self.getNome()} ({self.getNivelDificuldade()})")
        print(f"Tipo: {self.getTipoTreino()}")
        if self.getVideo():
            print(f"Vídeo Geral: {self.getVideo()}")
        print(f"Descrição: {self.getDescricao()}")
        print(f"Equipamentos: {', '.join(self.getEquipamentosNecessarios()) if self.getEquipamentosNecessarios() else 'Nenhum específico'}")
        if self._exercicios_internos:
            print("Exercícios (Interno):")
            for ex_nome in self._exercicios_internos:
                print(f"  - {ex_nome}")
        print("-" * 20)

# ----- Abstract Factory 

class IConteudoFactory(ABC):
    @abstractmethod
    def createArtigo(self) -> IArtigoConteudo:
        pass

    @abstractmethod
    def createTreino(self) -> ITreinoConteudo:
        pass

# ----- Concrete Factories -----

class InicianteConteudoFactory(IConteudoFactory):
    def createArtigo(self) -> IArtigoConteudo:
        return ArtigoIniciante(
            titulo="Fundamentos da Musculação",
            descricao="Um guia completo para quem está começando na academia.",
            autor="Academia FitPlus",
            data_publicacao=date(2024, 1, 15)
        )

    def createTreino(self) -> ITreinoConteudo:
        return TreinoIniciante( 
            nome_treino="Adaptação Muscular Inicial",
            descricao="Treino leve para adaptação do corpo aos exercícios.",
            video="link_video_geral_treino_iniciante",
            tipo_treino="Full Body",
            equipamentos=["Colchonete"],
            exercicios_internos=["Agachamento (corpo)", "Flexão (joelhos)", "Prancha"]
        )

class AvancadoConteudoFactory(IConteudoFactory):
    def createArtigo(self) -> IArtigoConteudo:
        return ArtigoAvancado(
            titulo="Periodização Avançada para Hipertrofia",
            descricao="Estratégias de periodização de treino para atletas experientes.",
            autor="Dr. Maromba Forte",
            data_publicacao=date(2024, 2, 10)
        )

    def createTreino(self) -> ITreinoConteudo:
        return TreinoAvancado(
            nome_treino="Força e Potência Extrema",
            descricao="Treino de alta intensidade para desenvolvimento máximo.",
            video="link_video_geral_treino_avancado",
            tipo_treino="Força",
            equipamentos=["Barra Olímpica", "Anilhas", "Barra Fixa"],
            exercicios_internos=["Levantamento Terra", "Supino Reto", "Barra Fixa"]
        )

# ----- Conteudo Repository-----

class ConteudoRepository:
    def __init__(self):
        self._listaDeArtigos: List[IArtigoConteudo] = []
        self._listaDeTreinos: List[ITreinoConteudo] = []

    def adicionarArtigo(self, artigo: IArtigoConteudo) -> None:
        self._listaDeArtigos.append(artigo)
        

    def adicionarTreino(self, treino: ITreinoConteudo) -> None:
        self._listaDeTreinos.append(treino)
     

    def buscarArtigoPorTitulo(self, titulo: str) -> Optional[IArtigoConteudo]:
        for artigo in self._listaDeArtigos:
            if artigo.getTitulo().lower() == titulo.lower():
                return artigo
        return None

    def buscarTreinoPorNome(self, nome: str) -> Optional[ITreinoConteudo]:
        for treino in self._listaDeTreinos:
            if treino.getNome().lower() == nome.lower():
                return treino
        return None

    def listarTodosArtigos(self) -> List[IArtigoConteudo]:
        return self._listaDeArtigos

    def listarTodosTreinos(self) -> List[ITreinoConteudo]:
        return self._listaDeTreinos

    def removerArtigoPorTitulo(self, titulo: str) -> bool:
        artigo_para_remover = self.buscarArtigoPorTitulo(titulo)
        if artigo_para_remover:
            self._listaDeArtigos.remove(artigo_para_remover)
            print(f"Artigo '{titulo}' removido.")
            return True
        print(f"Artigo '{titulo}' não encontrado para remoção.")
        return False

    def removerTreinoPorNome(self, nome: str) -> bool:
        treino_para_remover = self.buscarTreinoPorNome(nome)
        if treino_para_remover:
            self._listaDeTreinos.remove(treino_para_remover)
            print(f"Treino '{nome}' removido.")
            return True
        print(f"Treino '{nome}' não encontrado para remoção.")
        return False

# ----- Exemplo de Uso-----
if __name__ == "__main__":
    repo = ConteudoRepository()
    iniciante_factory = InicianteConteudoFactory()
    
    # Criar um artigo template e modificá-lo
    artigo_template_iniciante = iniciante_factory.createArtigo()
    print("--- Template Original do Artigo Iniciante ---")
    artigo_template_iniciante.exibir()
    
    artigo_template_iniciante.setTitulo("Guia Essencial de Nutrição para Iniciantes")
    artigo_template_iniciante.setDescricao("Aprenda os conceitos básicos de nutrição para começar bem.")
    artigo_template_iniciante.setAutor("Nutricionista Esportivo")
    print("\n--- Template Modificado do Artigo Iniciante ---")
    artigo_template_iniciante.exibir()
    repo.adicionarArtigo(artigo_template_iniciante)
    
    print("-" * 30)

    # Criar um treino template e modificá-lo
    treino_template_iniciante = iniciante_factory.createTreino()
    print("\n--- Template Original do Treino Iniciante (via interface) ---")
    print(f"Nome: {treino_template_iniciante.getNome()}")
    print(f"Descrição: {treino_template_iniciante.getDescricao()}")
    print(f"Tipo: {treino_template_iniciante.getTipoTreino()}")
    
    # Para ver detalhes completos, se a instância for do tipo concreto
    if isinstance(treino_template_iniciante, TreinoIniciante):
        print("\n--- Template Original do Treino Iniciante (detalhes completos) ---")
        treino_template_iniciante.exibirDetalhesCompletos()

    treino_template_iniciante.setNome("Meu Primeiro Mês na Academia")
    treino_template_iniciante.setDescricao("Um plano de treino para as primeiras 4 semanas, focado em adaptação.")
    treino_template_iniciante.setTipoTreino("Adaptação Geral")
    treino_template_iniciante.setEquipamentosNecessarios(["Halteres Leves", "Colchonete", "Banda Elástica"])
    

    print("\n--- Template Modificado do Treino Iniciante (via interface) ---")
    print(f"Nome: {treino_template_iniciante.getNome()}")
    print(f"Descrição: {treino_template_iniciante.getDescricao()}")
    print(f"Tipo: {treino_template_iniciante.getTipoTreino()}")
    
    if isinstance(treino_template_iniciante, TreinoIniciante):
        print("\n--- Template Modificado do Treino Iniciante (detalhes completos) ---")
        treino_template_iniciante.exibirDetalhesCompletos()
    repo.adicionarTreino(treino_template_iniciante)

    print(f"\nTotal de artigos no repo: {len(repo.listarTodosArtigos())}")
    print(f"Total de treinos no repo: {len(repo.listarTodosTreinos())}")