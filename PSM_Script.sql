CREATE PROCEDURE GetMonthlyTransactions
    @UserID INT,
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT 
        T.TransactionID,
        T.TransactionType,
        T.Amount,
        T.Status,
        T.TransactionDate
    FROM Transactions T
    INNER JOIN DigitalWallet DW ON T.WalletID = DW.WalletID
    WHERE DW.UserID = @UserID
      AND MONTH(T.TransactionDate) = @Month
      AND YEAR(T.TransactionDate) = @Year
    ORDER BY T.TransactionDate DESC;
END;
GO

-- Example execution:
EXEC GetMonthlyTransactions @UserID = 1, @Month = 3, @Year = 2023;


CREATE PROCEDURE ResolveSupportTicket
    @TicketID INT,
    @Comment NVARCHAR(MAX),
    @EmployeeID INT
AS
BEGIN
    UPDATE SupportTickets
    SET 
        Status = 'Resolved',
        SupportComment = @Comment,
        ResolvedAt = GETDATE(),
        VerifiedBy = @EmployeeID
    WHERE TicketID = @TicketID AND Status != 'Resolved';
END;
GO

-- Example execution:
EXEC ResolveSupportTicket @TicketID = 2, @Comment = 'Issue resolved. Kindly check again.', @EmployeeID = 3;


CREATE PROCEDURE ExecuteCryptoOrder
    @OrderID INT
AS
BEGIN
    DECLARE @WalletID INT, @CryptoID INT, @OrderType NVARCHAR(10),
            @Quantity DECIMAL(18, 8), @Price DECIMAL(18, 2),
            @Total DECIMAL(18, 2)

    -- Get order details
    SELECT 
        @WalletID = WalletID,
        @CryptoID = CryptoID,
        @OrderType = OrderType,
        @Quantity = Quantity,
        @Price = PricePerUnit,
        @Total = Quantity * PricePerUnit
    FROM Orders
    WHERE OrderID = @OrderID AND OrderStatus = 'Pending';

    IF @OrderType = 'Buy'
    BEGIN
        -- Deduct USD from wallet
        UPDATE DigitalWallet
        SET WalletAmount_USD = WalletAmount_USD - @Total,
            Last_Updated = GETDATE()
        WHERE WalletID = @WalletID;

        -- Add to holdings or insert
        IF EXISTS (
            SELECT 1 FROM UserHoldings 
            WHERE WalletID = @WalletID AND CryptoID = @CryptoID
        )
        BEGIN
            UPDATE UserHoldings
            SET Amount = Amount + @Quantity,
                LastUpdated = GETDATE()
            WHERE WalletID = @WalletID AND CryptoID = @CryptoID;
        END
        ELSE
        BEGIN
            INSERT INTO UserHoldings (WalletID, CryptoID, Amount)
            VALUES (@WalletID, @CryptoID, @Quantity);
        END
    END
    ELSE IF @OrderType = 'Sell'
    BEGIN
        -- Deduct crypto from holdings
        UPDATE UserHoldings
        SET Amount = Amount - @Quantity,
            LastUpdated = GETDATE()
        WHERE WalletID = @WalletID AND CryptoID = @CryptoID;

        -- Add USD to wallet
        UPDATE DigitalWallet
        SET WalletAmount_USD = WalletAmount_USD + @Total,
            Last_Updated = GETDATE()
        WHERE WalletID = @WalletID;
    END

    -- Mark order as completed
    UPDATE Orders
    SET OrderStatus = 'Completed'
    WHERE OrderID = @OrderID;
END;
GO

-- Example execution:
EXEC ExecuteCryptoOrder @OrderID = 3;


CREATE VIEW PendingOrders AS
SELECT 
    O.OrderID,
    O.WalletID,
    DW.UserID,
    U.FirstName + ' ' + U.LastName AS UserName,
    O.CryptoID,
    C.Symbol AS CryptoSymbol,
    O.OrderType,
    O.Quantity,
    O.PricePerUnit,
    (O.Quantity * O.PricePerUnit) AS TotalValue,
    O.OrderDate
FROM Orders O
JOIN DigitalWallet DW ON O.WalletID = DW.WalletID
JOIN Users U ON DW.UserID = U.UserID
JOIN Cryptocurrencies C ON O.CryptoID = C.CryptoID
WHERE O.OrderStatus = 'Pending';
GO

