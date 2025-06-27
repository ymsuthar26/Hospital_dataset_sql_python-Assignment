# Project Overview
The goal of this project was to build a realistic hospital database using Python and SQL Server. Instead of using actual patient data, I generated synthetic (fake) data using Python libraries like Faker and random. This data was then structured and analyzed using Python (with Pandas and NumPy) and stored in SQL Server for further use.

# The project includes five main tables:

- Hospitals – List of hospitals with unique IDs and names.
- Patients – Records of 1,00,000 fake patients with hospital link, name, date of birth, and admission/discharge dates.
- Diagnosis – Each patient was assigned two diseases from a list (e.g., Flu, Diabetes, COVID-19).
- Treatments – Each patient received five treatments including medicine names, dose time (morning, evening, night), and duration.
- Payments – Records of payments with amount and payment method (cash or credit).

Once the data was created in Python, I connected it to SQL Server using the pyodbc library and inserted all the tables into a relational database. 
This helped in understanding how to manage large-scale structured data in both Python and SQL environments.

# The purpose of the project was to practice:

Creating large datasets
Managing relationships between tables (like foreign keys)
Performing SQL operations like inserting, querying, and filtering data

# Technologies Used
Python: For generating fake data using Faker, Random, and Datetime libraries
        also library used pandas,numpy

SQL Server: For storing and querying structured data
pyodbc: To connect Python with SQL Server

# SQL Analysis Performed
Average Patients per month, week, and year per hospital
Occupancy Analysis: Daily, Weekly, Monthly, Yearly trends
Most Used Medicine overall and per diagnosis
Age Group Classification: Children, Adults, Seniors
Average Hospital Stay Duration (in days)
Monthly & Yearly Income Reports grouped by payment mode
