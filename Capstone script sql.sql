-- Booking Patterns: 

-- What is the trend in booking patterns over time, 
-- and are there specific seasons or months with increased booking activity? 
SELECT DATE_FORMAT(`Booking_Date`, '%Y-%m') AS Month, COUNT(`Booking ID`) AS TotalBookings
FROM booking
GROUP BY Month
ORDER BY Month;

-- How does lead time vary across different booking channels, 
-- and is there a correlation between lead time and customer type? 

SELECT `Distribution Channel`, `Customer Type`, AVG(`Lead Time`) AS AvgLeadTime
FROM booking
GROUP BY `Distribution Channel`, `Customer Type`
ORDER BY AvgLeadTime DESC;

-- Customer Behavior Analysis:

-- Which distribution channels contribute the most to bookings, 
-- and how does the average daily rate (ADR) differ across these channels? 
SELECT `Distribution Channel`, COUNT(`Booking ID`) AS TotalBookings, AVG(`Avg Daily Rate`) AS AvgADR
FROM booking
GROUP BY `Distribution Channel`
ORDER BY TotalBookings DESC;

-- Can we identify any patterns in the distribution of guests based on their country of origin, 
-- and how does this impact revenue?
SELECT Country, COUNT(`Booking ID`) AS TotalBookings, SUM(Revenue) AS TotalRevenue
FROM booking
GROUP BY Country 
ORDER BY TotalRevenue DESC;

-- Cancellation Analysis: 

-- What factors are most strongly correlated with cancellations, 
-- and can we predict potential cancellations based on certain variables? 
SELECT `Lead Time`, `Distribution Channel`, `Customer Type`, COUNT(CASE WHEN `Cancelled (0/1)` = 1 THEN 1 END) AS TotalCancellations
FROM booking
GROUP BY `Lead Time`, `Distribution Channel`, `Customer Type`
ORDER BY TotalCancellations DESC;

-- How does the revenue loss from cancellations compare across different customer segments 
-- and distribution channels? 
SELECT `Distribution Channel`, `Customer Type`, SUM(`Revenue Loss`) AS TotalRevenueLoss
FROM booking
WHERE `Cancelled (0/1)` = 1
GROUP BY `Distribution Channel`, `Customer Type`
ORDER BY TotalRevenueLoss DESC;

-- Revenue Optimization: 

-- What is the overall revenue trend, 
-- and are there specific customer segments or countries contributing significantly to revenue? 

SELECT DATE_FORMAT(`Booking_Date`, '%Y-%m') AS Month,    SUM(Revenue) AS TotalRevenue
FROM booking
GROUP BY Month
ORDER BY Month;

-- Can we identify optimal pricing strategies based on the Average Daily Rate (ADR) 
-- for different customer types and distribution channels? 
SELECT `Customer Type`, `Distribution Channel`, AVG(`Avg Daily Rate`) AS AvgADR
FROM booking
GROUP BY `Customer Type`, `Distribution Channel`
ORDER BY AvgADR DESC;

-- Geographical Analysis: 
-- How does the distribution of guests vary across different countries, 
-- and are there specific countries that should be targeted for marketing efforts? 

SELECT Country, COUNT(`Booking ID`) AS TotalBookings
FROM booking
GROUP BY Country
ORDER BY TotalBookings DESC;

-- Is there a correlation between the country of origin 
-- and the likelihood of cancellations or extended stays? 
SELECT Country, AVG(CASE WHEN `Cancelled (0/1)` = 1 THEN 1 ELSE 0 END) AS CancellationRate,AVG(Nights) AS AvgNights
FROM booking
GROUP BY Country
ORDER BY CancellationRate DESC, AvgNights DESC;

-- Operational Efficiency: 

-- What is the average length of stay for guests, 
-- and how does it differ based on booking channels or customer types? 
SELECT `Distribution Channel`, `Customer Type`, AVG(Nights) AS AvgNights
FROM booking
GROUP BY `Distribution Channel`, `Customer Type`
ORDER BY AvgNights DESC;

-- Are there patterns in check-out dates that can inform staffing and resource allocation strategies? 
SELECT DATE_FORMAT('day', DATE_ADD(Arrival_Date, INTERVAL Nights DAY)) AS CheckOutDate, COUNT(`Booking ID`) AS TotalCheckOuts
FROM booking
GROUP BY CheckOutDate
ORDER BY CheckOutDate;

-- Impact of Deposit Types: 

-- How does the presence or absence of a deposit impact the likelihood of cancellations and revenue generation?
SELECT `Deposit Type`, 
    AVG(CASE WHEN `Cancelled (0/1)` = 1 THEN 1 ELSE 0 END) AS CancellationRate, 
    SUM(Revenue) AS TotalRevenue
FROM booking
GROUP BY `Deposit Type`
ORDER BY TotalRevenue DESC;

-- Can we identify any patterns in the use of deposit types across different customer segments?
SELECT `Customer Type`, `Deposit Type`, COUNT(`Booking ID`) AS TotalBookings
FROM booking
GROUP BY `Customer Type`, `Deposit Type`
ORDER BY TotalBookings DESC;

-- Analysis of Corporate Bookings: 

-- What is the proportion of corporate bookings, 
-- and how does their Average Daily Rate (ADR) compare to other customer types? 
SELECT `Customer Type`, COUNT(`Booking ID`) AS TotalBookings, AVG(`Avg Daily Rate`) AS AvgADR
FROM booking
GROUP BY `Customer Type`
ORDER BY TotalBookings DESC;

-- Are there specific trends or patterns related to corporate bookings that can inform business strategies? 
SELECT DATE_FORMAT('month', Booking_Date) AS Month, COUNT(`Booking ID`) AS CorporateBookings
FROM booking
WHERE `Customer Type` = 'Corporate'
GROUP BY Month
ORDER BY Month;

-- Time-to-Event Analysis: 

-- How does the time between booking 
-- and arrival date (lead time) affect revenue and the likelihood of cancellations? 
SELECT `Lead Time`, AVG(Revenue) AS AvgRevenue, AVG(CASE WHEN `Cancelled (0/1)` = 1 THEN 1 ELSE 0 END) AS CancellationRate
FROM booking
GROUP BY `Lead Time`
ORDER BY `Lead Time`;

-- Are there specific lead time ranges that are associated with higher customer satisfaction or revenue? 
SELECT `Lead Time`, AVG(Revenue) AS AvgRevenue, AVG(CASE WHEN `Cancelled (0/1)` = 0 THEN 1 ELSE 0 END) AS SatisfactionRate
FROM booking
GROUP BY `Lead Time`
ORDER BY AvgRevenue DESC;

-- Comparison of Online and Offline Travel Agents: 

-- What is the revenue contribution of online travel agents compared to offline travel agents? 
SELECT `Distribution Channel`, SUM(Revenue) AS TotalRevenue
FROM booking
GROUP BY `Distribution Channel`
ORDER BY TotalRevenue DESC;

-- How do cancellation rates and revenue vary between bookings made through online and offline travel agents? 
SELECT `Distribution Channel`, AVG(CASE WHEN `Cancelled (0/1)` = 1 THEN 1 ELSE 0 END) AS CancellationRate, 
		SUM(Revenue) AS TotalRevenue
FROM booking
GROUP BY `Distribution Channel`
ORDER BY TotalRevenue DESC;
