# Auth service demo

## Overview

Authentication service demo-app.

## Capabilities

The app can be deployed as a service with the following capabilities:

- api for authentication with user & pass credentials. Returns a JWT for a valid signin
- supports user CRUD operations
- implements OAuth2 standard
- supports 3rd party authentication as an alternative to login with credentials.
- provides authentication public key as API endpoint to allow token validation for other services/users

## Framework (overview)

Uses FastAPI to serve requests.
Uses PostgreSQL for data storage.
USes Docker as the containerization tool.