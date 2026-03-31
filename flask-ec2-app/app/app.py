from flask import Flask, render_template, jsonify
import platform
import socket
import os
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/api/info")
def system_info():
    return jsonify({
        "hostname": socket.gethostname(),
        "platform": platform.system(),
        "python_version": platform.python_version(),
        "container_id": os.environ.get("HOSTNAME", "unknown"),
        "environment": os.environ.get("APP_ENV", "production"),
        "timestamp": datetime.utcnow().isoformat() + "Z"
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy", "uptime": "ok"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
