const request = require("supertest");
const app = require("../../src/app");

describe("GET /sum", () => {
  test("returns sum for valid numbers", async () => {
    const response = await request(app).get("/sum?a=4&b=5");
    expect(response.status).toBe(200);
    expect(response.body).toEqual({ result: 9 });
  });

  test("returns 400 for invalid numbers", async () => {
    const response = await request(app).get("/sum?a=abc&b=2");
    expect(response.status).toBe(400);
    expect(response.body).toEqual({ error: "a and b must be numbers" });
  });
});
