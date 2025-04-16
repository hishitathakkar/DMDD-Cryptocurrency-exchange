-- Insert sample data into Users table (UserID is auto-generated)
INSERT INTO Users (FirstName, LastName, Password_Hash, Email, PhoneNumber, RegistrationDate, AccountStatus)
VALUES 
('Alice', 'Morgan', '2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824', 'alice.morgan1@gmail.com', '1234567890', '2020-05-14', 'Active'),
('Bob', 'Smith', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'bob.smith2@gmail.com', '2345678901', '2021-03-22', 'Active'),
('Charlie', 'Nguyen', '6b3a55e0261b0304143f805a249be172b05e3d5b1be1397fbbbe63193f8347c0', 'charlie.nguyen3@gmail.com', '3456789012', '2022-11-09', 'Inactive'),
('Diana', 'Chen', 'b305cadbb3bce54f3aa59c64fec00dea3a1bd9d86b91b6a5d5d92e6b0f5f54f8', 'diana.chen4@gmail.com', '4567890123', '2023-01-17', 'Active'),
('Ethan', 'Patel', '7c6a180b36896a0a8c02787eeafb0e4c76f2a09f3c9a75b64f10a6b3f04d8456', 'ethan.patel5@gmail.com', '5678901234', '2020-07-30', 'Active'),
('Fiona', 'Lopez', '2e7d2c03a9507ae265ecf5b5356885a3b1b3bfe8633f0f6a1bde7b2d6b84a3dd', 'fiona.lopez6@gmail.com', '6789012345', '2021-09-11', 'Inactive'),
('George', 'Kim', '8d969eef6ecad3c29a3a629280e686cff8fabd7426f63f6c6f1d6de4d88c4fef', 'george.kim7@gmail.com', '7890123456', '2024-02-05', 'Active'),
('Hannah', 'Mehta', '9b74c9897bac770ffc029102a200c5de7439e6f37354d7ac510c1756c7c0f3a5', 'hannah.mehta8@gmail.com', '8901234567', '2020-12-19', 'Active'),
('Ivan', 'Singh', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'ivan.singh9@gmail.com', '9012345678', '2022-04-01', 'Inactive'),
('Julia', 'Taylor', 'ab56b4d92b40713acc5af89985d4b7860d4d3c06b26c0d1bb445c391c8e7f82d', 'julia.taylor10@gmail.com', '1122334455', '2023-06-20', 'Active'),
('Kevin', 'Brown', '1f3870be274f6c49b3e31a0c6728957f', 'kevin.brown11@gmail.com', '2233445566', '2021-08-15', 'Active'),
('Lily', 'Zhao', '5f4dcc3b5aa765d61d8327deb882cf99', 'lily.zhao12@gmail.com', '3344556677', '2020-10-10', 'Inactive'),
('Mohammed', 'Ali', '6cb75f652a9b52798eb6cf2201057c73', 'mohammed.ali13@gmail.com', '4455667788', '2024-03-27', 'Active'),
('Nina', 'White', '8fa14cdd754f91cc6554c9e71929cce7', 'nina.white14@gmail.com', '5566778899', '2022-05-09', 'Active'),
('Oscar', 'Gomez', '6c569aabbf7775ef8fc570e228c16b98', 'oscar.gomez15@gmail.com', '6677889900', '2021-12-01', 'Inactive'),
('Priya', 'Rao', 'b2e98ad6f6eb8508dd6a14cfa704bad7f05f6fb1aebf9b7d99b2c01a6c9c01d6', 'priya.rao16@gmail.com', '7788990011', '2023-08-21', 'Active'),
('Quinn', 'Hughes', '4a44dc15364204a80fe80e9039455cc1', 'quinn.hughes17@gmail.com', '8899001122', '2020-06-18', 'Active'),
('Ravi', 'Kapoor', '7b8b965ad4bca0e41ab51de7b31363a1', 'ravi.kapoor18@gmail.com', '9900112233', '2022-07-14', 'Inactive'),
('Sofia', 'Diaz', 'c33367701511b4f6020ec61ded352059', 'sofia.diaz19@gmail.com', '1010101010', '2024-01-01', 'Active'),
('Tom', 'Olsen', '2b24d495052a8ce66355d4fa5e0597c2', 'tom.olsen20@gmail.com', '2020202020', '2021-04-25', 'Active');


