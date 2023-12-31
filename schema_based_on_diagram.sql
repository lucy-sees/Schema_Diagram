CREATE DATABASE medical_database;

\c medical_database

CREATE TABLE patients(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);

CREATE TABLE medical_histories(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT,
    status VARCHAR(255),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE treatments(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);

CREATE TABLE invoices(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    total_amount DECIMAL,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_history_id INT,
    FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE medical_histories_treatments(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    medical_histories_id INT,
    treatments_id INT,
    FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id),
    FOREIGN KEY (treatments_id) REFERENCES treatments(id)
);

CREATE INDEX invoice_id_index ON invoice_items(invoice_id);
CREATE INDEX treatment_id_index ON invoice_items(treatment_id);
CREATE INDEX medical_history_id_index ON invoices (medical_history_id);
CREATE INDEX patient_id_index ON medical_histories (patient_id);
CREATE INDEX medical_histories_id_index ON medical_histories_treatments (medical_histories_id);
CREATE INDEX treatments_id_index ON medical_histories_treatments (treatments_id);


