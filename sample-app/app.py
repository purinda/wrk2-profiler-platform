# Import framework
from flask import Flask
from flask_restful import Resource, Api
import time
import random

# Instantiate the app
app = Flask(__name__)
api = Api(app)

def random_delay(min_ms=0, max_ms=1000):
    '''
    Sleep function to halt parent thread of a request which will be handled
    using the sample application. Default: sleep between 0 and 1 seconds.

    min_ms minimum number of miliseconds to sleep
    max_ms maximum number of miliseconds to sleep
    '''

    delay = random.randrange(min_ms, max_ms)
    time.sleep(delay / 1000)
    return delay

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
        return {
            'delay': random_delay(500, 1500),
            'result': ['success']
        }

class RandomDelayRange2(Resource):
    def get(self):
        return {
            'delay': random_delay(1000, 2500),
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