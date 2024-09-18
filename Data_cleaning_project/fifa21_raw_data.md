
Data analysis often begins with one of the most challenging steps: cleaning messy, unorganized datasets. In this project, I’ll use Python to clean and explore a raw FIFA 21 dataset containing detailed player information, including ratings, positions, and financial data. The dataset, sourced from Kaggle, has common issues like missing values, duplicates, inconsistent data types, and formatting errors.

To make this happen, I’m using Visual Studio as my coding environment, with the Python extension to streamline the process. I aim to utilize Python’s powerful libraries, such as Pandas and NumPy, to transform this messy dataset into a clean, structured format.
Upon a thorough review of the dataset, I found that it comprises two Excel files containing player information. However, these files exhibit several inconsistencies that hinder effective data integration and analysis. To enable meaningful analysis, it is important to first align the data columns between the two files.

Data Issues Identified
When working with the FIFA 21 dataset, I encountered several key issues that needed to be addressed before any analysis could take place. Below are the main problems identified during the data cleaning process:

Inconsistent Column Names:
Both Excel files contained columns representing the same data but with different names, making it impossible to merge the datasets directly.
Solution: Standardized the column names across both files to allow for proper integration.
Line Breaks and Special Characters:
Some columns contained unwanted line breaks or special characters (such as asterisks), affecting data readability and consistency.
Solution: Removed the line breaks and special characters to clean the data for further analysis.
Different Units of Measurement:
The dataset had inconsistent units across the files, with some columns using different measurement systems (e.g., wages in different currencies or player values in varying formats).
Solution: Converted all values to a common unit to ensure accurate comparisons and consistency.
Formatting and Data Type Discrepancies:
Various columns had mixed data types (e.g., numerical data stored as strings), leading to processing issues.
Solution: Corrected the data types to ensure that numerical and categorical data were handled appropriately.
By addressing these inconsistencies, I will prepare a unified dataset that facilitates comprehensive analysis and provides reliable insights into the player data from FIFA 21.

import pandas as pd
import re #for regular expressions
from datetime import datetime #for datetime query
import matplotlib.pyplot as plt #for ploting

# Load both csv files
csv_dat_v1 = pd.read_csv("fifa21_raw_data.csv")
csv_dat_v2 = pd.read_csv("fifa21_raw_data_v2.csv")

# View the data values of both files
print(csv_dat_v1.head())
print(csv_dat_v2.head())

# Make some changes to make both files look alike so we can concat
# Split the 'Club_Info' into 'Club_Name' and 'Years'
csv_dat_v1['Club'] = csv_dat_v1['Team & Contract'].str.extract(r'([A-Za-z\s]+)')
csv_dat_v1['Contract'] = csv_dat_v1['Team & Contract'].str.extract(r'(\d{4} ~ \d{4})')

# Drop column if needed
csv_dat_v1 = csv_dat_v1.drop('Team & Contract', axis=1)

# Renaming columns
csv_dat_v1 = csv_dat_v1.rename(columns={'foot': 'Preferred Foot', 'BP': 'Best Position'})


# Definig function to convert height in format like 5'7" to centimeters
def height_to_cm(height):
    # Use regex to capture feet and inches from the format
    match = re.match(r"(\d+)'(\d+)\"", height)
    if match:
        feet = int(match.group(1))
        inches = int(match.group(2))
        total_cm = (feet * 30.48) + (inches * 2.54)  # Convert to cm
        return round(total_cm)
    return None  # If the format doesn't match, return None


# Function to remove 'lbs' and convert to kg
def convert_lbs_to_kg(weight):
    if isinstance(weight, str):
        # Remove 'lbs' and convert to float, then multiply by 0.453592
        weight = weight.replace('lbs', '').strip()  # Remove 'lbs' and whitespace

        return round (float(weight) * 0.453592)
    return None  # Handle cases where the value is not a string


