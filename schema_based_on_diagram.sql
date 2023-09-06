--Database Creation
createdb -U postgres clinic-database
psql -U postgres clinic-database

--Tables Creation
CREATE TABLE patients (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR(50),date_of_birth DATE);
CREATE TABLE medical_histories (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,admitted_at TIMESTAMP,patient_id INT REFERENCES patients(id),status VARCHAR(50));
CREATE TABLE invoices (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,total_amount NUMERIC(10,2),generated_at TIMESTAMP,payed_at TIMESTAMP,medical_history_id INT REFERENCES medical_histories(id));
-- Update treatment_id to FK after treatments table is created
CREATE TABLE invoice_items (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,unit_price NUMERIC(10,2),quantity INT,total_price NUMERIC(10,2),invoice_id INT REFERENCES invoices(id),treatment_id INT);