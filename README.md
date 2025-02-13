# Store SQL Database - MySQL

This repository contains the SQL scripts for an online store database. It includes the table structure, relationships, and triggers designed to maintain data integrity. <br/>
The main objective of this database is to manage multiple stores, track sales, employees, customers, products and generate detailed reports for business analysis.

## 📂 Repository Contents

* store_sql: Script for creating the database and its tables, with the included triggers.
* generate_report: SQL script to view different reports.

## 📊 Database Structure

The database diagram:
![diagram](https://github.com/user-attachments/assets/484f97ac-3483-494b-be82-11642cc069ac)


## 📋 Store reports

✔ Generate reports that show the current status of each invoice, grouped by their status: pending, paid or cancelled. <br/>
✔ View the quantity and type of products sold as part of each invoice. <br/>
✔ Identify the invoices that were generated as a result of sales in each store.

## ⚙️ Implemented Triggers

### Automatic Stock Update
Every time an order is placed, the stock of purchased products is automatically reduced.

### Automatic Total Payment Calculation
The order total is automatically calculated when products are inserted into an invoice_id, additionally, a discount can be applied to each product, and the trigger handles the discount as well.

## Author
Kendall Vargas

## License
This project is created for practice purposes and is not intended for commercial use. No specific license is applied.
