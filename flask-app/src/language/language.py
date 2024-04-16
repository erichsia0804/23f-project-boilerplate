from flask import Blueprint, current_app, request, jsonify, make_response
import json
from src import db


language = Blueprint('language', __name__)


# Get all languages from the DB
@language.route('/language', methods=['GET'])
def get_language():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Language')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    return jsonify(json_data)






@language.route('/language', methods = ['PUT'])
def put_language():
      # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    LanguageID = the_data['LanguageID']
    DifficultyLevel = the_data['DifficultyLevel']
    Name = the_data['Name']
    # id = the_data['id']
    # company = the_data['company']
    # last_name = the_data['last_name']
    # first_name = the_data['first_name']
    # job_title = the_data['job_title']
    # business_phone = the_data['business_phone']

    # Constructing the query
    query = '''
    UPDATE Language 
    SET DifficultyLevel=%s, Name=%s
    WHERE LanguageID = %s
    '''
    data = (DifficultyLevel, Name, LanguageID)

    current_app.logger.info(query)
   
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    return 'Success!'


# @language.route('/language/<int:language_id>', methods=['DELETE'])
# def delete_language(language_id):
#     # Constructing the query
#     query = '''
#     DELETE FROM Language 
#     WHERE LanguageID = %s
#     '''
#     data = (language_id,)

#     current_app.logger.info(query)

#     # executing and committing the delete statement
#     cursor = db.get_db().cursor()
#     cursor.execute(query, data)
#     db.get_db().commit()

#     return 'Language deleted successfully!'





@language.route('/language', methods = ['DELETE'])
def delete_language():
      # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    LanguageID = the_data['LanguageID']
    DifficultyLevel = the_data['DifficultyLevel']
    Name = the_data['Name']

    # Constructing the query
    query = '''
    DELETE FROM Language 
    WHERE LanguageID = %s
    '''
    data = (DifficultyLevel, Name, LanguageID)

    current_app.logger.info(query)
   
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    return 'Language deleted successfully!'









