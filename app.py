from flask import Flask, jsonify, render_template_string
import random

app = Flask(__name__)

TEMPLATE = """
<!doctype html>
<title>Auto-Redeploy Demo</title>
<h1>Welcome to Flask Auto-Redeploy Demo! It is Redeployed!!!</h1>
<h1>We did it!!!</h1>
<p>Random number: {{ rand }}</p>
"""

@app.route("/")
def index():
    rand = random.randint(1, 20)
    if rand == 13:
        # simulate internal error
        return "Simulated Internal Server Error", 500
    return render_template_string(TEMPLATE, rand=rand)

@app.route("/health")
def health():
    rand = random.randint(1, 40)
    if rand == 7:
        return jsonify(status="unhealthy"), 500
    return jsonify(status="ok"), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
