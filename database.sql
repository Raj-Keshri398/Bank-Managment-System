CREATE DATABASE IF NOT EXISTS bank_db;
USE bank_db;

-- Table 1: Users (Login ke liye)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('customer', 'employee', 'admin') DEFAULT 'customer',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: Customers (KYC Details)
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE NOT NULL,
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    aadhar_number VARCHAR(20) UNIQUE,
    pan_number VARCHAR(20) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Table 3: Accounts (Bank Accounts)
CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT NOT NULL,
    account_type ENUM('savings', 'current', 'fd') DEFAULT 'savings',
    balance DECIMAL(15,2) DEFAULT 0.00,
    interest_rate DECIMAL(5,2) DEFAULT 4.00,
    status ENUM('active', 'inactive', 'closed') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Table 4: Transactions (Har Transaction ka record)
CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id VARCHAR(30) UNIQUE NOT NULL,
    from_account VARCHAR(20),
    to_account VARCHAR(20),
    transaction_type ENUM('deposit', 'withdrawal', 'transfer', 'loan_emi') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    balance_after DECIMAL(15,2),
    description TEXT,
    status ENUM('success', 'failed', 'pending') DEFAULT 'success',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_account) REFERENCES accounts(account_number),
    FOREIGN KEY (to_account) REFERENCES accounts(account_number)
);

-- Table 5: Loans
CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    loan_number VARCHAR(20) UNIQUE NOT NULL,
    customer_id INT NOT NULL,
    loan_type ENUM('home', 'personal', 'car', 'education') NOT NULL,
    principal_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    tenure_months INT NOT NULL,
    emi_amount DECIMAL(15,2),
    outstanding_amount DECIMAL(15,2),
    status ENUM('pending', 'approved', 'rejected', 'closed') DEFAULT 'pending',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approved_at TIMESTAMP NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Table 6: Employees (Bank Staff)
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    employee_code VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    designation VARCHAR(50),
    branch VARCHAR(100),
    phone VARCHAR(15),
    salary DECIMAL(10,2),
    joining_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table 7: Beneficiaries (Fund Transfer ke liye saved accounts)
CREATE TABLE beneficiaries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    beneficiary_name VARCHAR(100) NOT NULL,
    account_number VARCHAR(20) NOT NULL,
    bank_name VARCHAR(100) DEFAULT 'Our Bank',
    ifsc_code VARCHAR(20),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);