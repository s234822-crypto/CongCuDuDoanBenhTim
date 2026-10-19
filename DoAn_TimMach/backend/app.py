"""
Vercel/WSGI entry point.

The legacy Flask app in this file did not include authentication routes and
tried to render a template that is not part of the Vercel deployment. Export
the current API application instead so Vercel serves the routes in api.py.
"""

from api import app

if __name__ == "__main__":
    import os

    app.run(
        host="0.0.0.0",
        port=int(os.environ.get("PORT", "5001")),
        debug=False,
    )
