function add(a, b) {
  return a + b;
}

function clamp(value, min, max) {
  return Math.min(Math.max(value, min), max);
}

function isEven(value) {
  return value % 2 === 0;
}

function isNonEmptyString(value) {
  return typeof value === "string" && value.trim().length > 0;
}

function safeDivide(a, b) {
  if (b === 0) {
    return null;
  }
  return a / b;
}

module.exports = {
  add,
  clamp,
  isEven,
  isNonEmptyString,
  safeDivide
};
