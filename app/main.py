from flask import Flask

app = Flask(__name__)

@app.get("/")
def home():
    return {"status": "ok", "message": "Hello from Docker on GitHub!"}

if __name__ == "__main__":
    # Bind to 0.0.0.0 so Docker can expose the port
    app.run(host="0.0.0.0", port=8000)

