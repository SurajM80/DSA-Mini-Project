library(tidyverse)
install.packages("janitor")
library(janitor)

#Library : dplyr, ggplot2 used
#-------------------------------------------------------------------------------
#Understanding Dataset

df = read_csv("data/Netflix Movies data.csv")
View(df)
colnames(df)
head(df,10)
#-------------------------------------------------------------------------------
#
df_clean <- df %>%
  separate_rows(Genre, sep = ", ")
print(head(df_clean))


df <- df %>%
  select(-Poster_Url) #removed Url column

view(df)

#-------------------------------------------------------------------------------
# Questions
#Question 1: What are the most common movie genres?
# 1. Explode the Genre column (the fix)
df_clean <- df %>%
  separate_rows(Genre, sep = ", ")
# 2. Convert Genre to a factor for plotting
df_clean$Genre <- as.factor(df_clean$Genre)
# 3. (Optional) Check the result
print(head(df_clean))
#--------------------
#plot the graph---
ggplot(df_clean, aes(y = fct_infreq(Genre))) +
  geom_bar(fill = "steelblue") +
  labs(title = "Frequency of Movie Genres",
       x = "Count of Movies",
       y = "Genre") +
  theme_minimal()

#-------------------------------------------------------------------------------

#Question 2: What is the distribution of movie popularity?
ggplot(df, aes(x = Popularity)) +
  geom_histogram(bins = 40, fill = "darkgreen", alpha = 0.7) +
  scale_x_log10() +  # Use a log scale for better visibility
  labs(title = "Distribution of Movie Popularity (Log Scale)",
       x = "Popularity (Log Scale)",
       y = "Frequency") +
  theme_minimal()

#-------------------------------------------------------------------------------

#Question 3: How has the number of movies released changed over time?
# We can filter to see recent history, e.g., after 1980
df %>%
  filter(Release_Year > 1980) %>%
  ggplot(aes(x = Release_Year)) +
  geom_bar(fill = "blue") +
  labs(title = "Movie Entries Released Per Year (since 1980)",
       x = "Release Year",
       y = "Number of Movie-Genre Entries") +
  theme_minimal()
#-------------------------------------------------------------------------------

#Question 4: Which genres have the highest popularity?
# 3. Now, re-run the plot on the cleaned data
ggplot(df_clean, aes(x = Popularity, y = fct_reorder(Genre, Popularity, .fun = median))) +
  geom_boxplot(fill = "orange") + 
  scale_x_log10() + 
  labs(title = "Popularity Distribution by Genre",
       x = "Popularity (Log Scale)",
       y = "Genre") +
  theme_minimal()

#-------------------------------------------------------------------------------

#Question 5: Is there a relationship between popularity and vote count?
ggplot(df, aes(x = Vote_Count, y = Popularity)) +
  geom_point(alpha = 0.3, color = "purple") + # alpha makes dense points visible
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", color = "black") + # Add a trend line
  labs(title = "Popularity vs. Vote Count (Log/Log Scale)",
       x = "Vote Count (Log Scale)",
       y = "Popularity (Log Scale)") +
  theme_minimal()

#-------------------------------------------------------------------------------
#CORRELATIONS
#-------------------------------------------------------------------------------

#Is there a correlation between a "movie's popularity" and its vote count?
#(This is what we saw in Q5—as vote count goes up, popularity goes up.)

#Is there a correlation between a movie's vote count and its vote average?
#(Do movies with more votes tend to have higher or lower ratings?)

#Is there a correlation between a movie's release year and its popularity?
#(Are newer movies generally more popular in your dataset?)

#Is there a correlation between a movie's release year and its vote average? 
#(Have movie ratings generally gone up or down over time?)
#-------------------------------------------------------------------------------
install.packages("corrplot") #FOR VISUALIZATION
library(corrplot)
library(dplyr)

# 1. Select only the numeric columns from your ORIGINAL df
# We must use 'df' here, not 'df_clean'
df_numeric <- df %>%
  select(Popularity, Vote_Count, Vote_Average, Release_Year)

# 2. Calculate the correlation matrix
# 'complete.obs' handles any missing values
cor_matrix <- cor(df_numeric, use = "complete.obs")

# 3. Plot the heatmap
# 'method = "number"' writes the correlation score in each box
corrplot(cor_matrix, method = "number", type = "upper")
#-------------------------------------------------------------------------------

# Vote count Vs Vote Count Correlation.
ggplot(df, aes(x = Vote_Count, y = Vote_Average)) +
  geom_point(alpha = 0.3, color = "blue") +
  scale_x_log10() +  # Vote_Count is skewed, so use a log scale
  geom_smooth(method = "lm", color = "red", formula = y ~ log(x)) + # Add a trend line
  labs(title = "Vote Average vs. Vote Count (Quality vs. Engagement)",
       x = "Vote Count (Log Scale)",
       y = "Vote Average (Rating 0-10)") +
  theme_minimal()
