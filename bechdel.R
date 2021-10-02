library(pacman)
p_load(ggplot2, data.table, openxlsx, DT, reactable, flexdashboard)

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2021/2021-03-09/readme.md

raw_bechdel <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')

movies <- fread('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv')

#movies[, grep(c("amp"), names(movies)), with = FALSE]

# with

movies$title <- gsub("&amp;", "&", movies$title)

movies$title <- gsub("&#39;", "'", movies$title)

raw_bechdel$title <- gsub("&amp;", "&", raw_bechdel$title)

raw_bechdel$title <- gsub("&#39;|â€™", "'", raw_bechdel$title)

raw_bechdel$title <- gsub("&quot;", , raw_bechdel$title))  

movies <- movies[order(title)]
raw_bechdel <- raw_bechdel[order(title)]