-- Insert sample data into DigitalWallet
INSERT INTO DigitalWallet (UserID, WalletAddress, WalletAmount_USD)
VALUES
(1, 'WALLET-1001-XYZ', 1200.50),
(2, 'WALLET-1002-ABC', 5000.00),
(3, 'WALLET-1003-QWE', 850.75),
(4, 'WALLET-1004-ASD', 132.10),
(5, 'WALLET-1005-ZXC', 6200.00),
(6, 'WALLET-1006-POI', 75.00),
(7, 'WALLET-1007-LKJ', 9050.90),
(8, 'WALLET-1008-MNB', 234.10),
(9, 'WALLET-1009-UYT', 0.00),
(10, 'WALLET-1010-RTY', 876.45),
(11, 'WALLET-1011-IOP', 1130.20),
(12, 'WALLET-1012-GHJ', 650.00),
(13, 'WALLET-1013-BNM', 4310.80),
(14, 'WALLET-1014-TGB', 300.00),
(15, 'WALLET-1015-EDC', 990.70),
(16, 'WALLET-1016-WSX', 185.15),
(17, 'WALLET-1017-VFR', 2120.00),
(18, 'WALLET-1018-YHN', 99.99),
(19, 'WALLET-1019-UJM', 1500.00),
(20, 'WALLET-1020-IKM', 789.35);


-- Insert sample data into Cryptocurrencies
INSERT INTO Cryptocurrencies (CryptoName, Symbol, CurrentMarketPrice, CryptoLink)
VALUES
('Bitcoin', 'BTC', 67350.25, 'https://bitcoin.org'),
('Ethereum', 'ETH', 3510.40, 'https://ethereum.org'),
('Tether', 'USDT', 1.00, 'https://tether.to'),
('Binance Coin', 'BNB', 585.75, 'https://www.binance.com'),
('Solana', 'SOL', 158.22, 'https://solana.com'),
('XRP', 'XRP', 0.62, 'https://ripple.com/xrp'),
('Cardano', 'ADA', 0.47, 'https://cardano.org'),
('Dogecoin', 'DOGE', 0.19, 'https://dogecoin.com'),
('Polkadot', 'DOT', 7.15, 'https://polkadot.network'),
('Avalanche', 'AVAX', 42.90, 'https://avax.network'),
('Litecoin', 'LTC', 92.35, 'https://litecoin.org'),
('Shiba Inu', 'SHIB', 0.01, 'https://shibatoken.com'),  
('Chainlink', 'LINK', 18.45, 'https://chain.link'),
('Stellar', 'XLM', 0.13, 'https://www.stellar.org'),
('Uniswap', 'UNI', 12.78, 'https://uniswap.org'),
('Cosmos', 'ATOM', 9.35, 'https://cosmos.network'),
('Monero', 'XMR', 156.85, 'https://www.getmonero.org'),
('VeChain', 'VET', 0.04, 'https://www.vechain.org'),
('Filecoin', 'FIL', 7.85, 'https://filecoin.io'),
('Aptos', 'APT', 9.10, 'https://aptoslabs.com');


-- UserHoldings with valid CryptoIDs (13 to 32)
INSERT INTO UserHoldings (WalletID, CryptoID, Amount)
VALUES
(1, 1, 0.00521000),     -- Bitcoin
(2, 2, 1.42000000),     -- Ethereum
(3, 3, 1000.00000000),  -- Tether
(4, 4, 2.50000000),     -- BNB
(5, 5, 10.00000000),    -- Solana
(6, 6, 500.00000000),   -- XRP
(7, 7, 300.00000000),   -- Cardano
(8, 8, 10000.00000000), -- Dogecoin
(9, 9, 15.00000000),    -- Polkadot
(10, 10, 3.12000000),    -- Avalanche
(11, 11, 6.00000000),    -- Litecoin
(12, 12, 900000.00000000), -- Shiba Inu
(13, 13, 4.20000000),    -- Chainlink
(14, 14, 1500.00000000), -- Stellar
(15, 15, 8.35000000),    -- Uniswap
(16, 16, 20.00000000),   -- Cosmos
(17, 17, 1.00000000),    -- Monero
(18, 18, 18000.00000000), -- VeChain
(19, 19, 12.30000000),   -- Filecoin
(20, 20, 5.40000000);    -- Aptos


