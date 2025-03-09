const express = require('express');
const mysql = require('mysql');
const bcrypt = require('bcryptjs');
const bodyParser = require('body-parser');
const session = require('express-session');
const path = require('path');  // For serving static files

const app = express();
app.use(express.static('public'));

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'your_secret_key',
    resave: false,
    saveUninitialized: true
}));

// Serve static files from the 'public' folder
app.use(express.static(path.join(__dirname, 'public')));

// Connect to MySQL
const db = mysql.createConnection({
    host: 'localhost',
    user: 'admin',
    password: 'spit',
    database: 'travel'
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
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.post('/login', (req, res) => {
    const { username, password } = req.body;
    const query = 'SELECT * FROM admins WHERE username = ?';

    db.query(query, [username], async (err, results) => {
        if (err) throw err;
        if (results.length > 0) {
            const admin = results[0];
            const isValidPassword = await bcrypt.compare(password, admin.password_hash);
            if (isValidPassword) {
                req.session.admin = admin;
                return res.redirect('/dashboard');
            }
        }
        res.send('Invalid username or password');
    });
});

app.get('/dashboard', checkAuthenticated, (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'dashboard.html'));
});

app.get('/add-data', checkAuthenticated, (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'customer.html'));
});

app.post('/add-data', checkAuthenticated, (req, res) => {
    const { name, address, customer_id, dob, phone, alt_phone } = req.body;

    if (!customer_id || isNaN(customer_id)) {
        return res.send('Invalid Customer ID');
    }
    console.log(`Customer ID: ${customer_id}`);

    // Step 1: Check if the customer already exists
    const checkCustomerQuery = 'SELECT * FROM customer WHERE customer_id = ?';

    db.query(checkCustomerQuery, [customer_id], (err, results) => {
        if (err) throw err;

        // If customer already exists, show an error message with a back link
        if (results.length > 0) {
            console.log('Customer already exists');
            return res.send(`
                <html>
                <body>
                    <h3 style="color: red;">Error: Customer ID ${customer_id} already exists!</h3>
                    <a href="/add-data">Go back to Add Customer</a>
                </body>
                </html>
            `);
        }

        // Step 2: If customer doesn't exist, proceed with insertion
        const insertCustomerQuery = 'INSERT INTO customer (customer_id, name, address, dob) VALUES (?, ?, ?, ?)';

        db.query(insertCustomerQuery, [customer_id, name, address, dob], (err) => {
            if (err) throw err;

            const insertPhoneQuery = 'INSERT INTO customer_phone (customer_id, ph_no) VALUES (?, ?)';
            db.query(insertPhoneQuery, [customer_id, phone], (err) => {
                if (err) throw err;

                // Check if an alternate phone number is provided
                if (alt_phone) {
                    const insertAltPhoneQuery = 'INSERT INTO customer_phone (customer_id, ph_no) VALUES (?, ?)';
                    db.query(insertAltPhoneQuery, [customer_id, alt_phone], (err) => {
                        if (err) throw err;
                        // Redirect to add-travel page after successful insertion
                        res.redirect(`/add-travel?customer_id=${customer_id}`);
                    });
                } else {
                    // Redirect to add-travel page after successful insertion
                    res.redirect(`/add-travel?customer_id=${customer_id}`);
                }
            });
        });
    });
});


app.get('/check-customer', checkAuthenticated, (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'old-customer.html'));
});

// Route to check if customer ID exists
app.post('/check-customer', checkAuthenticated, (req, res) => {
    const { customer_id } = req.body;

    // Query to check if the customer exists
    const query = 'SELECT * FROM customer WHERE customer_id = ?';

    db.query(query, [customer_id], (err, results) => {
        if (err) throw err;

        // If customer exists, redirect to add-travel page
        if (results.length > 0) {
            res.redirect(`/add-travel?customer_id=${encodeURIComponent(customer_id)}`);
        } else {
            // If customer does not exist, display error message
            res.send(`
                <html>
                <body>
                    <h3 style="color: red;">Customer ID not found. Please try again.</h3>
                    <a href="/check-customer">Go back to Dashboard</a>
                </body>
                </html>
            `);
        }
    });
});

// Route to add travel details
app.get('/add-travel', checkAuthenticated, (req, res) => {
    const customer_id = req.query.customer_id;
    if (!customer_id) {
        return res.send('Customer ID is missing.');
    }
    res.sendFile(path.join(__dirname, 'public', 'travel_selection.html'));
});


// Route to add travel details
app.get('/add-travel', checkAuthenticated, (req, res) => {
    const customer_id = req.query.customer_id;
    console.log(`Customer ID: ${customer_id}`);
    if (!customer_id) {
        return res.send('Customer ID is missing.');
    }
    res.sendFile(path.join(__dirname, 'public', 'travel_selection.html'));
});

