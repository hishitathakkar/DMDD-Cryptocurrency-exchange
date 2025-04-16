
import streamlit as st
import pyodbc
import pandas as pd
import plotly.express as px

# Database connection
def get_connection():
    return pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=localhost,1433;'
        'DATABASE=CryptoExchangeDB;'
        'UID=SA;'
        'PWD=YourSTRONGPassword123'
    )

def run_query(query):
    conn = get_connection()
    df = pd.read_sql(query, conn)
    conn.close()
    return df

st.set_page_config(page_title="Crypto Exchange Admin", layout="wide")
st.title("🪙 Cryptocurrency Exchange Admin Panel")

menu = st.sidebar.radio("Navigation", [
    "Users", "Wallets", "Holdings", "Transactions", "Orders", 
    "Cryptocurrencies", "Employees", "Support Tickets", "Reports", "KYC",
    "Monthly Transactions", "Resolve Ticket", "Execute Order", "📄 Pending Orders View", 
    "📊 Support Ticket Metrics", "💼 Portfolio Value", "🛡️ KYC Status", "📝 User Change Log",
    "💰 Active Wallet Balances", "📊 Analytics Dashboard", "🧾 Transaction Log"
])


if menu == "Users":
    st.header("👤 Users")
    st.dataframe(run_query("SELECT * FROM Users"))

elif menu == "Wallets":
    st.header("💼 Digital Wallets")
    st.dataframe(run_query("SELECT * FROM DigitalWallet"))

elif menu == "Holdings":
    st.header("📊 User Holdings")
    st.dataframe(run_query("SELECT * FROM UserHoldings"))

elif menu == "Transactions":
    st.header("💸 Transactions")
    st.dataframe(run_query("SELECT * FROM Transactions"))

elif menu == "Orders":
    st.header("📈 Orders")
    st.dataframe(run_query("SELECT * FROM Orders"))

elif menu == "Cryptocurrencies":
    st.header("🪙 Cryptocurrencies")
    st.dataframe(run_query("SELECT * FROM Cryptocurrencies"))

elif menu == "Employees":
    st.header("🧑‍💼 Employees")
    st.dataframe(run_query("SELECT * FROM Employee"))

elif menu == "Support Tickets":
    st.header("🎟️ Support Tickets")
    st.dataframe(run_query("SELECT * FROM SupportTickets"))

elif menu == "Reports":
    st.header("📋 Reports")
    st.dataframe(run_query("SELECT * FROM Reports"))

elif menu == "KYC":
    st.header("📁 KYC Documents")
    st.dataframe(run_query("SELECT * FROM KYCDocuments"))

elif menu == "Monthly Transactions":
    st.header("📆 Monthly Transactions Viewer")
    
    user_id = st.number_input("User ID", min_value=1)
    month = st.selectbox("Month", list(range(1, 13)))
    year = st.number_input("Year", min_value=2000, max_value=2100, value=2023)
    
    if st.button("Get Transactions"):
        query = f"EXEC GetMonthlyTransactions @UserID = {user_id}, @Month = {month}, @Year = {year}"
        data = run_query(query)
        st.dataframe(data)

elif menu == "Resolve Ticket":
    st.header("🧰 Resolve Support Ticket")

    ticket_id = st.number_input("Ticket ID", min_value=1)
    employee_id = st.number_input("Employee ID", min_value=1)
    comment = st.text_area("Resolution Comment")

    if st.button("Resolve Ticket"):
        query = f"""
        EXEC ResolveSupportTicket 
            @TicketID = {ticket_id}, 
            @Comment = ?, 
            @EmployeeID = {employee_id}
        """
        insert_query(query, (comment,))
        st.success("✅ Ticket resolved successfully.")


elif menu == "Execute Order":
    st.header("📤 Execute Crypto Order")

    order_id = st.number_input("Order ID", min_value=1)

    if st.button("Execute Order"):
        query = f"EXEC ExecuteCryptoOrder @OrderID = {order_id}"
        insert_query(query, ())
        st.success("✅ Order executed successfully.")

elif menu == "📄 Pending Orders View":
    st.header("📄 Pending Orders")
    data = run_query("SELECT * FROM PendingOrders")
    st.dataframe(data)

