const { add, clamp, isEven, isNonEmptyString, safeDivide } = require("../../src/utils");

describe("utils", () => {
  test("add returns sum", () => {
    expect(add(2, 3)).toBe(5);
  });

  test("clamp enforces min", () => {
    expect(clamp(-5, 0, 10)).toBe(0);
  });

  test("clamp enforces max", () => {
    expect(clamp(25, 0, 10)).toBe(10);
  });

  test("isEven returns true for even numbers", () => {
    expect(isEven(8)).toBe(true);
  });

  test("isNonEmptyString returns false for empty string", () => {
    expect(isNonEmptyString("   ")).toBe(false);
  });

  test("safeDivide returns null for divide by zero", () => {
    expect(safeDivide(10, 0)).toBeNull();
  });
});
