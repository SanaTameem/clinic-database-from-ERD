--Database Creation
createdb -U postgres clinic-database
psql -U postgres clinic-database

--Tables Creation
CREATE TABLE patients (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,name VARCHAR(50),date_of_birth DATE);
CREATE TABLE medical_histories (id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,admitted_at TIMESTAMP,patient_id INT REFERENCES patients(id),status VARCHAR(50));