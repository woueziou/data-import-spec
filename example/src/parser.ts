import { parse } from 'csv-parse';
import fs from 'node:fs';
import path from 'node:path';
import { validateCustomer } from './validator';
import type { IngestedCustomer, QuarantineRecord } from './types';

export interface ParseResult {
  validRecords: IngestedCustomer[];
  quarantine: QuarantineRecord[];
  stats: {
    total: number;
    success: number;
    failure: number;
  };
}

export async function* parseCustomerFile(filePath: string): AsyncGenerator<{ type: 'record', data: IngestedCustomer } | { type: 'quarantine', data: QuarantineRecord }> {
  const fileName = path.basename(filePath);
  const dateMatch = fileName.match(/customers_(\d{4}-\d{2})\.csv/);
  const partitionDate = dateMatch ? dateMatch[1] : 'unknown';

  const parser = fs.createReadStream(filePath).pipe(
    parse({
      columns: true,
      skip_empty_lines: true,
      trim: true,
    })
  );

  let lineNumber = 1; // Header is line 1

  for await (const record of parser) {
    lineNumber++;
    try {
      const validated = validateCustomer(record);
      yield {
        type: 'record',
        data: {
          ...validated,
          _source_file: fileName,
          _ingestion_date: partitionDate ?? "",
        }
      };
    } catch (err: any) {
      yield {
        type: 'quarantine',
        data: {
          source_file: fileName,
          line_number: lineNumber,
          raw_data: JSON.stringify(record),
          error: err.message,
        }
      };
    }
  }
}

// Simple CLI wrapper for demonstration if run directly
if (import.meta.main) {
  const args = process.argv.slice(2);
  const targetFile = args[0] || 'incoming/customers/customers_2026-06.csv';

  console.log(`Processing ${targetFile}...`);

  const stats = { total: 0, success: 0, failure: 0 };

  (async () => {
    for await (const result of parseCustomerFile(targetFile)) {
      stats.total++;
      if (result.type === 'record') {
        stats.success++;
        // In a real app, you would upsert to DB here
      } else {
        stats.failure++;
        console.error(`[QUARANTINE] Line ${result.data.line_number}: ${result.data.error}`);
      }
    }

    console.log(`\nFinished processing ${targetFile}`);
    console.log(`Total: ${stats.total}`);
    console.log(`Success: ${stats.success}`);
    console.log(`Failure: ${stats.failure}`);
  })().catch(err => {
    console.error(`Failed to process file: ${err.message}`);
  });
}
