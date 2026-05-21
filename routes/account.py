from flask import Blueprint


account_bp = Blueprint("account", __name__)


@account_bp.route("/accounts")
def accounts():
    return "Accounts page is under development."
