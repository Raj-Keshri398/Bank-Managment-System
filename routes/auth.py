from flask import Blueprint
from flask import render_template
from flask import request
from flask import redirect

auth_bp = Blueprint(
    "auth",
    __name__
)

# Login page
@auth_bp.route("/login")

def login():

    return render_template(
        "auth/login.html"
    )


# Register page
@auth_bp.route(
"/register",
methods=["GET","POST"]
)

def register():

    if request.method=="POST":

        username=request.form["username"]

        email=request.form["email"]

        password=request.form["password"]

        print(username)

        print(email)

        print(password)

        return redirect(
            "/login"
        )

    return render_template(
        "auth/register.html"
    )