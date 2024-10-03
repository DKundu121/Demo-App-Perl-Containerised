# Definition:

This is a test application for learning how to uise Perl.
It has a UI component and a Backend component.
The UI uses jQuerry.
The backend uses Perl.
It stores a repository of two hardcoded academic papers which we can search and retrieve.

# Configuration:

This app also uses docker compose to set up two seperate front and backend containers and nginx to set up connections between them.


# Run the application:

Navigate to the backend directory and start the Mojolicious server:
```
cd backend
perl app.pl daemon
```

For development purposes, you can use Python's built-in HTTP server to serve the frontend:

```
cd frontend
python -m http.server 8000
```