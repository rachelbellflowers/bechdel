library(pacman)
p_load(data.table, tidyverse, sqldf, DT, reactable, flexdashboard, htmlwidgets, bslib)

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-09/readme.md

#factors

# Import

raw_bechdel <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')

movies <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv', select = c(1:33))

# Cleaning

movies[movies=="N/A"] <- NA

movies <- movies[order(title)]

movies$title <- gsub("&amp;", "&", movies$title)

movies$title <- gsub("&#39;", "'", movies$title)

movies$title <- gsub("&agrave;","à", movies$title)

movies$title <- gsub("&auml;","ä", movies$title)

movies$title <- gsub("&aring;","å", movies$title)

movies$title <- gsub("&uuml;","ü", movies$title)

###

raw_bechdel <- raw_bechdel[year < 2014][order(title)]

raw_bechdel$title <- gsub("&amp;", "&", raw_bechdel$title)

raw_bechdel$title <- gsub("&#39;|â€™", "'", raw_bechdel$title)

raw_bechdel$title <- gsub("&quot;","\"", raw_bechdel$title)

###

# Joins and New Columns
movbech <- raw_bechdel[movies, on = .(title, year)]

movbech[, budget_2013_mean := mean(budget_2013), by = binary]

# Graphs

# level_order <- c('virginica', 'versicolor', 'setosa') #this vector might be useful for other plots/analyses

# ggplot(iris, aes(x = factor(Species, level = level_order), y = Petal.Width)) + geom_col()

eval_order <- factor(movbech$rated, level = c("G", "PG", "PG-13", "TV-PG", "TV-14", "R", "NC-17", "X", "Not Rated", "Unrated", "NA"))


ggplot(movbech, aes(eval_order))+
  geom_bar() +
  labs(title="Movie Ratings", x="Rating", y="Count") +
  theme_minimal()

ggplot(movbech, aes(binary)) +
  geom_bar() +
  labs(title="Bechdel Pass Rate", x="Rating", y="Count") +
  theme_minimal()

ggplot(movbech, aes(budget_2013, domgross_2013)) +
  geom_smooth(color="red", se=FALSE) +
  geom_line()

# grep("Harry Potter.*", movbech$title)

hp <- movbech[588:595]
