import requests
import sqlite3
import pandas as pd
from flask import Flask, request, jsonify

app = Flask(__name__)

# Connexion à la base de données
DB_NAME = "brvm.db"

def get_recommendation(ticker):
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT prix_cible, dividende, rendement FROM recommendations WHERE ticker = ?", (ticker,))
    rec = cursor.fetchone()
    conn.close()
    
    if rec:
        return {
            "ticker": ticker,
            "prix_cible": rec[0],
            "dividende": rec[1],
            "rendement": rec[2],
            "conseil": "Acheter" if rec[2] > 8 else "Conserver"
        }
    return {"message": "Aucune recommandation trouvée"}

@app.route("/chat", methods=["POST"])
def chat():
    user_input = request.json.get("message", "").lower()
    
    if "recommendation" in user_input or "acheter" in user_input:
        ticker = user_input.split()[-1].upper()
        return jsonify(get_recommendation(ticker))
    
    return jsonify({"message": "Je ne comprends pas votre requête. Essayez 'Quelle est la recommandation pour Nestlé CI ?'"})

if __name__ == "__main__":
    app.run(debug=True)
