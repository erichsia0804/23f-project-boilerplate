from flask import Blueprint, app, current_app, request, jsonify, make_response
import json
from src import db


people = Blueprint('people', __name__)


# Get all languages from the DB
@people.route('/student', methods=['GET'])
def get_student():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Student')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    return jsonify(json_data)


@people.route('/student', methods = ['PUT'])
def put_student():
      # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    StudentID = the_data['StudentID']
    Grades = the_data['Grades']
    Name = the_data['Name']
    Age = the_data['Age']
    Email = the_data['Email']
    CountryOfOrigin = the_data['CountryOfOrigin']
    NativeLanguage = the_data['NativeLanguage']

    # Constructing the query
    query = '''
    UPDATE Student 
    SET Grades=%s, Name=%s, Age=%s, Email=%s, CountryOfOrigin=%s, NativeLanguage=%s
    WHERE StudentID = %s
    '''
    data = (Grades, Name, Age, Email, CountryOfOrigin, NativeLanguage, StudentID)

    current_app.logger.info(query)
   
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    return 'Success!'



# Get all languages from the DB
@people.route('/teacher', methods=['GET'])
def get_teacher():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Teacher')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    return jsonify(json_data)



@people.route('/teacher', methods = ['PUT'])
def put_teacher():
      # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    TeacherID = the_data['TeacherID']
    Name = the_data['Name']
    Age = the_data['Age']
    Email = the_data['Email']
    Education = the_data['Education']
    Salary = the_data['Salary']
    NativeLanguage = the_data['NativeLanguage']

    # Constructing the query
    query = '''
    UPDATE Teacher 
    SET Name=%s, Age=%s, Email=%s, Education=%s, Salary=%s, NativeLanguage=%s
    WHERE TeacherID = %s
    '''
    data = (Name, Age, Email, Education, Salary, NativeLanguage, TeacherID)

    current_app.logger.info(query)
   
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    return 'Success!'





@people.route('/traveler', methods=['GET'])
def get_traveler():
    cursor = db.get_db().cursor()
    cursor.execute('SELECT * FROM Traveler')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))

    return jsonify(json_data)



@people.route('/traveler', methods = ['PUT'])
def put_traveler():
      # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    TravelerID = the_data['TravelerID']
    Name = the_data['Name']
    Age = the_data['Age']
    Email = the_data['Email']
    CountryOfOrigin = the_data['CountryOfOrigin']
    NativeLanguage = the_data['NativeLanguage']

    # Constructing the query
    query = '''
    UPDATE Traveler 
    SET Name=%s, Age=%s, Email=%s, CountryOfOrigin=%s, NativeLanguage=%s
    WHERE TravelerID = %s
    '''
    data = (Name, Age, Email, CountryOfOrigin, NativeLanguage, TravelerID)

    current_app.logger.info(query)
   
    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()
    
    return 'Success!'



# POST method for adding a new traveler record
@people.route('/traveler', methods=['POST'])
def add_new_traveler():

# collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variables
    TravelerID = the_data['TravelerID']
    Name = the_data['Name']
    Age = the_data['Age']
    Email = the_data['Email']
    CountryOfOrigin = the_data['CountryOfOrigin']
    NativeLanguage = the_data['NativeLanguage']


    # Constructing the query
    query = 'INSERT INTO BABBLEBUDDIES.Traveler (TravelerID, Name, Age, Email, CountryOfOrigin, NativeLanguage) VALUES (%s, %s, %s, %s, %s, %s)'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query, (TravelerID, Name, Age, Email, CountryOfOrigin, NativeLanguage))
    db.get_db().commit()

    return 'Success!'



#delete traveler
@people.route('/traveler/<id>', methods=['DELETE'])
def delete_traveler(id):
    # Constructing the query
    query = '''
    DELETE FROM BABBLEBUDDIES.Traveler 
    WHERE TravelerID = %s
    '''
    data = (id,)

    current_app.logger.info(query)

    # executing and committing the delete statement
    cursor = db.get_db().cursor()
    cursor.execute(query, data)
    db.get_db().commit()

    return 'Success!'