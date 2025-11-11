🍿 Netflix Movie Data: An Exploratory Data Analysis in R

project-overview

This repository contains an R project performing an Exploratory Data Analysis (EDA) on a dataset of Netflix movies. The goal of this analysis is to load, clean, and visualize the data to uncover patterns, identify trends, and understand the relationships between movie genres, popularity, and audience ratings.

The entire analysis is contained in the EDA.R script, which is heavily commented to explain each step of the process.

🎞️ Key Questions Answered

This analysis uses data visualization to answer several key questions about the Netflix movie library:

What are the most common movie genres available on the platform?

What is the statistical distribution of movie popularity?

How has the number of movie releases changed over time (since 1980)?

Which genres tend to have the highest (median) popularity?

What is the relationship between a movie's popularity and its vote count?

Is there a correlation between a movie's vote count and its average rating?

🛠️ Methodology

The analysis follows a clear and structured process:

1. Data Loading & Cleaning

Load Data: The dataset is loaded from a CSV file using read_csv.

Clean Columns: The irrelevant Poster_Url column is removed.

Tidy Genres: The most critical cleaning step! The Genre column (e.g., "Action, Comedy, Drama") is "exploded" using tidyr::separate_rows. This transforms the data into a tidy format where each movie-genre pair gets its own row, enabling accurate genre analysis.

2. Data Visualization (with ggplot2)

A series of plots are generated to answer the key questions:

Genre Frequency: A horizontal bar chart (geom_bar) ordered by frequency (fct_infreq) to find the most common genres.

Popularity Distribution: A histogram (geom_histogram) with a log-scaled x-axis (scale_x_log10) to visualize the highly skewed popularity data.

Releases Over Time: A bar chart (geom_bar) showing the count of movie releases per year, filtered for post-1980.

Popularity by Genre: A boxplot (geom_boxplot) to compare the distribution of popularity for each genre, reordered by median popularity (fct_reorder).

Popularity vs. Engagement: A scatter plot (geom_point) on a log-log scale with a linear trend line (geom_smooth) to analyze the relationship between Vote_Count and Popularity.

3. Correlation Analysis

Correlation Matrix: A correlation matrix is calculated for the key numeric variables (Popularity, Vote_Count, Vote_Average, Release_Year).

Heatmap: The matrix is visualized as a heatmap with corrplot to easily identify the strength and direction of relationships.

📈 Key Findings

Popularity is Skewed: Movie popularity is not normally distributed. The vast majority of movies have a low popularity score, with a "long tail" of a few extremely popular hits.

Popularity & Engagement are Linked: There is a strong, positive correlation between Vote_Count and Popularity. This suggests that "popularity" is heavily driven by user engagement (i.e., how many people vote on a movie).

Quality vs. Engagement: A positive, though less strong, relationship exists between Vote_Count and Vote_Average. Movies with a very high number of votes also tend to have a slightly higher average rating.

Genre Trends: The bar and boxplots reveal which genres (e.g., Dramas, Comedies) dominate the platform and which ones (e.g., Animation, Fantasy) tend to have a higher median popularity.

🚀 How to Run

Clone this repository:

git clone [https://github.com/your-username/DSA-Mini-Project.git](https://github.com/your-username/DSA-Mini-Project.git)



Open the project in RStudio.

Install the required packages (if you don't have them already):

install.packages("tidyverse")
install.packages("janitor")
install.packages("corrplot")



Important: Place your Netflix Movies data.csv file in a folder named data within the project directory. The script expects the file at this path: data/Netflix Movies data.csv.

Run the EDA.R script. The plots will be generated in the RStudio "Plots" pane.

🔧 Tools Used

R (v4.0+)

RStudio

Tidyverse (a collection of R packages)

ggplot2: For all data visualizations.

dplyr: For data manipulation (select, filter).

tidyr: For data cleaning (separate_rows).

readr: For loading the CSV (read_csv).

janitor: For general data cleaning utilities.

corrplot: For visualizing the correlation matrix.
