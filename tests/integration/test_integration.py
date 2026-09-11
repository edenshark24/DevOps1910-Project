import requests
import os

BASE_URL = os.getenv('APP_URL', 'http://localhost:5000')

def test_app_is_reachable():
    response = requests.get(BASE_URL)
    assert response.status_code == 200

def test_app_returns_correct_message():
    response = requests.get(BASE_URL)
    assert 'Hello, World!' in response.text

def test_response_time_is_acceptable():
    response = requests.get(BASE_URL)
    assert response.elapsed.total_seconds() < 2.0
