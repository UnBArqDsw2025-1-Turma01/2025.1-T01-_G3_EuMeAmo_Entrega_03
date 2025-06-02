from threading import Thread
import time

class ActivityTimer(Thread):
    def __init__(self, duration, callback):
        super().__init__(daemon=True)
        self.duration = duration * 60  # Convertendo para segundos
        self.callback = callback
        self.running = False
        self.time_str = "00:00"

    def run(self):
        self.running = True
        for remaining in range(self.duration, 0, -1):
            if not self.running:
                return
            mins, secs = divmod(remaining, 60)
            self.time_str = f"{mins:02d}:{secs:02d}"
            time.sleep(1)
        self.callback()

    def stop(self):
        self.running = False
        return "Timer interrompido! ⏹️"

    def get_progress(self):
        return self.time_str