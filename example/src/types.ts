export interface Customer {
  customer_id: number;
  full_name: string;
  email: string;
  status: 'active' | 'hold' | 'inactive';
}

export interface IngestedCustomer extends Customer {
  _source_file: string;
  _ingestion_date: string; // YYYY-MM from filename
}

export interface QuarantineRecord {
  source_file: string;
  line_number: number;
  raw_data: string;
  error: string;
}
