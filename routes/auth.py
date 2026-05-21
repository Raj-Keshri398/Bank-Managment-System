from flask import Blueprint, flash, redirect, render_template, request, url_for


auth_bp = Blueprint("auth", __name__)


@auth_bp.route("/login", methods=["GET", "POST"])
def login():
    """Render login form and handle basic validation."""
    if request.method == "POST":
        username = request.form.get("username", "").strip()
        password = request.form.get("password", "")

        if not username or not password:
            flash("Username and password are required.", "error")
            return render_template("auth/login.html", username=username)

        # Placeholder auth flow until DB auth is added.
        flash(f"Welcome back, {username}!", "success")
        return redirect(url_for("account.accounts"))

    return render_template("auth/login.html")


@auth_bp.route("/register", methods=["GET", "POST"])
def register():
    """Render register form and handle basic validation."""
    if request.method == "POST":
        username = request.form.get("username", "").strip()
        email = request.form.get("email", "").strip().lower()
        password = request.form.get("password", "")

        if not username or not email or not password:
            flash("All fields are required.", "error")
            return render_template(
                "auth/register.html",
                form_data={"username": username, "email": email},
            )

        if len(password) < 6:
            flash("Password must be at least 6 characters.", "error")
            return render_template(
                "auth/register.html",
                form_data={"username": username, "email": email},
            )

        # Placeholder register flow until DB insert is added.
        flash("Registration successful. Please login.", "success")
        return redirect(url_for("auth.login"))

    return render_template("auth/register.html")
