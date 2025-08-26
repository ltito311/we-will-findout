FROM python:3.11
WORKDIR /app
RUN apt-get update && apt-get install -y git
COPY . .
RUN pip install flask
CMD ["python", "main.py"]
