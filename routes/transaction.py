from flask import Blueprint

transaction_bp = Blueprint(
    "transaction",
    __name__
)

@transaction_bp.route(
    "/transactions"
)

def transactions():

    return "Transactions Page"