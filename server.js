const express = require('express');
const mysql = require('mysql');
const bcrypt = require('bcryptjs');
const bodyParser = require('body-parser');
const session = require('express-session');

const app = express();
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'your_secret_key',
    resave: false,
    saveUninitialized: true
}));

// Connect to MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'admin',
    password: 'spit',
    database: 'admin_app'
});

db.connect((err) => {
    if (err) throw err;
    console.log('Connected to database');
});

// Middleware to check if the admin is logged in
function checkAuthenticated(req, res, next) {
    if (req.session.admin) {
        return next();
    }
    res.redirect('/login');
}

// Route to render login page
app.get('/login', (req, res) => {
    res.send(`
        <form action="/login" method="POST">
            <label>Username:</label>
            <input type="text" name="username" required>
            <label>Password:</label>
            <input type="password" name="password" required>
            <button type="submit">Login</button>
        </form>
    `);
});

// Admin login route
app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT * FROM admins WHERE username = ?';

    db.query(query, [username], async (err, results) => {
        if (err) throw err;
        if (results.length > 0) {
            const admin = results[0];
            console.log('Input Password:', password); // Log the input password
            console.log('Stored Hash:', admin.password_hash); // Log the stored hash
            
            const isValidPassword = await bcrypt.compare(password, admin.password_hash);
            console.log('Password valid:', isValidPassword); // Log the result of the password comparison
            
            if (isValidPassword) {
                req.session.admin = admin;
                return res.redirect('/dashboard');
            }
        }
        res.send('Invalid username or password');
    });
});

// Admin dashboard (protected route)
app.get('/dashboard', checkAuthenticated, (req, res) => {
    res.send(`
        <h2>Welcome, Admin</h2>
        <a href="/add-data">Add Data</a> | <a href="/fetch-data">Fetch Data</a> | <a href="/logout">Logout</a>
    `);
});

// Route to add data
app.get('/add-data', checkAuthenticated, (req, res) => {
    res.send(`
        <form action="/add-data" method="POST">
            <label>Data Entry:</label>
            <input type="text" name="entry" required>
            <button type="submit">Add</button>
        </form>
    `);
});

app.post('/add-data', checkAuthenticated, (req, res) => {
    const { entry } = req.body;
    const query = 'INSERT INTO data_entries (entry) VALUES (?)';
    db.query(query, [entry], (err) => {
        if (err) throw err;
        res.send('Data added successfully! <a href="/dashboard">Go back</a>');
    });
});

// Route to fetch data
app.get('/fetch-data', checkAuthenticated, (req, res) => {
    res.send(`
        <form action="/fetch-data" method="POST">
            <label>Enter search term:</label>
            <input type="text" name="search" required>
            <button type="submit">Fetch</button>
        </form>
    `);
});

app.post('/fetch-data', checkAuthenticated, (req, res) => {
    const { search } = req.body;
    const query = 'SELECT * FROM data_entries WHERE entry LIKE ?';
    db.query(query, [`%${search}%`], (err, results) => {
        if (err) throw err;
        res.send(`
            <h3>Search Results:</h3>
            <ul>${results.map(row => `<li>${row.entry}</li>`).join('')}</ul>
            <a href="/dashboard">Go back</a>
        `);
    });
});

// Admin logout
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login');
});

// Start the server
app.listen(3000, () => {
    console.log('Server running on http://localhost:3000');
});
