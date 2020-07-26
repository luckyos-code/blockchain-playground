import coin
from coin import api
from flask import Flask


if __name__ == "__main__":
    app = Flask(__name__)
    app.config['JSONIFY_PRETTYPRINT_REGULAR'] = False
    
    app.register_blueprint(api)
    
    app.run(host = '0.0.0.0', port = 5003)