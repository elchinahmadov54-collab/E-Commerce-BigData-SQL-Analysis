E-Commerce Big Data Simulation & RFM Analysis
 
This project demonstrates **Advanced SQL** and **Data Engineering** capabilities by generating and analyzing a large-scale synthetic dataset (20,000+ records) for an E-commerce platform.

Instead of using static Excel files, I used PostgreSQL's built-in functions to simulate a real-world transactional database environment, enabling performance testing and complex analytics.

 Technical Skills Demonstrated
    Big Data Generation:** Used `generate_series()` and `random()` to create realistic Customer, Product, and Sales data (20k rows).
    Customer Segmentation (RFM):** Implemented logic to classify customers as *VIP*, *Loyal*, or *Regular* based on spending behavior.
    Advanced Analytics:** Used **Window Functions** (`OVER`, `LAG`) to calculate:
    7-Day Moving Averages (Trend Analysis)
    Year-over-Year (YoY) Growth %
    Data Modeling: Designed a relational schema with Primary and Foreign Keys.

  The SQL script includes solutions for:
1.  **RFM Analysis:** Identifying top high-value clients.
2.  **Sales Trends:** Smoothing daily volatility using Moving Averages.
3.  **Financial Growth:** Calculating dynamic revenue growth rates.