app.post('/add-travel', checkAuthenticated, (req, res) => {
    const { customer_id, travel_mode, travel_class, travel_date, departure_time, departure, destination, arrival_time, travel_number } = req.body;
    console.log(`Customer ID: ${customer_id}`);
    
    if (!customer_id || isNaN(customer_id)) {
        return res.send('Invalid Customer ID');
    }

    if (!travel_mode) {
        return res.send('Travel mode is required');
    }

    const travelTable = travel_mode === 'train' ? 'train' : 'flight';
    const numberColumn = travel_mode === 'train' ? 'train_no' : 'flight_no';

    const seat = Math.floor(Math.random() * 100) + 1;

    // Directly insert the travel number (no uniqueness check)
    const insertQuery = `INSERT INTO ${travelTable} 
        (${numberColumn}, travel_class, travel_date, departure_time, arrival_time, seat, departure, destination, customer_id, food)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, "Veg")`;

    const customerIdInt = parseInt(customer_id, 10);

    db.query(insertQuery, [travel_number, travel_class, travel_date, departure_time, arrival_time, seat, departure, destination, customerIdInt], (err) => {
        if (err) throw err;

        // After successfully inserting, redirect to the details page
        res.redirect(`/details?type=${travel_mode}&no=${travel_number}`);
    });
});

app.get('/fetch-data', checkAuthenticated, (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'fetch-data.html'));
});

app.post('/fetch-data', checkAuthenticated, (req, res) => {
    const { search } = req.body;

    const query = `
        SELECT 
            f.flight_no, f.departure_time, f.arrival_time, f.travel_date, f.travel_class, f.food, f.departure, f.destination, 
            c.name AS customer_name, c.customer_id,
            'flight' AS type
        FROM flight f
        JOIN customer c ON f.customer_id = c.customer_id
        WHERE f.flight_no = ? OR c.customer_id = ?
        
        UNION
        
        SELECT 
            t.train_no, t.departure_time, t.arrival_time, t.travel_date, t.travel_class, t.food, t.departure, t.destination, 
            c.name AS customer_name, c.customer_id,
            'train' AS type
        FROM train t
        JOIN customer c ON t.customer_id = c.customer_id
        WHERE t.train_no = ? OR c.customer_id = ?
    `;

    db.query(query, [search, search, search, search], (err, results) => {
        if (err) throw err;

        // If no results found
        if (results.length === 0) {
            return res.send(`
                <h3>No flights, trains, or customers found with that search term.</h3>
                <a href="/fetch-data">Go back</a>
            `);
        }

        // Display the travel details with clickable links
        let resultHtml = `
            <html>
            <head>
                <link rel="stylesheet" type="text/css" href="searchResults.css">
            </head>
            <body>
                <h3>Search Results:</h3>
                <ul>
        `;

        results.forEach((row) => {
            resultHtml += `
                <li>
                    <a href="/details?type=${row.type}&no=${row.flight_no || row.train_no}">
                        ${row.type === 'flight' ? 'Flight No' : 'Train No'}: ${row.flight_no || row.train_no} - Customer: ${row.customer_name}
                    </a>
                    <div class="details">
                        Departure: ${row.departure} - Arrival: ${row.destination}
                        <br>
                        Date: ${row.travel_date} - Class: ${row.travel_class}
                    </div>
                </li>
            `;
        });

        resultHtml += '</ul><a class="go-back" href="/dashboard">Go back</a>';
        res.send(resultHtml);
    });
});

// Route to display detailed info based on flight_no or train_no
app.get('/details', checkAuthenticated, (req, res) => {
    const { type, no } = req.query;

    if (!no) {
        return res.send('A valid travel number (flight or train) is required to view details.');
    }

    let query;
    if (type === 'flight') {
        query = `
            SELECT f.flight_no AS travel_no, f.departure_time, f.arrival_time, f.travel_date, f.travel_class, f.food, f.departure, f.destination, c.name AS customer_name, c.customer_id
            FROM flight f
            JOIN customer c ON f.customer_id = c.customer_id
            WHERE f.flight_no = ?
        `;
    } else if (type === 'train') {
        query = `
            SELECT t.train_no AS travel_no, t.departure_time, t.arrival_time, t.travel_date, t.travel_class, t.food, t.departure, t.destination, c.name AS customer_name, c.customer_id
            FROM train t
            JOIN customer c ON t.customer_id = c.customer_id
            WHERE t.train_no = ?
        `;
    } else {
        return res.send('Invalid travel type specified.');
    }

    db.query(query, [no], (err, results) => {
        if (err) throw err;
        if (results.length === 0) {
            return res.send('No travel details found for the given number.');
        }

        const travel = results[0];

        res.send(`
            <html>
            <head>
                <link rel="stylesheet" type="text/css" href="detailsPage.css">
            </head>
            <body>
                <h3>Details for ${type === 'flight' ? 'Flight' : 'Train'} No: ${travel.travel_no}</h3>
                <div class="travel-details">
                <p><strong>Customer Name:</strong> ${travel.customer_name}</p>
                <p><strong>${type === 'flight' ? 'Flight' : 'Train'} No:</strong> ${travel.travel_no}</p>
                <p><strong>Departure:</strong> ${travel.departure} | <strong>Destination:</strong> ${travel.destination}</p>
                <p><strong>Departure Time:</strong> ${travel.departure_time} | <strong>Arrival Time:</strong> ${travel.arrival_time}</p>
                <p><strong>Travel Date:</strong> ${travel.travel_date}</p>
                <p><strong>Travel Class:</strong> ${travel.travel_class}</p>
                <p><strong>Food Preference:</strong> ${travel.food}</p></div>
                <a href="/dashboard">Go back</a>
            </body>
            </html>
        `);
    });
});


// Logout route
app.get('/logout', (req, res) => {
    req.session.destroy(() => {
        res.redirect('/login');
    });
});

// Start server
app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
