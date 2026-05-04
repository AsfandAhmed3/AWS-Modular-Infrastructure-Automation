const express = require("express");
const { add, clamp, isEven, isNonEmptyString } = require("./utils");

const app = express();

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.get("/sum", (req, res) => {
  const a = Number(req.query.a);
  const b = Number(req.query.b);

  if (Number.isNaN(a) || Number.isNaN(b)) {
    return res.status(400).json({ error: "a and b must be numbers" });
  }

  const result = add(a, b);
  return res.json({ result });
});

app.get("/echo/:message", (req, res) => {
  const message = req.params.message;
  if (!isNonEmptyString(message)) {
    return res.status(400).json({ error: "message is required" });
  }

  return res.json({ message, length: clamp(message.length, 1, 100) });
});

app.get("/even/:value", (req, res) => {
  const value = Number(req.params.value);
  if (Number.isNaN(value)) {
    return res.status(400).json({ error: "value must be a number" });
  }

  return res.json({ value, even: isEven(value) });
});

module.exports = app;
