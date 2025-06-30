# json-flattening-snowflake

This project provides a reusable and dynamic solution for flattening nested JSON data stored in Snowflake tables. It includes:

- A fully parameterized stored procedure that accepts a table name as input
- SQL scripts for setting up sample data and viewing results
- A generic JSON flattening approach that requires no manual schema editing
- Example data and expected output for easy validation

### 🔧 Key Features

- ✅ **Dynamic**: No need to hardcode column names or nested structures
- 📦 **Reusable**: Works across different tables and JSON formats
- 🧪 **Testable**: Includes sample data and outputs for quick validation
- 🧵 **Seamless Integration**: Designed for easy integration into your existing Snowflake workflows

---

### 📄 Contents

- `flatten_json_proc.sql`: The main stored procedure script
- `setup_scripts/`: Scripts to create test tables and insert sample JSON
- `samples/`: Sample JSON data and expected flattened output
- `docs/`: Link to related Medium article for a deep-dive

---

### 📚 Medium Article

Learn more about the approach, design decisions, and use cases in the accompanying blog post:  
👉 [Read the article on Medium](https://your-article-link)

---

### 🚀 Getting Started

```sql
-- Example: Run the stored procedure on your JSON table
CALL flatten_json_proc('your_database.schema.json_table');
