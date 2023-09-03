const express = require('express');
const app = express();
const port = 4000

app.get('/', (req, res) => {
    res.send('Hello SFS');
});

app.listen(port, () => {
    console.log("listening to port 4000");
});