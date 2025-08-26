FROM python:3.11
WORKDIR /app
RUN apt-get update && apt-get install -y git
COPY . .
RUN pip install flask
CMD ["python", "main.py"]
from flask import Flask, request, jsonify
import subprocess, uuid
app = Flask(__name__)

@app.route("/chat", methods=["POST"])
def chat():
    data = request.json
    temp = f"/tmp/{uuid.uuid4()}"
    subprocess.run(["git", "clone", data["repo"], temp])
    subprocess.run(["echo", data["prompt"], ">", f"{temp}/prompt.txt"])
    subprocess.run(["git", "push", "origin", "staging"], cwd=temp)
    return jsonify({"ok": True})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
