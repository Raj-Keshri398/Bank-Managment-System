from flask import Blueprint

account_bp=Blueprint(
"account",
__name__
)

# Account list
@account_bp.route(
"/accounts"
)

def accounts():

    return "Accounts Page"