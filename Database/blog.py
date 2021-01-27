from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort

from Database.auth import login_required
from Database.db import get_db

bp = Blueprint('blog', __name__)

@bp.route('/')
def index():
    db = get_db()
    posts = db.execute(
        'SELECT p.idSoftwarePackage, Name, Description, username'
        ' FROM SoftwarePackage p JOIN user u ON p.idSoftwarePackage = u.id'
        ' ORDER BY created DESC'
    ).fetchall()
    return render_template('blog/index.html', posts=posts)

@bp.route('/select', methods=('GET', 'POST'))
@login_required
def select():
    if request.method == 'POST':
        Name = request.form['Name']
        Description = request.form['Description']
        error = None

        if not Name:
            error = 'Name is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO SoftwarePackage (Name, Description, idSoftwarePackage)'
                ' VALUES (?, ?, ?)',
                (Name, Description, g.user['id'])
            )
            db.commit()
            return redirect(url_for('blog.index'))

    return render_template('blog/select.html')

@bp.route('/create', methods=('GET', 'POST'))
@login_required
def create():
    if request.method == 'POST':
        Name = request.form['Name']
        Description = request.form['Description']
	Version = request.form['Version']
	OpenSource = request.form['OpenSource']
        error = None

        if not Name:
            error = 'Name is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO SoftwarePackage (Name, Description, idSoftwarePackage)'
                ' VALUES (?, ?, ?)',
                (Name, Description, g.user['id'])
            )
            db.commit()
            return redirect(url_for('blog.select'))

    return render_template('blog/create.html')

@bp.route('/createDeveloper', methods=('GET', 'POST'))
@login_required
def createDeveloper():
    if request.method == 'POST':
        Name = request.form['Name']
        Description = request.form['Description']
        error = None

        if not Name:
            error = 'Name is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'INSERT INTO SoftwarePackage (Name, Description)'
                ' VALUES (?, ?, ?)',
                (Name, Description, g.user['id'])
            )
            db.commit()
            return redirect(url_for('blog.index'))

    return render_template('blog/createDeveloper.html')

def get_post(idSoftwarePackage):
    SoftwarePackage = get_db().execute(
        'SELECT p.idSoftwarePackage, Name, Description, username'
        ' FROM post p JOIN user u ON p.idSoftwarePackage = u.id'
        ' WHERE p.idSoftwarePackage = ?',
        (idSoftwarePackage,)
    ).fetchone()

    if SoftwarePackage is None:
        abort(404, "Post id {0} doesn't exist.".format(idSoftwarePackage))

    return SoftwarePackage

@bp.route('/<int:idSoftwarePackage>/update', methods=('GET', 'POST'))
@login_required
def update(idSoftwarePackage):
    SoftwarePackage = get_post(idSoftwarePackage)

    if request.method == 'POST':
        Name = request.form['Name']
        Description = request.form['Description']
        error = None

        if not Name:
            error = 'Name is required.'

        if error is not None:
            flash(error)
        else:
            db = get_db()
            db.execute(
                'UPDATE SoftwarePackage SET Name = ?, Description = ?'
                ' WHERE idSoftwarePackage = ?',
                (Name, Description, idSoftwarePackage)
            )
            db.commit()
            return redirect(url_for('blog.index'))

    return render_template('blog/update.html', SoftwarePackage=SoftwarePackage)

@bp.route('/<int:idSoftwarePackage>/delete', methods=('POST',))
@login_required
def delete(idSoftwarePackage):
    get_post(idSoftwarePackage)
    db = get_db()
    db.execute('DELETE FROM SoftwarePackage WHERE idSoftwarePackage = ?', (idSoftwarePackage,))
    db.commit()
    return redirect(url_for('blog.index'))
