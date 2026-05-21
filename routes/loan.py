from flask import Blueprint


loan_bp = Blueprint("loan", __name__)


@loan_bp.route("/loan")
@loan_bp.route("/loans")
def loan():
    return "Loan page is under development."
