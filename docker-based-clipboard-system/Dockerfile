FROM python:3.9-slim

WORKDIR /app

COPY server.py .

RUN pip install pyzmq

CMD ["python", "server.py"]