-- Sample Inserts into Transactions
INSERT INTO Transactions (WalletID, TransactionType, Amount, TransactionDate, Status)
VALUES
(1, 'Deposit', 5000.00, '2023-03-15 09:30:00', 'Completed'),
(2, 'Deposit', 1500.00, '2024-01-12 14:45:00', 'Completed'),
(3, 'Withdrawal', 200.00, '2023-10-08 16:20:00', 'Completed'),
(4, 'Deposit', 3000.00, '2022-07-19 11:00:00', 'Completed'),
(5, 'Withdrawal', 1200.00, '2023-05-03 13:15:00', 'Pending'),
(6, 'Deposit', 250.00, '2021-11-23 10:40:00', 'Completed'),
(7, 'Deposit', 10000.00, '2024-02-01 09:00:00', 'Completed'),
(8, 'Withdrawal', 500.00, '2023-08-14 12:30:00', 'Failed'),
(9, 'Deposit', 900.00, '2020-12-25 08:55:00', 'Completed'),
(10, 'Deposit', 1200.00, '2021-03-10 10:10:00', 'Completed'),
(11, 'Withdrawal', 300.00, '2023-04-18 15:50:00', 'Completed'),
(12, 'Deposit', 700.00, '2022-06-22 16:45:00', 'Pending'),
(13, 'Deposit', 800.00, '2021-01-30 17:00:00', 'Completed'),
(14, 'Withdrawal', 100.00, '2023-09-01 13:35:00', 'Completed'),
(15, 'Deposit', 150.00, '2024-03-07 11:25:00', 'Completed'),
(16, 'Deposit', 4000.00, '2023-05-11 14:05:00', 'Completed'),
(17, 'Withdrawal', 50.00, '2022-12-20 09:55:00', 'Failed'),
(18, 'Deposit', 1300.00, '2024-04-01 08:10:00', 'Completed'),
(19, 'Withdrawal', 350.00, '2023-06-15 18:20:00', 'Pending'),
(20, 'Deposit', 2000.00, '2021-08-17 10:30:00', 'Completed');


-- Orders Insert: OrderStatus Values
INSERT INTO Orders (WalletID, CryptoID, OrderType, Quantity, PricePerUnit, OrderStatus, OrderDate)
VALUES
(1, 1, 'Buy', 0.00350000, 67350.00, 'Completed', '2024-03-14 09:30:00'),
(2, 2, 'Buy', 0.50000000, 3510.00, 'Completed', '2023-11-20 10:15:00'),
(3, 3, 'Sell', 100.00000000, 1.00, 'Pending', '2023-07-01 08:45:00'),
(4, 4, 'Buy', 1.50000000, 585.75, 'Completed', '2022-09-09 14:20:00'),
(5, 5, 'Buy', 5.00000000, 158.22, 'Cancelled', '2021-06-18 11:10:00'),
(6, 6, 'Sell', 200.00000000, 0.62, 'Completed', '2020-12-05 13:35:00'),
(7, 7, 'Buy', 300.00000000, 0.47, 'Completed', '2023-01-23 15:00:00'),
(8, 8, 'Sell', 800.00000000, 0.19, 'Pending', '2024-02-10 16:40:00'),
(9, 9, 'Buy', 10.00000000, 7.15, 'Completed', '2022-04-25 09:50:00'),
(10, 10, 'Sell', 3.00000000, 42.90, 'Completed', '2023-03-17 10:00:00'),
(11, 11, 'Buy', 2.00000000, 92.35, 'Completed', '2024-01-10 12:20:00'),
(12, 12, 'Buy', 100000.00000000, 0.01, 'Completed', '2023-10-05 11:15:00'),
(13, 13, 'Sell', 2.00000000, 18.45, 'Pending', '2023-05-03 13:45:00'),
(14, 14, 'Buy', 500.00000000, 0.13, 'Completed', '2024-04-01 14:30:00'),
(15, 15, 'Buy', 15.00000000, 12.78, 'Cancelled', '2021-08-08 09:05:00'),
(16, 16, 'Sell', 12.00000000, 9.35, 'Completed', '2022-07-21 10:50:00'),
(17, 17, 'Buy', 1.50000000, 156.85, 'Completed', '2023-09-30 08:20:00'),
(18, 18, 'Sell', 10000.00000000, 0.04, 'Completed', '2020-11-11 13:25:00'),
(19, 19, 'Buy', 6.00000000, 7.85, 'Completed', '2023-06-13 15:35:00'),
(20, 20, 'Buy', 5.00000000, 9.10, 'Pending', '2022-02-15 17:10:00');


