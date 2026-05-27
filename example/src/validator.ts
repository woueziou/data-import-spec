import { Customer } from "./types";

export const VALID_STATUSES = ['active', 'hold', 'inactive'] as const;

// Basic but robust enough email regex for this context
const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export class ValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "ValidationError";
  }
}

export function validateCustomer(record: any): Customer {
  // 1. Structural checks
  if (!record.customer_id) throw new ValidationError("Missing customer_id");
  if (!record.full_name) throw new ValidationError("Missing full_name");
  if (!record.email) throw new ValidationError("Missing email");
  if (!record.status) throw new ValidationError("Missing status");

  // 2. Type & Value checks
  const customer_id = parseInt(record.customer_id, 10);
  if (isNaN(customer_id) || customer_id <= 0) {
    throw new ValidationError(`Invalid customer_id: ${record.customer_id}`);
  }

  const full_name = record.full_name.trim();
  if (full_name.split(/\s+/).length < 2) {
    throw new ValidationError("full_name must have at least two words");
  }

  const email = record.email.trim();
  if (!EMAIL_REGEX.test(email)) {
    throw new ValidationError(`Invalid email format: ${email}`);
  }

  const status = record.status.trim().toLowerCase();
  if (!VALID_STATUSES.includes(status as any)) {
    throw new ValidationError(`Invalid status: ${status}`);
  }

  return {
    customer_id,
    full_name,
    email,
    status: status as 'active' | 'hold' | 'inactive',
  };
}
