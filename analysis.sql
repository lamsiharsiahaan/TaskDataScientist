CREATE DATABASE Sihar;
USE Sihar;

SELECT * FROM e_commerce_transactions LIMIT 10;

-- Bagian 1: RFM dan Segmentasi Pelanggan
-- Menetapkan tanggal acuan
SET @ref_date = '2024-07-01';

-- Langkah 2: Hitung RFM per customer
SELECT
  customer_id,
  DATEDIFF(@ref_date, MAX(order_date)) AS recency,
  COUNT(order_id) AS frequency,
  SUM(payment_value) AS monetary,

  -- Segmentasi pelanggan berdasarkan kombinasi RFM
  CASE
    WHEN DATEDIFF(@ref_date, MAX(order_date)) <= 30 AND COUNT(order_id) >= 10 AND SUM(payment_value) >= 3000 THEN 'Best Customer'
    WHEN DATEDIFF(@ref_date, MAX(order_date)) <= 30 AND COUNT(order_id) >= 10 THEN 'Loyal Customer'
    WHEN DATEDIFF(@ref_date, MAX(order_date)) <= 30 THEN 'Potential Loyalist'
    WHEN DATEDIFF(@ref_date, MAX(order_date)) BETWEEN 31 AND 90 THEN 'Recent Customer'
    WHEN DATEDIFF(@ref_date, MAX(order_date)) BETWEEN 91 AND 180 THEN 'At Risk'
    ELSE 'Lost'
  END AS rfm_segment

FROM e_commerce_transactions
GROUP BY customer_id
ORDER BY customer_id;


-- Bagian 2: Repeat Purchase Bulanan
-- Menampilkan pelanggan yang melakukan repeat purchase dalam sebulan
EXPLAIN
SELECT 
  customer_id,
  DATE_FORMAT(order_date, '%Y-%m') AS order_month,
  COUNT(order_id) AS order_count
FROM e_commerce_transactions
GROUP BY customer_id, order_month
HAVING COUNT(order_id) > 1
ORDER BY customer_id, order_month;
