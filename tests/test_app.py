import sys
import os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'Docker'))

from app import app

def test_hello_route_exists():
    client = app.test_client()
    response = client.get('/')
    assert response.status_code == 200

def test_hello_returns_correct_message():
    client = app.test_client()
    response = client.get('/')
    assert b'Hello, World!' in response.data

def test_unknown_route_returns_404():
    client = app.test_client()
    response = client.get('/nonexistent')
    assert response.status_code == 404
