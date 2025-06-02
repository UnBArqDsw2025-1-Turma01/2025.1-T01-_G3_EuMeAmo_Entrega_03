from src.core.singleton.config_manager import AppConfigManager
from src.core.adapter.timer_adapter import ActivityTimer
from src.core.iterator.specialist_iterator import Specialist, SpecialistCatalog
from src.features.specialists import setup_specialists
from src.features.notifications import NotificationService
import time
import sys
from threading import Thread, RLock
from datetime import datetime

class InteractiveApp:
    def __init__(self):
        self.config = AppConfigManager()
        self.notification_service = NotificationService()
        self.specialists: SpecialistCatalog = setup_specialists()
        self.current_user = None
        self.current_user_type = None
        self.current_timer = None

        # Lock para sincronizar prints (tanto do timer quanto das notificações)
        self.print_lock = RLock()

        # Thread de exibição do timer em tempo real
        self._display_thread = None
        self._display_running = False

        # Thread de background para checar hidratação e notificações personalizadas
        self.notification_thread = Thread(target=self.check_notifications, daemon=True)
        self.notification_thread.start()

    def clear_screen(self):
        print("\033[2J\033[H", end='')

    def show_header(self):
        """Limpa a tela reservando as linhas iniciais para o header e espaço para o timer abaixo."""
        with self.print_lock:
            print("\033[2J\033[H", end='')   # Limpa tudo e vai para o topo
            print("")                       # Linha 1 (reservada para o timer)
            print("═" * 50)                 # Linha 2
            print("🏋️‍♂️  EU ME AMO - Bem-Estar Integrado  🧘‍♀️")  # Linha 3
            print("═" * 50)                 # Linha 4

    def main_menu(self):
        while True:
            try:
                self.show_header()
                print("\nMENU PRINCIPAL:\n")

                if not self.current_user:
                    print("1. 👤 Login/Cadastro\n")
                    print("2. 🚪 Sair\n")
                else:
                    user_type_display = "[Usuário]" if self.current_user_type == "usuário" else "[Especialista]"
                    print(f"Conta: {self.current_user} {user_type_display}\n")
                    print("1. ⏰ Gerenciar Timer de Atividades\n")
                    print("2. 🔔 Configurar Notificações\n")
                    print("3. 🩺 Ver Especialistas\n")
                    print("4. 🚪 Logout\n")

                choice = input("Escolha uma opção: ").strip()
                if choice == "":
                    continue

                if not self.current_user:
                    if choice == "1":
                        self.user_login_or_register()
                    elif choice == "2":
                        self.exit_app()
                    else:
                        self.invalid_choice()
                else:
                    if choice == "1":
                        self.timer_menu()
                    elif choice == "2":
                        self.notification_menu()
                    elif choice == "3":
                        self.show_specialists()
                    elif choice == "4":
                        self.current_user = None
                        self.current_user_type = None
                    else:
                        self.invalid_choice()

            except Exception as e:
                print(f"\n\033[91mERRO: {str(e)}\033[0m")
                time.sleep(1)
                self.exit_app()

    def user_login_or_register(self):
        self.show_header()
        print("\n🔐 Login ou Cadastro de Usuário/Especialista\n")

        email = input("Digite seu e-mail: ").strip().lower()

        if email in self.config.users:
            print()  # Espaço
            # Já cadastrado: pedir senha
            for _ in range(3):
                senha = input("Digite a senha: ").strip()
                stored = self.config.users[email]['data']['password']
                if senha == stored:
                    self.current_user = email
                    self.current_user_type = self.config.users[email]['type']
                    print("\nLogin realizado com sucesso! ✅")
                    time.sleep(1)
                    return
                else:
                    print("\nSenha incorreta. Tente novamente.\n")

            print("\nFalha no login após 3 tentativas. Retornando ao menu.")
            time.sleep(1)
            return

        # Novo cadastro
        print("\n📝 Novo Cadastro:\n")

        name = input("Nome completo: ").strip().title()
        print()  # Espaço

        while True:
            password = input("Senha (min 6 caracteres): ").strip()
            if len(password) >= 6:
                break
            print("\nSenha muito curta! Tente novamente.\n")

        print()  # Espaço

        while True:
            user_type = input("Tipo de cadastro [usuário/especialista]: ").lower().strip()
            if user_type in ['usuário', 'especialista']:
                break
            print("\nTipo inválido! Escolha 'usuário' ou 'especialista'.\n")

        user_data = {'name': name, 'email': email, 'password': password}

        if user_type == 'usuário':
            # Dados adicionais para usuário comum
            print()  # Espaço
            while True:
                try:
                    idade = int(input("Idade: ").strip())
                    break
                except ValueError:
                    print("\nDigite um número válido para idade.\n")

            print()  # Espaço
            while True:
                try:
                    peso = float(input("Peso (kg): ").strip())
                    break
                except ValueError:
                    print("\nDigite um valor válido para peso.\n")

            print()  # Espaço
            sexo = ""
            while sexo not in ['M', 'F', 'O']:
                sexo = input("Sexo [M/F/O]: ").upper().strip()
                if sexo not in ['M', 'F', 'O']:
                    print("\nDigite M, F ou O.\n")

            user_data.update({'age': idade, 'weight': peso, 'gender': sexo})
            self.config.add_user('usuário', user_data)
            self.current_user = email
            self.current_user_type = 'usuário'
            print("\nCadastro de usuário concluído! ✅")
            time.sleep(1)

        else:  # especialista
            print()  # Espaço
            titulo = input("Título (ex: Dr., Dra., ou pressione Enter para pular): ").strip()
            print()  # Espaço

            specialty = input("Especialidade: ").title().strip()
            print()  # Espaço

            while True:
                try:
                    experience = int(input("Anos de experiência: ").strip())
                    break
                except ValueError:
                    print("\nDigite um número válido para anos de experiência.\n")

            print()  # Espaço
            contact = input("Contato (formato +55 61 9XXXX-XXXX): ").strip()

            user_data.update({
                'title': titulo,
                'specialty': specialty,
                'experience': experience,
                'contact': contact
            })
            self.config.add_user('especialista', user_data)
            self.current_user = email
            self.current_user_type = 'especialista'
            print("\nCadastro de especialista concluído! ✅")
            time.sleep(1)

            # Adiciona ao catálogo de especialistas
            nome_completo = f"{titulo + ' ' if titulo else ''}{name}"
            new_spec = Specialist(nome_completo, specialty, experience, contact)
            self.specialists.add_specialist(new_spec)

    def timer_menu(self):
        """
        1) Se timer NÃO ativo: exibe menu estático e bloqueia em input.
        2) Se timer ATIVO: exibe contagem em tempo real reservando linha 5 para o timer,
           enquanto o usuário pode digitar normalmente em prompt abaixo.
        """
        # Se timer já está ativo, entra no modo de controle
        if self.current_timer and self.current_timer.is_alive():
            self._start_display_thread()
            try:
                while self.current_timer.is_alive():
                    # Exibe opções na linha 6
                    sys.stdout.write("\033[6;0H")
                    sys.stdout.write("1. ⏹️  Interromper Timer\n")
                    sys.stdout.write("2. ↩️  Voltar ao Menu Principal\n")
                    sys.stdout.flush()

                    choice = input("Escolha: ").strip()
                    if choice == "1":
                        msg = self.current_timer.stop()
                        self._stop_display_thread()
                        print(f"\n{msg}\n")
                        time.sleep(1)
                        return
                    elif choice == "2":
                        self._stop_display_thread()
                        return
                    else:
                        print("\nOpção inválida! ❌\n")
                        time.sleep(1)
                        self._stop_display_thread()
                        return

                # Se o while terminou, é porque o timer acabou (is_alive()==False).
                # Neste ponto, o callback já exibiu a notificação automaticamente.
                self._stop_display_thread()
                return

            finally:
                self._stop_display_thread()

        # Se timer não está ativo, exibimos o menu para iniciar ou voltar
        while True:
            self.show_header()
            print("\n⏰ Gerenciar Timer de Atividades:\n")
            print("1. ▶️  Iniciar Novo Timer\n")
            print("2. ↩️  Voltar ao Menu Principal\n")

            choice = input("Escolha: ").strip()
            if choice == "":
                continue

            if choice == "1":
                try:
                    print()  # Espaço antes de ler duração
                    duration = int(input("Duração em minutos: ").strip())
                    # Ao criar o ActivityTimer, passamos nosso novo callback:
                    self.current_timer = ActivityTimer(duration, self.timer_completed)
                    self.current_timer.start()
                    print(f"\nTimer iniciado por {duration} minutos ⏳\n")
                    time.sleep(1)

                    # Limpa o terminal e redesenha o cabeçalho, ocultando o prompt anterior
                    with self.print_lock:
                        print("\033[2J\033[H", end='')
                    self.show_header()

                    # Agora volta ao menu de controle do timer ativo
                    return self.timer_menu()
                except ValueError:
                    print("\nValor inválido!\n")
                    time.sleep(1)
            elif choice == "2":
                return
            else:
                print("\nOpção inválida! ❌\n")
                time.sleep(1)

    def _start_display_thread(self):
        """Inicia thread para exibir o time_str na linha 5 sem interferir no input."""
        if self._display_running:
            return
        self._display_running = True

        def run_display():
            while self._display_running and self.current_timer and self.current_timer.is_alive():
                time_str = self.current_timer.time_str
                with self.print_lock:
                    sys.stdout.write("\033[s")       # Salva posição do cursor
                    sys.stdout.write("\033[5;0H")    # Move para a linha 5, coluna 0
                    sys.stdout.write(f"⏳ Tempo restante: {time_str}   ")
                    sys.stdout.write("\033[u")       # Restaura a posição do cursor
                    sys.stdout.flush()
                time.sleep(1)
            # Ao parar o timer (ou quando ele chegar a zero), limpar a linha 5
            with self.print_lock:
                sys.stdout.write("\033[5;0H")
                sys.stdout.write(" " * 50)
                sys.stdout.write("\033[5;0H")
                sys.stdout.flush()

        self._display_thread = Thread(target=run_display, daemon=True)
        self._display_thread.start()

    def _stop_display_thread(self):
        """Para a thread de exibição do timer."""
        self._display_running = False
        if self._display_thread:
            self._display_thread.join(timeout=0)
            self._display_thread = None

    def timer_completed(self):
        """
        Callback do ActivityTimer (rodando em background thread):
        assim que o timer chega a zero, exibe imediatamente a notificação
        de “Timer finalizado!” na tela, aguardando Enter.
        """
        # Primeiro, paramos a thread de exibição (se ainda estiver rodando)
        self._stop_display_thread()

        with self.print_lock:
            # Limpa toda a tela e exibe cabeçalho
            print("\033[2J\033[H", end='')
            print("═" * 50)
            print("🏋️‍♂️  EU ME AMO - Bem-Estar Integrado  🧘‍♀️")
            print("═" * 50)
            # Mensagem de timer finalizado
            print("\n\033[93m⭐ ⏰ Timer finalizado! ⭐\033[0m")
            print("\nPressione Enter para continuar.\n")
        # Aguarda o usuário pressionar Enter
        input()
        # Voltamos ao menu principal (ou aonde o usuário estiver)

    def notification_menu(self):
        while True:
            self.show_header()
            print("\n🔔 CENTRAL DE NOTIFICAÇÕES\n")
            print("1. ⚙️  Configurar Lembretes de Hidratação\n")
            print("2. ✨ Gerenciar Notificações Personalizadas\n")
            print("3. ↩️  Voltar ao Menu Principal\n")

            choice = input("Escolha: ").strip()
            if choice == "":
                continue

            if choice == "1":
                self.configure_hydration()
            elif choice == "2":
                self.manage_custom_notifications()
            elif choice == "3":
                return
            else:
                print("\nOpção inválida! ❌\n")
                time.sleep(1)

    def configure_hydration(self):
        self.show_header()
        print("\n💧 CONFIGURAR HIDRATAÇÃO\n")
        current = self.config.get_user_notifications(self.current_user)['hydration']
        print(f"Horários atuais: {current}\n")

        new_times = input("Digite novos horários (HH:MM) separados por vírgula: ").split(",")
        valid_times = [t.strip() for t in new_times if self.validate_time(t.strip())]

        self.config.update_hydration_schedule(self.current_user, valid_times)
        print("\nConfiguração de hidratação atualizada! ✅\n")
        time.sleep(1)

    def manage_custom_notifications(self):
        while True:
            self.show_header()
            print("\n✨ NOTIFICAÇÕES PERSONALIZADAS\n")
            customs = self.config.get_user_notifications(self.current_user)['custom']

            for idx, note in enumerate(customs, 1):
                print(f"{idx}. [{note['time']}] {note['name']}: {note['message']}\n")

            print("1. ➕ Criar Nova Notificação\n")
            print("2. ❌ Remover Notificação\n")
            print("3. ↩️  Voltar\n")

            choice = input("Escolha: ").strip()
            if choice == "":
                continue

            if choice == "1":
                self.create_custom_notification()
            elif choice == "2":
                self.delete_custom_notification()
            elif choice == "3":
                return
            else:
                print("\nOpção inválida! ❌\n")
                time.sleep(1)

    def create_custom_notification(self):
        self.show_header()
        print("\n🆕 NOVA NOTIFICAÇÃO PERSONALIZADA\n")

        name = input("Nome do lembrete: ").strip()
        if not name:
            print("\nNome não pode ser vazio! ❌\n")
            time.sleep(1)
            return
        print()  # Espaço

        message = input("Mensagem: ").strip()
        print()  # Espaço

        time_str = ""
        while not self.validate_time(time_str):
            time_str = input("Horário (HH:MM): ").strip()
            if not self.validate_time(time_str):
                print("\nFormato inválido! Use HH:MM\n")

        self.config.add_custom_notification(
            self.current_user,
            name,
            time_str,
            message
        )
        print("\nNotificação criada com sucesso! ✅\n")
        time.sleep(1)

    def validate_time(self, time_str):
        try:
            datetime.strptime(time_str, "%H:%M")
            return True
        except ValueError:
            return False

    def delete_custom_notification(self):
        customs = self.config.get_user_notifications(self.current_user)['custom']
        if not customs:
            print("\nNenhuma notificação para remover! ❌\n")
            time.sleep(1)
            return

        try:
            index = int(input("Número da notificação para remover: ").strip()) - 1
            if 0 <= index < len(customs):
                del self.config.notification_types['custom'][self.current_user][index]
                print("\nNotificação removida! ✅\n")
            else:
                print("\nÍndice inválido! ❌\n")
        except ValueError:
            print("\nEntrada inválida! ❌\n")

        time.sleep(1)

    def check_notifications(self):
        """
        Roda em background a cada meio segundo, checando se chegou o horário de hidratação
        ou alguma notificação personalizada. Se sim, exibe no lugar correto e aguarda 60s.
        """
        last_checked = None
        while True:
            try:
                if self.current_user:
                    current_time = datetime.now().strftime("%H:%M")
                    if current_time != last_checked:
                        last_checked = current_time
                        config = AppConfigManager()
                        user_notifs = config.get_user_notifications(self.current_user)
                        hydration_times = user_notifs['hydration']
                        custom_notifs = user_notifs['custom']

                        messages = []
                        if current_time in hydration_times:
                            messages.append(f"💧 Hora de se hidratar! ({current_time})")
                        for custom in custom_notifs:
                            if custom['time'] == current_time:
                                messages.append(f"🔔 {custom['name']}: {custom['message']}")

                        if messages:
                            with self.print_lock:
                                print("\033[2J\033[H", end='')
                                print("═" * 50)
                                print("🏋️‍♂️  EU ME AMO - Bem-Estar Integrado  🧘‍♀️")
                                print("═" * 50)
                                for msg in messages:
                                    print(f"\n\033[93m⭐ {msg} ⭐\033[0m")
                                print("\nPressione Enter para continuar.\n")
                            input()
                            time.sleep(60)
                time.sleep(0.5)
            except Exception:
                time.sleep(5)

    def show_specialists(self):
        """
        Lista os especialistas do SpecialistCatalog (iterator) e permite ver detalhes.
        """
        while True:
            self.show_header()
            print("\n🩺 Nossos Especialistas:\n")

            specialists_list = list(self.specialists)
            if not specialists_list:
                print("Nenhum especialista cadastrado.\n")
                time.sleep(1)
                return

            for idx, spec in enumerate(specialists_list, 1):
                print(f"{idx}. {spec['name']} - {spec['specialty']}\n")

            choice = input("Digite o número para detalhes ou pressione Enter para voltar: ").strip()
            if choice == "":
                return

            if choice.isdigit():
                idx = int(choice) - 1
                if 0 <= idx < len(specialists_list):
                    spec = specialists_list[idx]
                    self.show_header()
                    print(f"\n👩⚕️ Detalhes do Especialista:\n")
                    print(f"Nome: {spec['name']}\n")
                    print(f"Especialidade: {spec['specialty']}\n")
                    print(f"Experiência: {spec['experience']}\n")
                    print(f"Contato: {spec['contact']}\n")
                    input("Pressione Enter para voltar ao catálogo...\n")
                else:
                    print("\nÍndice inválido! ❌\n")
                    time.sleep(1)
            else:
                print("\nOpção inválida! ❌\n")
                time.sleep(1)

    def invalid_choice(self):
        print("\nOpção inválida! ❌\n")
        time.sleep(1)

    def exit_app(self):
        print("\nAté logo! 👋\n")
        if self.current_timer and self.current_timer.is_alive():
            self.current_timer.stop()
        self._stop_display_thread()
        exit()

if __name__ == "__main__":
    app = InteractiveApp()
    app.main_menu()
