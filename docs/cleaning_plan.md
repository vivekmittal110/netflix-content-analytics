# Netflix Analytics — Data Quality Audit & Cleaning Plan

## 1. Original Dataset
- Rows: 8,807
- Columns: 12
- Duplicate rows: 0
- Duplicate show IDs: 0
- Overall missing-cell rate: 4.08%

## 2. Audit Findings
- `director`: 2,634 missing values
- `country`: 831 missing values
- `cast`: 825 missing values
- `date_added`: 10 missing values
- `rating`: 4 missing values
- `duration`: 3 missing values
- No empty or whitespace-only strings detected.
- 88 non-missing date values contain extra whitespace.
- Three movie durations (66, 74 and 84 minutes) appear in the `rating` field.
- All non-missing duration values match the expected format for their content type.
- All show IDs are unique, and all content types are valid.

## 3. Proposed Cleaning Rules
1. Preserve the original CSV unchanged.
2. Trim whitespace from text values where appropriate.
3. Parse `date_added` into a date type; retain genuinely missing dates.
4. Recover the three misplaced durations from their existing rating values and set their ratings to missing pending verification.
5. Keep unknown director, cast and country values missing rather than inventing data.
6. Keep movie duration in minutes and TV-show duration in seasons as separate numeric fields.
7. Validate every transformation and compare pre-cleaning and post-cleaning metrics.

## 4. Status
Original-data audit completed. Cleaning has not started.
