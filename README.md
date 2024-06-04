
---

# SHG Booking Data Analysis

## Introduction

This project analyzes booking data for Splendor Hotel Groups (SHG) using Tableau. It includes data cleaning, parameter creation, calculated fields, and various visualizations to gain insights into booking trends, distribution channels, and revenue.

## Project Structure

1. **Data Preparation**: Cleaning and transforming raw data.
2. **Parameter Creation**: Dynamic filtering using parameters.
3. **Calculated Fields**: Creating metrics and derived fields.
4. **Visualizations**: Various charts and graphs for analysis.

## Data Preparation

### Cleaning Data

1. **Remove Dollar Signs and Convert Data Type**:
    ```sql
    UPDATE booking
    SET `Avg Daily Rate` = REPLACE(`Avg Daily Rate`, '$', '');
    
    ALTER TABLE booking
    MODIFY COLUMN `Avg Daily Rate` DECIMAL(10, 2);
    ```

## Parameter Creation

1. **Create Parameter**:
    - Name: `Select Distribution Channel`
    - Data Type: `String`
    - Values: `Online`, `Direct`, `Travel Agent`, `Corporate`

2. **Show Parameter Control**: Right-click the parameter and select `Show Parameter Control`.

## Calculated Fields

1. **Filtered Distribution Channel**:
    ```sql
    [Distribution Channel] = [Select Distribution Channel]
    ```

## Visualizations

### 1. Bookings by Distribution Channel (Bar Chart)
- **Steps**:
  1. Drag `Distribution Channel` to Columns.
  2. Drag `Booking ID` to Rows and set to `Count`.

### 2. Booking Trends Over Time (Line Chart)
- **Steps**:
  1. Drag `Booking Date` to Columns (month).
  2. Drag `Booking ID` to Rows and set to `Count`.

### 3. Bookings Heat Map
- **Steps**:
  1. Drag `Booking Date` to Columns (day/month).
  2. Drag `Distribution Channel` to Rows.
  3. Drag `Booking ID` to Text and set to `Count`.

### 4. Revenue Distribution by Channel (Pie Chart)
- **Steps**:
  1. Drag `Revenue` to Rows.
  2. Change mark type to `Pie`.
  3. Drag `Distribution Channel` to Color.

### 5. Revenue by Channel and Month (Treemap)
- **Steps**:
  1. Drag `Distribution Channel` to Rows.
  2. Drag `Booking Date` to Columns (month).
  3. Drag `Revenue` to Size and Color.

### 6. Average Daily Rate Distribution (Histogram)
- **Steps**:
  1. Drag `Avg Daily Rate` to Rows.
  2. Change mark type to `Bar`.
  3. Drag `Avg Daily Rate` to Columns.

### 7. Revenue vs. Booking Duration (Scatter Plot)
- **Steps**:
  1. Calculate duration: `DATEDIFF('day', [Check-in Date], [Check-out Date])`.
  2. Drag calculated field to Columns.
  3. Drag `Revenue` to Rows.

### 8. Bookings by City and Channel (Bubble Chart)
- **Steps**:
  1. Drag `City` to Columns.
  2. Drag `Booking ID` to Rows (Count).
  3. Change mark type to `Circle`.
  4. Drag `Distribution Channel` to Color.
  5. Drag `Booking ID` to Size.

## Conclusion

The SHG Booking Data Analysis project provides interactive Tableau visualizations to help make data-driven decisions. For any questions, refer to the project documentation or contact the project team.

---

This README is concise and focuses on the essential steps and instructions for using and understanding the analysis.
