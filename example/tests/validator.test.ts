import { expect, test, describe } from "bun:test";
import { validateCustomer } from "../src/validator";

describe("validateCustomer", () => {
  test("validates a correct record", () => {
    const record = {
      customer_id: "1001",
      full_name: "Ada Lovelace",
      email: "ada@example.com",
      status: "active"
    };
    const result = validateCustomer(record);
    expect(result.customer_id).toBe(1001);
    expect(result.full_name).toBe("Ada Lovelace");
    expect(result.status).toBe("active");
  });

  test("throws on missing fields", () => {
    expect(() => validateCustomer({ customer_id: "1" })).toThrow("Missing full_name");
  });

  test("throws on invalid customer_id", () => {
    expect(() => validateCustomer({ 
      customer_id: "abc", 
      full_name: "John Doe", 
      email: "j@d.com", 
      status: "active" 
    })).toThrow("Invalid customer_id: abc");
  });

  test("throws on single-word name", () => {
    expect(() => validateCustomer({ 
      customer_id: "1", 
      full_name: "Prince", 
      email: "p@example.com", 
      status: "active" 
    })).toThrow("full_name must have at least two words");
  });

  test("throws on invalid email", () => {
    expect(() => validateCustomer({ 
      customer_id: "1", 
      full_name: "John Doe", 
      email: "invalid-email", 
      status: "active" 
    })).toThrow("Invalid email format: invalid-email");
  });

  test("throws on invalid status", () => {
    expect(() => validateCustomer({ 
      customer_id: "1", 
      full_name: "John Doe", 
      email: "j@d.com", 
      status: "pending" 
    })).toThrow("Invalid status: pending");
  });
});