INSERT INTO Employee (EmployeeName, Email, Role, PhoneNumber, Salary, ReportsTo, HireDate)
VALUES
('Alice Morgan', 'alice.morgan01@gmail.com', 'Support', '555-123-0001', 55000.00, 'Olivia Foster', '2020-05-10'),
('Ben Carter', 'ben.carter02@gmail.com', 'Manager', '555-123-0002', 72000.00, 'David Lee', '2019-03-12'),
('Clara Nguyen', 'clara.nguyen03@gmail.com', 'Compliance', '555-123-0003', 64000.00, 'Paul Gonzalez', '2021-08-22'),
('David Lee', 'david.lee04@gmail.com', 'Support', '555-123-0004', 56000.00, 'Olivia Foster', '2022-11-15'),
('Ella Rodriguez', 'ella.rodriguez05@gmail.com', 'Manager', '555-123-0005', 75000.00, 'Ben Carter', '2023-04-19'),
('Frank Patel', 'frank.patel06@gmail.com', 'Support', '555-123-0006', 57000.00, 'Olivia Foster', '2021-06-27'),
('Grace Walker', 'grace.walker07@gmail.com', 'Compliance', '555-123-0007', 61000.00, 'Paul Gonzalez', '2020-02-13'),
('Harry Baker', 'harry.baker08@gmail.com', 'Support', '555-123-0008', 54000.00, 'Ella Rodriguez', '2019-10-05'),
('Isla Young', 'isla.young09@gmail.com', 'Manager', '555-123-0009', 76000.00, 'Ben Carter', '2020-01-28'),
('Jake Rivera', 'jake.rivera10@gmail.com', 'Compliance', '555-123-0010', 65000.00, 'Paul Gonzalez', '2021-12-04'),
('Kara Wood', 'kara.wood11@gmail.com', 'Support', '555-123-0011', 56000.00, 'Olivia Foster', '2022-07-16'),
('Liam Simmons', 'liam.simmons12@gmail.com', 'Manager', '555-123-0012', 73000.00, 'David Lee', '2023-01-05'),
('Mia Griffin', 'mia.griffin13@gmail.com', 'Compliance', '555-123-0013', 62000.00, 'Paul Gonzalez', '2020-06-24'),
('Noah Hayes', 'noah.hayes14@gmail.com', 'Support', '555-123-0014', 55500.00, 'Ella Rodriguez', '2021-09-30'),
('Olivia Foster', 'olivia.foster15@gmail.com', 'Manager', '555-123-0015', 77000.00, NULL, '2019-04-11'),
('Paul Gonzalez', 'paul.gonzalez16@gmail.com', 'Compliance', '555-123-0016', 66500.00, NULL, '2020-08-19'),
('Quinn Bryant', 'quinn.bryant17@gmail.com', 'Support', '555-123-0017', 54500.00, 'David Lee', '2021-03-09'),
('Ruby James', 'ruby.james18@gmail.com', 'Manager', '555-123-0018', 75500.00, 'Ben Carter', '2022-10-23'),
('Sam Watts', 'sam.watts19@gmail.com', 'Support', '555-123-0019', 56000.00, 'Olivia Foster', '2023-05-02'),
('Tina Hughes', 'tina.hughes20@gmail.com', 'Compliance', '555-123-0020', 63000.00, 'Paul Gonzalez', '2024-01-30');



