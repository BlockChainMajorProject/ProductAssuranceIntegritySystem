const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const users = []; // Array to store registered user details

app.post('/register', (req, res) => {
    const { username, password, type } = req.body;
    users.push({ username, password, type });
    res.send('Registration successful.');
});

app.post('/login', (req, res) => {
    const { username, password, type } = req.body;
    const user = users.find((u) => u.type === type && u.username === username && u.password === password);

    if (user) {
        res.send('Login successful.');
    } else {
        res.status(401).send('Login failed. Invalid credentials.');
    }
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
