from flask import Flask, request, jsonify
import requests, os

app = Flask(__name__)
API_KEY = os.environ.get("OWM_API_KEY")

@app.route("/weather")
def weather():
    q = request.args.get("q")
    if not q:
        return jsonify({"error":"q param required"}), 400
    url = f"https://api.openweathermap.org/data/2.5/weather?q={q}&appid={API_KEY}&units=metric"
    r = requests.get(url)
    return (r.content, r.status_code, {"Content-Type":"application/json"})

@app.route("/health")
def health():
    return "ok", 200

if __name__=="__main__":
    app.run(host="0.0.0.0", port=5000)