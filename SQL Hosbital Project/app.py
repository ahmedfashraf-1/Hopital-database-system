from flask import Flask, jsonify, request, render_template
import mysql.connector
from mysql.connector import Error
from datetime import datetime
import json
from flask_cors import CORS
app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Database configuration
db_config = {
    'host': 'localhost',
    'database': 'HospitalSystem',
    'user': 'root',
    'password': '1234'
}

def get_db_connection():
    try:
        connection = mysql.connector.connect(**db_config)
        return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/tables')
def get_tables():
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor()
        cursor.execute("SHOW TABLES")
        tables = [table[0] for table in cursor.fetchall()]
        cursor.close()
        connection.close()
        return jsonify(tables)
    return jsonify([])

@app.route('/api/table/<table_name>')
def get_table_data(table_name):
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor(dictionary=True)
        try:
            # Use backticks for table names to handle reserved words
            cursor.execute(f"SELECT * FROM `{table_name}`")
            data = cursor.fetchall()
            
            # Get column names from the first row keys
            if data and len(data) > 0:
                columns = list(data[0].keys())
            else:
                # If no data, use DESCRIBE as fallback
                cursor.execute(f"DESCRIBE `{table_name}`")
                describe_result = cursor.fetchall()
                if describe_result and len(describe_result) > 0:
                    if isinstance(describe_result[0], dict):
                        columns = [column['Field'] for column in describe_result]
                    else:
                        columns = [column[0] for column in describe_result]
                else:
                    columns = []
            
            cursor.close()
            connection.close()
            return jsonify({'data': data, 'columns': columns})
        except Error as e:
            print(f"Database error: {str(e)}")
            return jsonify({'error': str(e)})
    return jsonify({'error': 'Database connection failed'})

@app.route('/api/structure/<table_name>')
def get_table_structure(table_name):
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor(dictionary=True)
        try:
            cursor.execute(f"DESCRIBE `{table_name}`")
            structure = cursor.fetchall()
            
            cursor.close()
            connection.close()
            return jsonify({'structure': structure})
        except Error as e:
            return jsonify({'error': str(e)})
    return jsonify({'error': 'Database connection failed'})

@app.route('/api/insert/<table_name>', methods=['POST'])
def insert_data(table_name):
    data = request.json
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor()
        try:
            # Get table structure to validate data types
            cursor.execute(f"DESCRIBE `{table_name}`")
            table_structure = cursor.fetchall()
            
            # Prepare validated data
            validated_data = {}
            for column in table_structure:
                col_name = column[0]  # Column name
                col_type = column[1]  # Column type
                
                if col_name in data:
                    # Convert values based on column type
                    if 'int' in col_type.lower():
                        validated_data[col_name] = int(data[col_name]) if data[col_name] not in ['', None] else None
                    elif 'decimal' in col_type.lower() or 'float' in col_type.lower() or 'double' in col_type.lower():
                        validated_data[col_name] = float(data[col_name]) if data[col_name] not in ['', None] else None
                    else:
                        validated_data[col_name] = data[col_name]
            
            columns = ', '.join([f"`{key}`" for key in validated_data.keys()])
            placeholders = ', '.join(['%s'] * len(validated_data))
            values = list(validated_data.values())
            
            query = f"INSERT INTO `{table_name}` ({columns}) VALUES ({placeholders})"
            cursor.execute(query, values)
            connection.commit()
            
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Record inserted successfully'})
        except Error as e:
            print(f"Database error: {str(e)}")
            return jsonify({'error': str(e)})
        except ValueError as e:
            print(f"Value error: {str(e)}")
            return jsonify({'error': f"Invalid data format: {str(e)}"})
    return jsonify({'error': 'Database connection failed'})

@app.route('/api/update/<table_name>/<id_value>', methods=['POST'])
def update_data(table_name, id_value):
    data = request.json
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor()
        try:
            # Find the primary key column
            cursor.execute(f"SHOW KEYS FROM `{table_name}` WHERE Key_name = 'PRIMARY'")
            result = cursor.fetchone()
            primary_key = result[4] if result else 'id'
            
            # Get table structure to validate data types
            cursor.execute(f"DESCRIBE `{table_name}`")
            table_structure = cursor.fetchall()
            
            # Prepare validated data
            validated_data = {}
            for column in table_structure:
                col_name = column[0]  # Column name
                col_type = column[1]  # Column type
                
                if col_name in data and col_name != primary_key:
                    # Convert values based on column type
                    if 'int' in col_type.lower():
                        validated_data[col_name] = int(data[col_name]) if data[col_name] not in ['', None] else None
                    elif 'decimal' in col_type.lower() or 'float' in col_type.lower() or 'double' in col_type.lower():
                        validated_data[col_name] = float(data[col_name]) if data[col_name] not in ['', None] else None
                    else:
                        validated_data[col_name] = data[col_name]
            
            set_clause = ', '.join([f"`{key}`=%s" for key in validated_data.keys()])
            values = list(validated_data.values())
            values.append(id_value)
            
            query = f"UPDATE `{table_name}` SET {set_clause} WHERE `{primary_key}`=%s"
            cursor.execute(query, values)
            connection.commit()
            
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Record updated successfully'})
        except Error as e:
            return jsonify({'error': str(e)})
    return jsonify({'error': 'Database connection failed'})

@app.route('/api/delete/<table_name>/<id_value>', methods=['DELETE'])
def delete_data(table_name, id_value):
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor()
        try:
            # Find the primary key column
            cursor.execute(f"SHOW KEYS FROM `{table_name}` WHERE Key_name = 'PRIMARY'")
            result = cursor.fetchone()
            primary_key = result[4] if result else 'id'
            
            query = f"DELETE FROM `{table_name}` WHERE `{primary_key}`=%s"
            cursor.execute(query, (id_value,))
            connection.commit()
            
            cursor.close()
            connection.close()
            return jsonify({'success': True, 'message': 'Record deleted successfully'})
        except Error as e:
            return jsonify({'error': str(e)})
    return jsonify({'error': 'Database connection failed'})

# Test endpoints
@app.route('/api/test-connection')
def test_connection():
    connection = get_db_connection()
    if connection:
        connection.close()
        return jsonify({'success': True, 'message': 'Database connection successful'})
    return jsonify({'error': 'Database connection failed'})

@app.route('/api/test-data')
def test_data():
    connection = get_db_connection()
    if connection:
        cursor = connection.cursor(dictionary=True)
        
        # Check various tables
        tables_to_check = ['Patient', 'Appointment', 'Provider', 'Encounter']
        results = {}
        
        for table in tables_to_check:
            try:
                cursor.execute(f"SELECT COUNT(*) as count FROM `{table}`")
                result = cursor.fetchone()
                results[table] = result['count']
            except Error as e:
                results[table] = f"Error: {str(e)}"
        
        cursor.close()
        connection.close()
        return jsonify(results)
    return jsonify({'error': 'Database connection failed'})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)