SELECT * FROM PendingOrders;


CREATE VIEW SupportTicketMetrics AS
SELECT 
    Status,
    COUNT(*) AS TotalTickets,
    COUNT(CASE WHEN Status = 'Resolved' THEN 1 END) AS ResolvedTickets,
    COUNT(CASE WHEN Status = 'Open' THEN 1 END) AS OpenTickets,
    COUNT(CASE WHEN Status = 'In Progress' THEN 1 END) AS InProgressTickets,
    MIN(CreatedAt) AS EarliestCreated,
    MAX(CreatedAt) AS LatestCreated
FROM SupportTickets
GROUP BY Status;
GO

SELECT * FROM SupportTicketMetrics;

CREATE VIEW ActiveUserWalletBalance AS
SELECT 
    U.UserID,
    U.FirstName + ' ' + U.LastName AS FullName,
    U.Email,
    DW.WalletID,
    DW.WalletAmount_USD,
    DW.Last_Updated
FROM Users U
JOIN DigitalWallet DW ON U.UserID = DW.UserID
WHERE U.AccountStatus = 'Active';
GO

SELECT * FROM ActiveUserWalletBalance;






CREATE FUNCTION dbo.fn_GetUserPortfolioValue (@UserID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalValue DECIMAL(18, 2);

    SELECT @TotalValue = 
        COALESCE(dw.WalletAmount_USD, 0) + 
        COALESCE(SUM(uh.Amount * c.CurrentMarketPrice), 0)
    FROM DigitalWallet dw
    LEFT JOIN UserHoldings uh ON dw.WalletID = uh.WalletID
    LEFT JOIN Cryptocurrencies c ON uh.CryptoID = c.CryptoID
    WHERE dw.UserID = @UserID
    GROUP BY dw.WalletAmount_USD;

    RETURN ISNULL(@TotalValue, 0);
END;
GO

-- Get portfolio value for user with UserID = 1
SELECT dbo.fn_GetUserPortfolioValue(1) AS PortfolioValueUSD;

CREATE FUNCTION dbo.fn_GetUserKYCStatus (@UserID INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @IDVerified BIT = 0;
    DECLARE @AddressVerified BIT = 0;
    DECLARE @HasPending BIT = 0;
    DECLARE @HasRejected BIT = 0;
    DECLARE @KYCStatus NVARCHAR(50);

    SELECT 
        @IDVerified = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM KYCDocuments
    WHERE UserID = @UserID
      AND DocumentType = 'ID'
      AND VerificationStatus = 'Approved';

    SELECT 
        @AddressVerified = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM KYCDocuments
    WHERE UserID = @UserID
      AND DocumentType = 'Proof of Address'
      AND VerificationStatus = 'Approved';

    SELECT 
        @HasPending = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM KYCDocuments
    WHERE UserID = @UserID
      AND VerificationStatus = 'Pending';

    SELECT 
        @HasRejected = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END
    FROM KYCDocuments
    WHERE UserID = @UserID
      AND VerificationStatus = 'Rejected';

    SET @KYCStatus = CASE 
        WHEN @IDVerified = 1 AND @AddressVerified = 1 THEN 'Fully Verified'
        WHEN @IDVerified = 1 OR @AddressVerified = 1 THEN 'Partially Verified'
        WHEN @HasPending = 1 THEN 'Pending Verification'
        WHEN @HasRejected = 1 THEN 'Verification Rejected'
        ELSE 'Not Verified'
    END;

    RETURN @KYCStatus;
END;
GO

-- Get KYC status for UserID=5
SELECT dbo.fn_GetUserKYCStatus(5) AS KYCStatus;

ALTER FUNCTION dbo.fn_GetCryptoProfitLoss (@UserID INT, @CryptoID INT)
RETURNS TABLE
AS
RETURN
(
    WITH UserWallets AS (
        SELECT WalletID
        FROM DigitalWallet
        WHERE UserID = @UserID
    ),
    BuyOrders AS (
        SELECT 
            o.WalletID,
            SUM(o.Quantity) AS TotalBought,
            SUM(o.Quantity * o.PricePerUnit) AS TotalSpent
        FROM Orders o
        INNER JOIN UserWallets uw ON o.WalletID = uw.WalletID
        WHERE o.CryptoID = @CryptoID
          AND o.OrderType = 'Buy'
          AND o.OrderStatus = 'Completed'
        GROUP BY o.WalletID
    ),
    Holdings AS (
        SELECT uh.WalletID, uh.Amount
        FROM UserHoldings uh
        INNER JOIN UserWallets uw ON uh.WalletID = uw.WalletID
        WHERE uh.CryptoID = @CryptoID
    )
    SELECT 
        @UserID AS UserID,
        c.CryptoName,
        c.Symbol,
        COALESCE(SUM(h.Amount), 0) AS CurrentHolding,
        c.CurrentMarketPrice,
        COALESCE(SUM(h.Amount), 0) * c.CurrentMarketPrice AS CurrentValue,
        CASE 
            WHEN SUM(bo.TotalBought) > 0 THEN SUM(bo.TotalSpent) / SUM(bo.TotalBought)
            ELSE 0
        END AS AverageBuyPrice,
        CASE 
            WHEN SUM(bo.TotalBought) > 0 THEN (COALESCE(SUM(h.Amount), 0) * c.CurrentMarketPrice) - (COALESCE(SUM(h.Amount), 0) * (SUM(bo.TotalSpent) / SUM(bo.TotalBought)))
            ELSE 0
        END AS ProfitLoss
    FROM Cryptocurrencies c
    LEFT JOIN Holdings h ON 1=1
    LEFT JOIN BuyOrders bo ON h.WalletID = bo.WalletID
    WHERE c.CryptoID = @CryptoID
    GROUP BY c.CryptoName, c.Symbol, c.CurrentMarketPrice
);
GO

-- Profit/Loss for UserID = 2 and CryptoID = 1 (e.g., Bitcoin)
SELECT * FROM dbo.fn_GetCryptoProfitLoss(2, 1);



CREATE TABLE UserChangeLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ChangedAt DATETIME DEFAULT GETDATE(),
    ChangedBy NVARCHAR(100) DEFAULT SYSTEM_USER,
    OldAccountStatus NVARCHAR(20),
    NewAccountStatus NVARCHAR(20),
    OldEmail NVARCHAR(100),
    NewEmail NVARCHAR(100),
    OldPhoneNumber NVARCHAR(15),
    NewPhoneNumber NVARCHAR(15)
);

CREATE TRIGGER trg_LogUserUpdate
ON Users
AFTER UPDATE
AS
BEGIN
    INSERT INTO UserChangeLog (
        UserID,
        OldAccountStatus, NewAccountStatus,
        OldEmail, NewEmail,
        OldPhoneNumber, NewPhoneNumber
    )
    SELECT
        d.UserID,
        d.AccountStatus, i.AccountStatus,
        d.Email, i.Email,
        d.PhoneNumber, i.PhoneNumber
    FROM deleted d
    INNER JOIN inserted i ON d.UserID = i.UserID
    WHERE 
        d.AccountStatus <> i.AccountStatus
        OR d.Email <> i.Email
        OR d.PhoneNumber <> i.PhoneNumber;
END;


CREATE TABLE TransactionLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    TransactionID INT NOT NULL,
    WalletID INT NOT NULL,
    TransactionType NVARCHAR(20),
    Amount DECIMAL(18,2),
    TransactionDate DATETIME,
    Status NVARCHAR(20),
    LoggedAt DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_LogTransactionInsert
ON Transactions
AFTER INSERT
AS
BEGIN
    INSERT INTO TransactionLog (
        TransactionID,
        WalletID,
        TransactionType,
        Amount,
        TransactionDate,
        Status
    )
    SELECT
        i.TransactionID,
        i.WalletID,
        i.TransactionType,
        i.Amount,
        i.TransactionDate,
        i.Status
    FROM inserted i;
END;

CREATE NONCLUSTERED INDEX IX_Orders_OrderStatus_OrderDate
ON Orders(OrderStatus, OrderDate);

CREATE NONCLUSTERED INDEX IX_Transactions_WalletID_Status
ON Transactions(WalletID, Status);
