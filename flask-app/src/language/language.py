from flask import Blueprint, request, jsonify, make_response
import json
from src import db


language = Blueprint('language', __name__)


# Get all languages from the DB
@language.route('/language', methods=['GET'])
def get_customers():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Language')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    return jsonify(json_data)




























# # Get customer detail for customer with particular userID
# @customers.route('/customers/<userID>', methods=['GET'])
# def get_customer(userID):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from customers where id = {0}'.format(userID))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response