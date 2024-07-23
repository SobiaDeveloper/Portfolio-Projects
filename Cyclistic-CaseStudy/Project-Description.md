# How Does a Bike-Share Navigate Speedy Success?

## Introduction

Welcome to the Cyclistic bike-share analysis case study! In this case study, will perform many real-world tasks of a junior dataanalyst for a fictional company.
Working as a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of
marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, your
team wants to understand how casual riders and annual members use Cyclistic bikes diff erently. From these insights, your team will
design a new marketing strategy to convert casual riders into annual members. But fi rst, Cyclistic executives must approve your
recommendations, so they must be backed up with compelling data insights and professional data visualizations.

## Goals:

Company has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do
that, however, the marketing analyst team needs to bett er understand how annual members and casual riders diff er, why casual
riders would buy a membership, and how digital media could aff ect their marketing tactics. Moreno and her team are interested in
analyzing the Cyclistic historical bike trip data to identify trends.

## Steps

 In order to answer the
key business question: 
* How do annual members and casual riders use Cyclistic bikes differently? *.I follow the steps of the data analysis process: ask, prepare, process, analyze, share, and act.

### Ask Phase

- What is the problem you are trying to solve?<br>
To find out the reasons and ways and differences between both rider types (casual and members).
- How can your insights drive business decisions?<br> 
It would help to understand what stops the casual riders to be a members.

### Prepare Phase

- Where is your data located?<br>
  Data is provided to download.
- How is the data organized<br>
  All Data is in excel sheet in rows and columns. All sheets contain the same columns. Each column define its meaning.
- Are there issues with bias or credibility in this data? Does your data ROCCC<br>
  As data is provided by own organization so there is no issues in the credibility of data. Data is reliable, original,  
  comprehensive, current and cited, that is ROCCC. 
- How are you addressing licensing, privacy, security, and accessibility?<br>
  As far as privacy and security concerns no account detail of customers are given well other data is easily accessible.
- How did you verify the data’s integrity?<br>
 As all of the data sheets have same column, same way of organizing data all formats are same.
- How does it help you answer your question<br>
  Seeing the data in the excel is hard to answer but through analyzing skills it definitely help to find all the answers.
- Are there any problems with the data?<br>
  Going through the data many of the values are missing.


###  Process

- What tools are you choosing and why?<br>
It is a huge amount of data, working in excel is a great mess so SQL(structured Query Language) is choosen to query the data.
● Have you ensured your data’s integrity?<br>
 I strive to maintain data integrity, by data validation, cleaing, security, documentations and assurance, which is essential for producing reliable insights and making informed decisions.
● What steps have you taken to ensure that your data is clean?<br>
steps considered are:<br>
-  I start by understanding the structure, format, and quality of the raw data.<br>
-  I identify missing data and decide on appropriate strategy.<br>
-   I check for and eliminate duplicate records, ensuring each data point is unique and contributes appropriately to the analysis.<br>
-   I standardize data formats (e.g., date formats, units of measurement) to ensure consistency and avoid discrepancies.<br>
-   I perform transformations<br>
-   Throughout these processes, I validate cleaned data to ensure that it meets quality standards and aligns with expected outcomes.<br>
  
● How can you verify that your data is clean and ready to analyze?<br>
In order to crosss check Data is clean and ready to analyze I asked for peer review and validation.<br>


● Have you documented your cleaning process so you can review and share those results?<br>
Yes, I have documented all cleaning steps .<br>

## Analyze
● How should you organize your data to perform analysis on it?<br>
First, all the different excel sheets ate populated in sql single table, all the column names are define according to their work.


● Has your data been properly formatted?<br>
Yes, data has been properly formatted.

● What surprises did you discover in the data?<br>
 Discovered a notable insight during our analysis: despite casual riders having significantly longer average ride durations, the number of rides taken by members far exceeds those taken by casual users. This discovery underscores the importance of data visualization in revealing such insights, as they are not readily apparent through data scrutiny alone.
 
● What trends or relationships did you find in the data?<br>
In our analysis, several noteworthy trends and relationships have emerged from the data:<br>

Membership vs. Casual Usage: We observed that while casual riders tend to have longer average ride durations, <br>the volume of rides taken by members significantly surpasses that of casual users.<br><br>

Days Variations: There is a clear pattern in ride frequency, with peak usage occurring during weekends. Casual rides are more on weekends<br><br>

Geographical Insights: Geographic analysis revealed varying usage patterns across different regions, suggesting potential opportunities for targeted marketing campaigns or operational optimizations.<br><br>

These insights were derived through rigorous data analysis and visualization techniques, enabling us to uncover nuanced trends and relationships that inform our strategic decisions moving forward.<br><br>

● How will these insights help answer your business questions?<br>
The insights derived from our data analysis will significantly contribute to addressing key business questions and informing strategic decisions in the following ways:<br><br>

Optimized Resource Allocation: By understanding the variations in ride frequency and the geographic distribution of user preferences, we can allocate resources more effectively. <br><br>

Targeted Marketing Strategies: Insights into user demographics and behavior will enable us to tailor marketing campaigns more precisely. For example, we can design promotions that resonate with different user segments based on their preferences and usage patterns, potentially increasing customer acquisition and retention rates.<br><br>

Enhanced Customer Experience: Understanding the preferences and behaviors of different user segments allows us to personalize the customer experience. We can introduce features or services that cater to specific needs identified through the analysis, thereby enhancing overall satisfaction and loyalty.<br><br>

Strategic Growth Initiatives: The identification of trends such as the dominance of member rides despite longer casual ride durations provides strategic direction. We can prioritize initiatives that encourage casual users to convert into members, potentially increasing recurring revenue and strengthening our market position.

## Share
As for share, I have created a presentation accessible and share with all stakeholders and team members including some recommendations at the end.
Some glimpse of the report is shown here
First of all, member and casual riders are compared by the type of bikes they are using.



Next the number of trips distributed by the months, days of the week and hours of the day are examined.


Ride duration of the trips are compared to find the differences in the behavior of casual and member riders.

To further understand the differences in casual and member riders, locations of starting and ending stations can be analysed. Stations with the most trips are considered using filters to draw out the following conclusions.



