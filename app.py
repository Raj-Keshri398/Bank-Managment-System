from flask import Flask
from flask_mysqldb import MySQL

from config import Config

# Flask app create
app = Flask(__name__)

# Load config
app.config.from_object(Config)

# MySQL connect
mysql = MySQL(app)

# Import routes
from routes.auth import auth_bp
from routes.account import account_bp
from routes.transaction import transaction_bp
from routes.loan import loan_bp

# Register routes
app.register_blueprint(auth_bp)

app.register_blueprint(account_bp)

app.register_blueprint(transaction_bp)

app.register_blueprint(loan_bp)


@app.route("/")
def home():

    return "Bank Management System Running"


if __name__=="__main__":

    app.run(
        debug=True
    )