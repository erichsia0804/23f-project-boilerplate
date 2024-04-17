from flask import Blueprint, request, jsonify, make_response,  current_app
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








# Put method regular:
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








# Seperate PUT for specific LanguageID
@language.route('/language/update/<int:language_id>', methods=['PUT'])
def put_specific_language(language_id):
    data = request.json

    difficulty_level = data.get('DifficultyLevel')
    name = data.get('Name')

    if not difficulty_level or not name:
        return jsonify({'error': 'Both DifficultyLevel and Name are required'}), 400

    cursor = db.get_db().cursor()
    cursor.execute('UPDATE Language SET DifficultyLevel = %s, Name = %s WHERE LanguageID = %s',
                   (difficulty_level, name, language_id))
    db.get_db().commit()

    return jsonify({'message': 'Language updated successfully'})




# Seperate PUT for specific Name
# @language.route('/language/update/<string:language_name>', methods=['PUT'])
# def put_specific_language(language_name):
#     data = request.json

#     difficulty_level = data.get('DifficultyLevel')
#     name = data.get('Name')

#     if not difficulty_level or not name:
#         return jsonify({'error': 'Both DifficultyLevel and Name are required'}), 400

#     cursor = db.get_db().cursor()
#     cursor.execute('UPDATE Language SET DifficultyLevel = %s, Name = %s WHERE Name = %s',
#                    (difficulty_level, name, language_name))
#     db.get_db().commit()

#     return jsonify({'message': 'Language updated successfully'})





# Delete Method:
@language.route('/language/<id>', methods=['DELETE'])
def delete_language(id):
    # Constructing the query
    query = '''
    DELETE FROM BABBLEBUDDIES.Language 
    WHERE LanguageID = %s
    '''
    data = (id,)

    current_app.logger.info(query)

    # Executing and committing the delete statement
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Success!'






# POST method for adding a new language record
@language.route('/language', methods=['POST'])
def add_new_language():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variables
    LanguageID = the_data['LanguageID']
    DifficultyLevel = the_data['DifficultyLevel']
    Name = the_data['Name']


    # Constructing the query
    query = 'INSERT INTO BABBLEBUDDIES.Language (LanguageID, DifficultyLevel, Name) VALUES (%s, %s, %s)'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (LanguageID, DifficultyLevel, Name))
    db.get_db().commit()

    return 'Success!'








# Second GET:
@language.route('/language/<id>', methods=['GET'])
def get_product_detail (id):

    query = 'SELECT * FROM Language WHERE LanguageID = '+ str(id)
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)




