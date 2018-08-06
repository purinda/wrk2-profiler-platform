# Import framework
from flask import Flask
from flask_restful import Resource, Api
import time
import random

# Instantiate the app
app = Flask(__name__)
api = Api(app)

class Auth(Resource):
    def get(self):
        return {
            'token': hash(time.time()),
            'result': ['success']
        }

class AlmostNoDelay(Resource):
    def get(self):
        return {
            'result': ['success']
        }

class RandomDelayRange1(Resource):
    def get(self):
        delay = random.randrange(1, 10) / 10
        time.sleep(delay)

        return {
            'delay': delay,
            'result': ['success']
        }

class RandomDelayRange2(Resource):
    def get(self):
        delay = random.randrange(9, 10) / 10
        time.sleep(delay)

        return {
            'delay': delay,
            'result': ['success']
        }

# Create routes
api.add_resource(Auth, '/auth')
api.add_resource(AlmostNoDelay, '/noDelay')
api.add_resource(RandomDelayRange1, '/delayRange1')
api.add_resource(RandomDelayRange2, '/delayRange2')

# Run the application
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)