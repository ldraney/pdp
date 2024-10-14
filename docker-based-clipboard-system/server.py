import zmq
import subprocess
import os

context = zmq.Context()
socket = context.socket(zmq.REP)
socket.bind("tcp://*:5555")

HOST_OS = os.environ.get("HOST_OS", "linux")

def set_clipboard(text):
    if HOST_OS == "linux":
        subprocess.run(["xclip", "-selection", "clipboard"], input=text.encode(), check=True)
    else:
        subprocess.run(["clip.exe"], input=text.encode(), check=True)

def get_clipboard():
    if HOST_OS == "linux":
        return subprocess.check_output(["xclip", "-selection", "clipboard", "-o"]).decode()
    else:
        return subprocess.check_output(["powershell.exe", "-command", "Get-Clipboard"]).decode()

while True:
    message = socket.recv_json()
    if message["action"] == "set":
        set_clipboard(message["text"])
        socket.send_string("OK")
    elif message["action"] == "get":
        text = get_clipboard()
        socket.send_string(text)