elif menu == "📊 Support Ticket Metrics":
    st.header("📊 Support Ticket Metrics")
    data = run_query("SELECT * FROM SupportTicketMetrics")
    st.dataframe(data)

elif menu == "💰 Active Wallet Balances":
    st.header("💰 Active User Wallet Balances")
    data = run_query("SELECT * FROM ActiveUserWalletBalance")
    st.dataframe(data)

elif menu == "🛡️ KYC Status":
    st.header("🛡️ User KYC Status")
    user_id = st.number_input("Enter User ID", min_value=1, step=1)
    if st.button("Get KYC Status"):
        query = f"SELECT dbo.fn_GetUserKYCStatus({user_id}) AS KYCStatus"
        result = run_query(query)
        if not result.empty:
            status = result.iloc[0]['KYCStatus']
            st.success(f"User {user_id} KYC Status: {status}")
        else:
            st.warning("No data found for this user.")





elif menu == "📊 Analytics Dashboard":
    st.header("📊 Advanced Analytics")

    # 1. Time-based transaction trends
    df_txn = run_query("""
        SELECT TransactionDate, TransactionType, Amount 
        FROM Transactions
    """)
    df_txn['TransactionDate'] = pd.to_datetime(df_txn['TransactionDate'])
    txn_trend = df_txn.groupby([df_txn['TransactionDate'].dt.date, 'TransactionType'])['Amount'].sum().reset_index()
    fig1 = px.line(txn_trend, x='TransactionDate', y='Amount', color='TransactionType', title='Daily Transactions by Type')
    st.plotly_chart(fig1, use_container_width=True)

    # 2. Wallet balance distribution
    df_wallet = run_query("SELECT WalletAmount_USD FROM DigitalWallet")
    fig2 = px.box(df_wallet, y='WalletAmount_USD', title='Wallet Balance Distribution')
    st.plotly_chart(fig2, use_container_width=True)

    # 3. Order volumes by cryptocurrency
    df_orders = run_query("SELECT CryptoID, OrderType, Quantity FROM Orders")
    crypto_map = run_query("SELECT CryptoID, CryptoName FROM Cryptocurrencies")
    df_orders = df_orders.merge(crypto_map, on='CryptoID', how='left')
    volume_data = df_orders.groupby(['CryptoName', 'OrderType'])['Quantity'].sum().reset_index()
    fig3 = px.bar(volume_data, x='CryptoName', y='Quantity', color='OrderType', barmode='group', title='Buy vs Sell Orders per Crypto')
    st.plotly_chart(fig3, use_container_width=True)

    # 4. User holdings in top 5 cryptos based on USD value
    df_holdings = run_query("""
        SELECT uh.CryptoID, uh.Amount, c.CurrentMarketPrice 
        FROM UserHoldings uh
        JOIN Cryptocurrencies c ON uh.CryptoID = c.CryptoID
    """)
    df_holdings['TotalValueUSD'] = df_holdings['Amount'] * df_holdings['CurrentMarketPrice']
    top_holdings = df_holdings.groupby('CryptoID')['TotalValueUSD'].sum().sort_values(ascending=False).head(5).reset_index()
    top_holdings = top_holdings.merge(crypto_map, on='CryptoID', how='left')
    fig4 = px.pie(top_holdings, values='TotalValueUSD', names='CryptoName', title='Top 5 Crypto Holdings by Users (USD Value)')
    st.plotly_chart(fig4, use_container_width=True)

elif menu == "💼 Portfolio Value":
    st.header("💼 User Portfolio Value")
    user_id = st.number_input("Enter User ID", min_value=1, step=1)
    if st.button("Get Portfolio Value"):
        query = f"SELECT dbo.fn_GetUserPortfolioValue({user_id}) AS PortfolioValueUSD"
        result = run_query(query)
        if not result.empty:
            value = result.iloc[0]['PortfolioValueUSD']
            st.success(f"User {user_id} Portfolio Value: ${value:,.2f} USD")
        else:
            st.warning("No data found for this user.")

elif menu == "📝 User Change Log":
    st.header("📝 User Change Log")
    st.dataframe(run_query("SELECT * FROM UserChangeLog"))

elif menu == "🧾 Transaction Log":
    st.header("🧾 Transaction Log")
    st.dataframe(run_query("SELECT * FROM TransactionLog"))
