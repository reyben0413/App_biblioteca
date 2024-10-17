from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
from functools import wraps

app = Flask(__name__)
app.secret_key = '.#1005257L1nk@'

# Configuración de la base de datos MySQL
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'UserTest'
app.config['MYSQL_PASSWORD'] = 'LSCTvqAinQ2wcAZ'
app.config['MYSQL_DB'] = 'biblioteca'

mysql = MySQL(app)

def requiere_autenticacion(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if 'usuario_id' not in session:  # Verifica si la sesión está activa
            return redirect(url_for('index'))  # Redirige al inicio de sesión
        return f(*args, **kwargs)
    return wrapper

# Ruta para el inicio de sesión
@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        email = request.form['email']
        contraseña = request.form['contraseña']
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM usuarios WHERE email = %s AND contraseña = %s", (email, contraseña))
        usuario = cur.fetchone()
        cur.close()

        if usuario:
            session['usuario_id'] = usuario[0]
            session['nombre'] = usuario[1]
            return redirect(url_for('menu'))
        else:
            flash('Credenciales incorrectas. Inténtalo de nuevo.')

    return render_template('index.html')

# Ruta para el menú principal
@app.route('/menu')
@requiere_autenticacion
def menu():
    return render_template('menu.html')

# Ruta para cerrar sesión
@app.route('/logout')
def logout():
    session.clear()  # Limpiar todas las variables de sesión
    flash('Has cerrado sesión exitosamente', 'success')  # Mensaje de éxito
    return redirect(url_for('index'))  # Redirigir al inicio de sesión

# Ruta para añadir categoría
@app.route('/add_category', methods=['GET', 'POST'])
@requiere_autenticacion
def add_category():
    if request.method == 'POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        cursor = mysql.connection.cursor()
        cursor.execute('INSERT INTO categorias (nombre, descripcion) VALUES (%s, %s)', (nombre, descripcion))
        mysql.connection.commit()
        flash('Categoría añadida exitosamente', 'success')
        return redirect(url_for('menu'))
    return render_template('add_category.html')

# Ruta para listar categorías
@app.route('/list_categories')
@requiere_autenticacion
def list_categories():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM categorias')
    categorias = cursor.fetchall()
    return render_template('list_categories.html', categorias=categorias)

# Ruta para editar categoría
@app.route('/edit_category/<int:id>', methods=['GET', 'POST'])
@requiere_autenticacion
def edit_category(id):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    if request.method == 'POST':
        nombre = request.form['nombre']
        descripcion = request.form['descripcion']
        cursor.execute('UPDATE categorias SET nombre = %s, descripcion = %s WHERE id = %s', (nombre, descripcion, id))
        mysql.connection.commit()
        flash('Categoría actualizada exitosamente', 'success')
        return redirect(url_for('list_categories'))

    cursor.execute('SELECT * FROM categorias WHERE id = %s', (id,))
    categoria = cursor.fetchone()
    return render_template('edit_category.html', categoria=categoria)

# Ruta para eliminar categoría
@app.route('/delete_category/<int:id>')
@requiere_autenticacion
def delete_category(id):
    cursor = mysql.connection.cursor()
    cursor.execute('DELETE FROM categorias WHERE id = %s', (id,))
    mysql.connection.commit()
    flash('Categoría eliminada exitosamente', 'success')
    return redirect(url_for('list_categories'))

# Ruta para añadir libro
@app.route('/add_book', methods=['GET', 'POST'])
@requiere_autenticacion
def add_book():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM categorias')
    categorias = cursor.fetchall()
    
    if request.method == 'POST':
        titulo = request.form['titulo']
        autor = request.form['autor']
        isbn = request.form['isbn']
        año = request.form['año']
        descripcion = request.form['descripcion']
        id_categoria = request.form['id_categoria']
        imagen_url = request.form['imagen_url']

        cursor.execute('INSERT INTO libros (titulo, autor, isbn, año, descripcion, id_categoria, imagen_url) VALUES (%s, %s, %s, %s, %s, %s, %s)', 
                       (titulo, autor, isbn, año, descripcion, id_categoria, imagen_url))
        mysql.connection.commit()
        flash('Libro añadido exitosamente', 'success')
        return redirect(url_for('menu'))

    return render_template('add_book.html', categorias=categorias)

# Ruta para listar libros
@app.route('/list_books')
@requiere_autenticacion
def list_books():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT libros.*, categorias.nombre AS categoria_nombre FROM libros JOIN categorias ON libros.id_categoria = categorias.id')
    libros = cursor.fetchall()
    return render_template('list_books.html', libros=libros)

# Ruta para editar libro
@app.route('/edit_book/<int:id>', methods=['GET', 'POST'])
@requiere_autenticacion
def edit_book(id):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM categorias')
    categorias = cursor.fetchall()

    if request.method == 'POST':
        titulo = request.form['titulo']
        autor = request.form['autor']
        isbn = request.form['isbn']
        año = request.form['año']
        descripcion = request.form['descripcion']
        id_categoria = request.form['id_categoria']
        imagen_url = request.form['imagen_url']

        cursor.execute('UPDATE libros SET titulo = %s, autor = %s, isbn = %s, año = %s, descripcion = %s, id_categoria = %s, imagen_url = %s WHERE id = %s',
                       (titulo, autor, isbn, año, descripcion, id_categoria, imagen_url, id))
        mysql.connection.commit()
        flash('Libro actualizado exitosamente', 'success')
        return redirect(url_for('list_books'))

    cursor.execute('SELECT * FROM libros WHERE id = %s', (id,))
    libro = cursor.fetchone()
    return render_template('edit_book.html', libro=libro, categorias=categorias)

# Ruta para eliminar libro con confirmación
@app.route('/delete_book/<int:id>')
@requiere_autenticacion
def delete_book(id):
    cursor = mysql.connection.cursor()
    cursor.execute('DELETE FROM libros WHERE id = %s', (id,))
    mysql.connection.commit()
    flash('Libro eliminado exitosamente', 'success')
    return redirect(url_for('list_books'))


if __name__ == '__main__':
    app.run(port=5000, debug=True)
