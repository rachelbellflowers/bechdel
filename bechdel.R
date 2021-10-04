library(pacman)
p_load(data.table, tidyverse, sqldf, DT, reactable, flexdashboard, htmlwidgets, bslib)

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-09/readme.md

# Import

raw_bechdel <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')

movies <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv', select = c(1:33))

# Cleaning
movies <- movies[order(title)]

raw_bechdel <- raw_bechdel[year < 2014][order(title)]

movies$title <- gsub("&amp;", "&", movies$title)

movies$title <- gsub("&#39;", "'", movies$title)

movies$title <- gsub("&agrave;","à", movies$title)

movies$title <- gsub("&auml;","ä", movies$title)

movies$title <- gsub("&aring;","å", movies$title)

movies$title <- gsub("&uuml;","ü", movies$title)

###

raw_bechdel$title <- gsub("&amp;", "&", raw_bechdel$title)

raw_bechdel$title <- gsub("&#39;|â€™", "'", raw_bechdel$title)

raw_bechdel$title <- gsub("&quot;","\"", raw_bechdel$title)

###

# Join
movbech <- raw_bechdel[movies, on = .(title, year)]

movbech[, budget_2013_mean := mean(budget_2013), by = binary]

# Graphs

ggplot(movbech, aes(budget_2013, binary)) +
 geom_bar(stat="summary", fun = mean)



