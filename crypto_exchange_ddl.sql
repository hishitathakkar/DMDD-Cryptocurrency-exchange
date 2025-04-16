
-- Drop existing database if it exists
DROP DATABASE IF EXISTS CryptoExchangeDB;
GO

-- Create a new database
CREATE DATABASE CryptoExchangeDB;
GO

USE CryptoExchangeDB;

-- Employee Table
CREATE TABLE Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Role NVARCHAR(50) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Salary DECIMAL(10, 2) CHECK (Salary > 0),
    ReportsTo NVARCHAR(100),
    HireDate DATETIME NOT NULL
);

-- Users Table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Password_Hash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber NVARCHAR(15),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    AccountStatus NVARCHAR(20) CHECK (AccountStatus IN ('Active', 'Inactive'))
);
CREATE INDEX IX_Users_Email ON Users(Email);

-- KYCDocuments Table
CREATE TABLE KYCDocuments (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
    DocumentType NVARCHAR(50) NOT NULL CHECK (DocumentType IN ('ID', 'Proof of Address')),
    DocumentPath NVARCHAR(255) NOT NULL,
    SubmissionDate DATETIME DEFAULT GETDATE(),
    VerificationStatus NVARCHAR(20) CHECK (VerificationStatus IN ('Pending', 'Approved', 'Rejected')),
    VerifierComments NVARCHAR(MAX)
);

-- SupportTickets Table
CREATE TABLE SupportTickets (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
    Subject NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Status NVARCHAR(20) CHECK (Status IN ('Open', 'In Progress', 'Resolved')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    SupportComment NVARCHAR(MAX),
    ResolvedAt DATETIME,
    VerifiedBy INT FOREIGN KEY REFERENCES Employee(EmployeeID) ON DELETE SET NULL
);
CREATE INDEX IX_SupportTickets_Status ON SupportTickets(Status);

-- Cryptocurrencies Table
CREATE TABLE Cryptocurrencies (
    CryptoID INT IDENTITY(1,1) PRIMARY KEY,
    CryptoName NVARCHAR(50) NOT NULL UNIQUE,
    Symbol NVARCHAR(10) NOT NULL UNIQUE,
    CurrentMarketPrice DECIMAL(18, 2) CHECK (CurrentMarketPrice > 0),
    CryptoLink NVARCHAR(MAX)
);

-- DigitalWallet Table (holds USD only)
CREATE TABLE DigitalWallet (
    WalletID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL UNIQUE FOREIGN KEY REFERENCES Users(UserID) ON DELETE CASCADE,
    WalletAddress NVARCHAR(MAX),
    WalletAmount_USD DECIMAL(18, 2) DEFAULT 0 CHECK (WalletAmount_USD >= 0),
    Last_Updated DATETIME DEFAULT GETDATE()
);

-- UserHoldings Table (holds crypto balances)
CREATE TABLE UserHoldings (
    HoldingID INT IDENTITY(1,1) PRIMARY KEY,
    WalletID INT NOT NULL FOREIGN KEY REFERENCES DigitalWallet(WalletID) ON DELETE CASCADE,
    CryptoID INT NOT NULL FOREIGN KEY REFERENCES Cryptocurrencies(CryptoID) ON DELETE CASCADE,
    Amount DECIMAL(18, 8) CHECK (Amount >= 0),
    LastUpdated DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_Wallet_Crypto UNIQUE(WalletID, CryptoID)
);

-- Transactions Table (fiat only)
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    WalletID INT NOT NULL FOREIGN KEY REFERENCES DigitalWallet(WalletID),
    TransactionType NVARCHAR(20) CHECK (TransactionType IN ('Deposit', 'Withdrawal')),
    Amount DECIMAL(18, 2) CHECK (Amount > 0),
    TransactionDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Failed'))
);

-- Orders Table (buy/sell crypto using USD)
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    WalletID INT NOT NULL FOREIGN KEY REFERENCES DigitalWallet(WalletID),
    CryptoID INT NOT NULL FOREIGN KEY REFERENCES Cryptocurrencies(CryptoID),
    OrderType NVARCHAR(10) CHECK (OrderType IN ('Buy', 'Sell')),
    Quantity DECIMAL(18, 8) CHECK (Quantity > 0),
    PricePerUnit DECIMAL(18, 2) CHECK (PricePerUnit > 0),
    OrderStatus NVARCHAR(20) CHECK (OrderStatus IN ('Pending', 'Completed', 'Cancelled')),
    OrderDate DATETIME DEFAULT GETDATE()
);

-- Reports Table
CREATE TABLE Reports (
    ReportID INT IDENTITY(1,1) PRIMARY KEY,
    ReportType NVARCHAR(50) NOT NULL,
    Description NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    GeneratedBy INT FOREIGN KEY REFERENCES Employee(EmployeeID)
);


-- Table-level CHECK constraints for data integrity
-- 1. Ensure salary is within a realistic range
ALTER TABLE Employee ADD CONSTRAINT CHK_Salary_Range CHECK (Salary BETWEEN 30000 AND 1000000);

-- 2. Ensure Transaction amount limits
ALTER TABLE Transactions ADD CONSTRAINT CHK_Transaction_Amount_Limit CHECK (Amount <= 100000);

-- 3. Ensure Orders total value is reasonable (Quantity * PricePerUnit)
ALTER TABLE Orders ADD CONSTRAINT CHK_Order_Total_Value CHECK (Quantity * PricePerUnit <= 500000);

-- Nullability rules already defined in table creation:
-- - Required fields are marked NOT NULL.
-- - Optional fields (e.g., PhoneNumber, ReportsTo, SupportComment) are nullable.
