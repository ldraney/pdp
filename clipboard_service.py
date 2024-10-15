import subprocess
import socket
import os

def set_clipboard(text):
    if os.environ.get('HOST_OS', 'linux') == 'linux':
        subprocess.run(["xclip", "-selection", "clipboard"], input=text.encode(), check=True)
    else:
        # For Windows, we'd need to use a different method, possibly WSL or a Windows-based image
        pass

def start_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind(('0.0.0.0', 12345))
    server.listen(1)

    print("Clipboard service listening on port 12345")

    while True:
        client, addr = server.accept()
        data = client.recv(1024).decode()
        if data:
            set_clipboard(data)
        client.close()

if __name__ == "__main__":
    start_server()