# Function to convert wage to numeric
def convert_money(conversion_number):
   # print("converion number" + str(conversion_number))
    if isinstance(conversion_number, str):
        # Remove currency symbols
        conversion_number = conversion_number.replace('$', ' ').replace('€', ' ').replace('£', ' ').strip()
        
        # Check if 'M' or 'K' is present
        if 'M' in conversion_number:
            return float(conversion_number.replace('M', ' ').strip()) * 1_000_000
        elif 'K' in conversion_number:
            return float(conversion_number.replace('K', ' ').strip()) * 1_000
    return None  # Handle cases where the value is not a string or does not contain 'M' or 'K'


# Apply the conversion to the 'Weight' column
csv_dat_v1['Weight_kg'] = csv_dat_v1['Weight'].apply(convert_lbs_to_kg)

# Apply the conversion to the 'Height' column and create a new column 'Height_cm'
csv_dat_v1['Height_cm'] = csv_dat_v1['Height'].apply(height_to_cm)

# Optionally, drop the original Height and weight column
csv_dat_v1 = csv_dat_v1.drop('Height', axis=1)
csv_dat_v1 = csv_dat_v1.drop('Weight', axis=1)

# Rename it to weight and height name .
csv_dat_v1 = csv_dat_v1.rename(columns={'Weight_kg': 'Weight', 'Height_cm': 'Height'})

# Concatenate the two DataFrames
combined_df = pd.concat([csv_dat_v1, csv_dat_v2])

# Reset the index (optional, especially if you want a clean index)
combined_df = combined_df.reset_index(drop=True)

# Function to remove newline characters from all columns
combined_df = combined_df.replace('\n', ' ', regex=True)

# This will create a CSV file named 'combined_fifa_data_file.csv'

# Convert the 'Joined' column to datetime
combined_df['Joined'] = pd.to_datetime(combined_df['Joined'], errors='coerce')

# Get the current date
current_date = datetime.now()

# Calculate the number of years each player has been at the club
combined_df['Years_at_Club'] = round((current_date - combined_df['Joined']).dt.days / 365.25)  # Divide by 365.25 to account for leap years

# Filter players who have been at the club for more than 10 years
df_more_than_10_years = combined_df[combined_df['Years_at_Club'] > 10]

# Display the players with more than 10 years at the club
print(df_more_than_10_years[['Name', 'Joined', 'Years_at_Club']])


# Replace star values from three columns 

# Ensure the column is of string type
combined_df['W/F'] = combined_df['W/F'].astype(str)
combined_df['SM'] = combined_df['SM'].astype(str)
combined_df['IR'] = combined_df['IR'].astype(str)

# Replace '★' with a space
combined_df['W/F'] = combined_df['W/F'].str.replace('★', ' ', regex=False)
combined_df['SM'] = combined_df['SM'].str.replace('★', ' ', regex=False)
combined_df['IR'] = combined_df['IR'].str.replace('★', ' ', regex=False)


# Apply the conversion function to the 'Wage' column, 'Value' and 'Relaese Clause' 
combined_df['Wage'] = combined_df['Wage'].apply(convert_money)
combined_df['Value'] = combined_df['Value'].apply(convert_money)
combined_df['Release Clause'] = combined_df['Release Clause'].apply(convert_money)

#ploting of wage and valu to findout Which players are highly valuable but still underpaid (on low wages)

# Scatter plot from DataFrame
combined_df.plot.scatter(x='Value', y='Wage' , color='green', s=80)

# Display the plot
plt.show()


# Save the combined DataFrame to a new CSV file
combined_df.to_csv('combined_fifa_data_file.csv', index=False)
Data cleaning is an essential step before any meaningful analysis. By resolving inconsistencies in column names, units, and formatting, I transformed the messy FIFA 21 dataset into a clean, structured form. With this foundation in place, the dataset is now ready for deeper exploration and valuable insights.

Beginners Project
Cleaning Data Python
