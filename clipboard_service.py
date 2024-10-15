import subprocess
import socket
import os
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')

def set_clipboard(text):
    host_os = os.environ.get('HOST_OS', 'linux')
    logging.info(f"Attempting to set clipboard on {host_os} system")
    
    if host_os == 'linux':
        try:
            subprocess.run(["xsel", "-i", "-b"], input=text.encode(), check=True)
            logging.info("Successfully set clipboard using xsel")
        except subprocess.CalledProcessError as e:
            logging.error(f"Failed to set clipboard: {e}")
        except FileNotFoundError:
            logging.error("xsel not found. Make sure it's installed in the container.")
    else:
        logging.warning(f"Clipboard setting not implemented for {host_os}")

def get_clipboard():
    host_os = os.environ.get('HOST_OS', 'linux')
    logging.info(f"Attempting to get clipboard content on {host_os} system")
    
    if host_os == 'linux':
        try:
            result = subprocess.run(["xsel", "-o", "-b"], capture_output=True, text=True, check=True)
            logging.info("Successfully got clipboard content using xsel")
            return result.stdout
        except subprocess.CalledProcessError as e:
            logging.error(f"Failed to get clipboard content: {e}")
        except FileNotFoundError:
            logging.error("xsel not found. Make sure it's installed in the container.")
    else:
        logging.warning(f"Clipboard getting not implemented for {host_os}")
    return ""

def start_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        server.bind(('0.0.0.0', 12345))
        server.listen(1)
        logging.info("Clipboard service listening on 0.0.0.0:12345")

        while True:
            logging.info("Waiting for a connection...")
            client, addr = server.accept()
            logging.info(f"Accepted connection from {addr}")
            
            data = client.recv(1024).decode()
            if data:
                if data.strip().lower() == "get":
                    clipboard_content = get_clipboard()
                    client.send(clipboard_content.encode())
                    logging.info(f"Sent clipboard content: {clipboard_content[:20]}...")
                else:
                    logging.info(f"Received data to set: {data[:20]}...")
                    set_clipboard(data)
            else:
                logging.warning("Received empty data")
            
            client.close()
            logging.info("Closed client connection")
    
    except Exception as e:
        logging.error(f"An error occurred: {e}")
    finally:
        server.close()
        logging.info("Server shut down")

if __name__ == "__main__":
    logging.info("Starting clipboard service")
    start_server()
