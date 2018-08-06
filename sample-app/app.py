# Import framework
from flask import Flask
from flask_restful import Resource, Api
from time import sleep
import random

# Instantiate the app
app = Flask(__name__)
api = Api(app)


class RandomDelayRange1(Resource):
    def get(self):
        delay = random.randrange(1, 10) / 10
        sleep(delay)

        return {
            'delay': delay,
            'result': ['Success']
        }


# Create routes
api.add_resource(RandomDelayRange1, '/delayRange1')

# Run the application
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80, debug=True)