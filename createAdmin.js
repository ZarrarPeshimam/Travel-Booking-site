const mysql = require('mysql');
const bcrypt = require('bcryptjs');

const db = mysql.createConnection({
    host: 'localhost',
    user: 'admin',
    password: 'spit',
    database: 'admin_app'
});

db.connect(async (err) => {
    if (err) throw err;
    console.log('Connected to database');

    const username = 'admin';
    const password = 'adminpassword'; // Password for the admin
    const hashedPassword = await bcrypt.hash(password, 10);

    // Check if user already exists
    db.query('SELECT * FROM admins WHERE username = ?', [username], (err, results) => {
        if (err) throw err;

        if (results.length > 0) {
            // User exists, update the password
            db.query('UPDATE admins SET password_hash = ? WHERE username = ?', [hashedPassword, username], (err) => {
                if (err) throw err;
                console.log('Admin password updated');
                db.end();
            });
        } else {
            // User does not exist, insert new user
            const query = 'INSERT INTO admins (username, password_hash) VALUES (?, ?)';
            db.query(query, [username, hashedPassword], (err) => {
                if (err) throw err;
                console.log('Admin user created');
                db.end();
            });
        }
    });
});