INSERT INTO SupportTickets (UserID, Subject, Description, Status, CreatedAt, SupportComment, ResolvedAt, VerifiedBy)
VALUES
(1, 'Login Issue', 'Unable to login with my credentials.', 'Resolved', '2022-01-12 10:25:00', 'Password reset and shared.', '2022-01-13 14:10:00', 1),
(2, 'Wallet Balance Error', 'My wallet shows incorrect USD balance.', 'In Progress', '2023-03-15 09:40:00', NULL, NULL, 4),
(3, 'KYC Status Pending', 'Submitted docs a week ago, still pending.', 'Open', '2024-02-02 16:10:00', NULL, NULL, NULL),
(4, 'Transaction Delay', 'Deposit hasn’t reflected in my wallet.', 'Resolved', '2022-11-01 13:05:00', 'Transaction confirmed.', '2022-11-02 08:00:00', 5),
(5, 'Cannot Sell Crypto', 'Sell order throws an error.', 'In Progress', '2023-06-07 15:30:00', NULL, NULL, 8),
(6, 'Crypto not Received', 'Bought ETH but it’s not in holdings.', 'Resolved', '2021-12-24 11:20:00', 'System sync issue fixed.', '2021-12-25 17:50:00', 3),
(7, 'App Crash', 'Mobile app crashes when opening wallet.', 'Open', '2024-01-19 20:55:00', NULL, NULL, NULL),
(8, 'Unable to Withdraw', 'USD withdrawal keeps failing.', 'In Progress', '2023-09-14 12:45:00', NULL, NULL, 6),
(9, 'Error Updating Profile', 'Error saving KYC address info.', 'Resolved', '2020-08-03 10:00:00', 'Address field validation fixed.', '2020-08-04 09:15:00', 2),
(10, '2FA Not Working', 'Auth code always invalid.', 'Resolved', '2021-07-17 18:30:00', 'Time sync issue resolved.', '2021-07-18 11:20:00', 7),
(11, 'Fee Charged Twice', 'Got charged twice for a transaction.', 'In Progress', '2023-11-23 07:40:00', NULL, NULL, 4),
(12, 'Wrong Crypto Listed', 'My purchase shows XRP instead of LTC.', 'Open', '2022-10-05 14:50:00', NULL, NULL, NULL),
(13, 'Cannot Cancel Order', 'Order stuck in pending state.', 'In Progress', '2024-02-10 16:00:00', NULL, NULL, 9),
(14, 'Support Not Responding', 'No replies in over 5 days.', 'Resolved', '2020-06-11 09:15:00', 'Apologized and resolved issue.', '2020-06-13 13:45:00', 1),
(15, 'Unrecognized Login Attempt', 'Received alert but not me.', 'Resolved', '2021-03-29 22:10:00', 'Account monitored & secured.', '2021-03-30 07:30:00', 6),
(16, 'Document Upload Failed', 'KYC docs won’t upload.', 'Open', '2023-05-18 17:20:00', NULL, NULL, NULL),
(17, 'Transaction Marked Failed', 'But my bank shows it succeeded.', 'In Progress', '2023-08-27 11:10:00', NULL, NULL, 5),
(18, 'Missing Crypto', 'ETH deducted but not received.', 'Resolved', '2021-01-15 08:30:00', 'Issue fixed after verification.', '2021-01-16 10:00:00', 2),
(19, 'Deposit Issue', 'My USD deposit didn’t reflect.', 'In Progress', '2024-03-09 12:00:00', NULL, NULL, 7),
(20, 'Stuck Withdrawal', 'Withdrawal initiated, no progress.', 'Open', '2024-04-01 14:25:00', NULL, NULL, NULL);


