--Database Creation
createdb - U postgres clinic - database 
psql - U postgres clinic - database

--Create patients table
CREATE TABLE patients (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    date_of_birth DATE
);

--Create medical_histories table
CREATE TABLE medical_histories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(50)
);

--Create invoices table
CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

--Create invoice_items table
CREATE TABLE invoice_items (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT
);

--Create treatment table
CREATE TABLE treatments(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(50),
    name VARCHAR(50)
);

-- Update treatment_id to FK after treatments table is created
ALTER TABLE invoice_items ADD CONSTRAINT fk_treatments FOREIGN KEY(treatment_id) REFERENCES treatments(id);

--Create treatement_medical_history table for many to many relationship
CREATE TABLE treatement_medical_history (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    medical_history_id INT REFERENCES medical_histories(id),
    treatments_id INT REFERENCES treatments(id)
);

/*Index creation for all foreign keys*/
CREATE INDEX idx_treatment_id ON invoice_items(treatment_id ASC);
CREATE INDEX idx_medical_history_id ON invoices(medical_history_id ASC);
CREATE INDEX idx_patient_id ON medical_histories(patient_id ASC);
CREATE INDEX idx_treatment_medical_history_id ON treatement_medical_history(medical_history_id ASC);
CREATE INDEX idx_treatment_treatments_id ON treatement_medical_history(treatments_id ASC);
CREATE INDEX idx_invoice_id ON invoice_items (invoice_id);