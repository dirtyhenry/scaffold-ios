const express = require("express");
const bodyParser = require("body-parser");

const app = express();
const port = 3000;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.get("/", (req, res) => res.send("Hello World!"));

app.post("/login", (req, res) => {
  console.log(req.body);

  res.setHeader("Content-Type", "application/json");

  if (!req.body) {
    res.status(400).json({ success: false });
  } else {
    const { username, password } = req.body;
    if (username === "John Doe" && password === "foobar") {
      res.status(201).json({ success: true });
    } else {
      res.status(403).json({ success: false });
    }
  }
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