INSERT INTO KYCDocuments (UserID, DocumentType, DocumentPath, SubmissionDate, VerificationStatus, VerifierComments)
VALUES
(1, 'ID', '/docs/user1_id.pdf', '2021-05-10 10:00:00', 'Approved', 'Verified successfully.'),
(2, 'Proof of Address', '/docs/user2_address.pdf', '2023-01-15 14:30:00', 'Pending', NULL),
(3, 'ID', '/docs/user3_id.pdf', '2022-09-21 09:45:00', 'Rejected', 'Document was blurry.'),
(4, 'Proof of Address', '/docs/user4_address.pdf', '2024-02-18 11:15:00', 'Approved', 'Verified without issues.'),
(5, 'ID', '/docs/user5_id.pdf', '2020-12-30 08:20:00', 'Approved', 'Valid government ID.'),
(6, 'Proof of Address', '/docs/user6_address.pdf', '2023-11-07 17:50:00', 'Pending', NULL),
(7, 'ID', '/docs/user7_id.pdf', '2021-04-12 10:30:00', 'Approved', 'Face matched with account info.'),
(8, 'Proof of Address', '/docs/user8_address.pdf', '2024-03-29 13:00:00', 'Pending', NULL),
(9, 'ID', '/docs/user9_id.pdf', '2022-07-19 16:45:00', 'Rejected', 'ID expired.'),
(10, 'Proof of Address', '/docs/user10_address.pdf', '2023-05-22 09:15:00', 'Approved', 'Accepted utility bill.'),
(11, 'ID', '/docs/user11_id.pdf', '2020-09-17 08:10:00', 'Approved', 'Valid national ID.'),
(12, 'Proof of Address', '/docs/user12_address.pdf', '2024-01-11 18:30:00', 'Pending', NULL),
(13, 'ID', '/docs/user13_id.pdf', '2021-11-26 15:40:00', 'Rejected', 'Image tampered.'),
(14, 'Proof of Address', '/docs/user14_address.pdf', '2022-03-03 12:20:00', 'Approved', 'Validated successfully.'),
(15, 'ID', '/docs/user15_id.pdf', '2023-07-05 10:00:00', 'Approved', 'Everything matched.'),
(16, 'Proof of Address', '/docs/user16_address.pdf', '2021-08-28 11:50:00', 'Rejected', 'File not readable.'),
(17, 'ID', '/docs/user17_id.pdf', '2022-10-06 13:10:00', 'Pending', NULL),
(18, 'Proof of Address', '/docs/user18_address.pdf', '2023-06-13 16:30:00', 'Approved', 'Verified with bank statement.'),
(19, 'ID', '/docs/user19_id.pdf', '2024-02-01 09:25:00', 'Pending', NULL),
(20, 'Proof of Address', '/docs/user20_address.pdf', '2020-11-09 08:40:00', 'Rejected', 'Wrong document type.');


INSERT INTO Reports (ReportType, Description, CreatedAt, GeneratedBy)
VALUES
('Bug', 'Transaction failure issue reported in wallet module.', '2023-03-14 09:30:00', 1),
('Feedback', 'Customer praised the new referral program.', '2023-04-02 11:15:00', 2),
('Suspicious Activity', 'Login anomaly detected for user ID 34.', '2023-05-01 15:00:00', 3),
('Bug', 'Live price feed lag identified.', '2023-06-18 10:45:00', 4),
('Feedback', 'Suggested improvement to UI on mobile.', '2023-07-25 12:00:00', 5),
('Bug', 'KYC documents not uploading for new users.', '2023-08-10 14:20:00', 6),
('Suspicious Activity', 'Multiple failed withdrawals flagged.', '2023-09-03 16:50:00', 7),
('Bug', 'Order matching engine returned duplicate trades.', '2023-10-11 09:10:00', 8),
('Feedback', 'Employee noticed improved app stability.', '2023-11-22 13:45:00', 9),
('Suspicious Activity', 'High-frequency transactions observed from single IP.', '2023-12-05 17:30:00', 10),
('Bug', 'Balance mismatch in DigitalWallet on trade.', '2024-01-09 11:55:00', 1),
('Feedback', 'Better analytics tools proposed.', '2024-02-16 10:20:00', 2),
('Bug', 'Incorrect transaction timestamps seen.', '2024-03-12 14:10:00', 3),
('Suspicious Activity', 'Rapid KYC document changes by same user.', '2024-04-03 15:35:00', 4),
('Bug', 'Delayed deposit confirmation emails.', '2024-04-21 16:00:00', 5),
('Feedback', 'Add support for limit and market order filters.', '2024-05-01 13:00:00', 6),
('Suspicious Activity', 'Unusual login frequency from foreign IPs.', '2024-05-12 09:25:00', 7),
('Bug', 'Wallet balance UI not refreshing.', '2024-05-20 08:40:00', 8),
('Feedback', 'Positive customer feedback about support response time.', '2024-06-01 10:15:00', 9),
('Bug', 'Reversal logic missing in fiat withdrawal module.', '2024-06-14 14:00:00', 10);
