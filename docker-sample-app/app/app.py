# Import framework
from flask import Flask, request, url_for, jsonify, Response, abort
from flask_restful import Resource, Api
import logging 
from flask.logging import default_handler

from datetime import datetime, time, date
from time import sleep
import random

# Instantiate the app
app = Flask(__name__)
api = Api(app)
auth = False

class RequestFormatter(logging.Formatter):
    def format(self, record):
        record.url = request.url
        record.remote_addr = request.remote_addr
        return super().format(record)

formatter = RequestFormatter(
    '[%(asctime)s] %(remote_addr)s requested %(url)s\n'
    '%(levelname)s in %(module)s: %(message)s'
)

default_handler.setFormatter(formatter)

def random_delay(min_ms=0, max_ms=1000):
    '''
    Sleep function to halt parent thread of a request which will be handled
    using the sample application. Default: sleep between 0 and 1 seconds.

    min_ms minimum number of miliseconds to sleep
    max_ms maximum number of miliseconds to sleep
    '''

    delay = random.randrange(min_ms, max_ms)
    sleep(delay / 1000)
    return delay

class AuthService():
    def token(self):
        token = hash(time.min)
        app.logger.info('Token generated %s', token)
        return token

    def validate(self):
        # Do we need to authenticate?
        if (False == auth):
            return True

        valid_token = hash(time.min)

        # Check if auth header is set in the request
        if 'Authorization' not in request.headers:
            abort(401)

        token = request.headers.get('Authorization')
        app.logger.info('Valid Token: "%s"', valid_token)
        app.logger.info('Received Token: "%s"', token)

        if str(token) != str(valid_token):
            abort(401)

class Auth(Resource):
    def get(self):
        auth = AuthService()

        return {
            'token': auth.token(),
            'result': ['success']
        }

class Delay(Resource):
    def get(self, min, max):
        auth = AuthService()
        auth.validate()

        return {
            'delay': random_delay(min, max),
            'result': ['success']
        }

# Create routes
api.add_resource(Auth, '/auth')
api.add_resource(Delay, '/delay/<int:min>/<int:max>')

# Run the application
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)