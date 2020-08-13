# That cleanOutput() function  is nonsense
# something like lapply(F1000_v2, function(x) gsub("(\n|\r|\\s+)", " ", x) ) 
#  will strip the \t \r \n and bunches of spaces out of the text (but returns a list variable)
#For future reference to a simplified example dataset for stackoverflow or wherever: 
#dat <- data.frame(one="\r\n Something", two="\n\n\n another one")



setwd("Set path of the folder on your computer")


F1000 <- read.table("F1000_urls.txt", col.names = "urls", stringsAsFactors = F)

F1000$url.ID <- c(1:dim(F1000)[1])  #rownames



head(F1000)

# The HTML nodes got from selector gadget is mentioned below along with the category:
# Author name: .authors
# Affliations: .affiliations
# Grant Information: .grant-information
# Data Availability: #article1-body
# Date of the referee report: .referee-report-details-box
# Status of the referee report: .referee-report-status-line
# Referee name and affliation: .padding-left div
# Date of author's information: .commenter-role
# Referee report content: .referee-report-content
# Author response: .comment-content


library(rvest)
library(dplyr)



###################################### Option 2 (I like this one better)########################
library(rvest)
library(dplyr)

# You can also keep with the piping (%>%) idiom all the way through and (if needed) append a column with the extracted text back to the original data frame or keep it as a vector. The method below also make the code a bit more readable.
extract <- function(x, css) {
  # this catches retrieval errors
  pg <- try(html(x), silent=TRUE)
  # if any retrieval error, return NA
  if (inherits(pg, "try-error")) { 
    return(NA) 
  }
  pg %>% 
    html_nodes(css) %>%
    html_text -> element
  # if there is no matching element the resule will be a 0 length list
  # which will prevent sapply from simplifying it, so test for that here
  element <- ifelse(length(element) == 0, NA, element)
  element
}


# add as a column to the original data frame
# Author name: .authors
F1000 %>% mutate(authors=sapply(as.character(urls), extract, ".authors")) -> F1000

head(F1000$authors)

glimpse(F1000)


# or just get it out as a separate vector

# F1000$authors2 %>%   ####try F1000$url if F1000$authors2 yeilds error
#   as.character %>%
#   sapply(extract, ".authors")


# Affliations: .affiliations
F1000 %>% mutate(affliations=sapply(as.character(urls), extract, ".affiliations")) -> F1000
glimpse(F1000)


# Grant Information: .grant-information
F1000 %>% mutate(grant=sapply(as.character(urls), extract, ".grant-information")) -> F1000

# Data Availability: #article1-body
F1000 %>% mutate(data.availability=sapply(as.character(urls), extract, "#article1-body")) -> F1000

# Date of the referee report: .referee-report-details-box
F1000 %>% mutate(referee.date=sapply(as.character(urls), extract, ".referee-report-details-box")) -> F1000

# Status of the referee report: .referee-report-status-line
F1000 %>% mutate(status=sapply(as.character(urls), extract, ".referee-report-status-line")) -> F1000

# Referee name and affliation: .padding-left div
F1000 %>% mutate(referee.name=sapply(as.character(urls), extract, " .padding-left div")) -> F1000

# Date of author's information: .commenter-role
F1000 %>% mutate(author.date=sapply(as.character(urls), extract, ".commenter-role")) -> F1000

# Referee report content: .referee-report-content
F1000 %>% mutate(referee.report=sapply(as.character(urls), extract, ".referee-report-content")) -> F1000

# Author response: .comment-content
F1000 %>% mutate(author.response=sapply(as.character(urls), extract, ".comment-content")) -> F1000
sapply(F1000, typeof)

##########################################################################################################
# write.csv(F1000, file = "F100_clean2.csv", row.names = F)

################################# Troublesome snippet#####################################################
#If you want to read in use

# setwd("~/2 Special Topics in Business Analytics/Project")  #your file path will be diffrent of course
# # does not matter what name you call the dataframe. I use F1000
# F1000 <- read.csv(file = "F100_clean2.csv", stringsAsFactors=FALSE) # original raw output
##########################################################################################################


F1000_v2 <- F1000
# remove unnecessary spaces
# For portability, 'whitespace' is taken as the character class [ \t\r\n] (space, horizontal tab, line feed, carriage return).
# library(stringr)





# cleanRefereeText <- function(x){
#   x <- gsub("Referee Report ","", x, perl=TRUE)
#   x
# }
#testing the functions
gsub("[ \t\r\n]{2,}", " ", F1000_v2[9:10, ]$affliations, perl=TRUE)
F1000_v2[9:10, ]$affliations <- gsub("[ \t\r\n]{2,}", " ", F1000_v2[9:10, ]$affliations, perl=TRUE)
F1000_v2[9:10, ]$affliations <- gsub("^\\s+|\\s+$", "", F1000_v2[9:10, ]$affliations, perl=TRUE)


F1000_v2$authors <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$authors)
F1000_v2$authors <- gsub("^\\s+|\\s+$", "", F1000_v2$authors)

F1000_v2$affliations <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$affliations)
F1000_v2$affliations <- gsub("^\\s+|\\s+$", "", F1000_v2$affliations)

F1000_v2$grant <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$grant)
F1000_v2$grant <- gsub("^\\s+|\\s+$", "", F1000_v2$grant)

F1000_v2$data.availability <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$data.availability)
F1000_v2$data.availability <- gsub("^\\s+|\\s+$", "", F1000_v2$data.availability)

F1000_v2$referee.date <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$referee.date)
F1000_v2$referee.date <- gsub("^\\s+|\\s+$", "", F1000_v2$referee.date)

F1000_v2$status <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$status)
F1000_v2$status <- gsub("^\\s+|\\s+$", "", F1000_v2$status)

F1000_v2$referee.name <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$referee.name)
F1000_v2$referee.name <- gsub("^\\s+|\\s+$", "", F1000_v2$referee.name)

F1000_v2$author.date <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$author.date)
F1000_v2$author.date <- gsub("^\\s+|\\s+$", "", F1000_v2$author.date)

F1000_v2$referee.report <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$referee.report)
F1000_v2$referee.report <- gsub("^\\s+|\\s+$", "", F1000_v2$referee.report)

F1000_v2$author.response <- gsub("[ \t\r\n]{2,}", " ", F1000_v2$author.response)
F1000_v2$author.response <- gsub("^\\s+|\\s+$", "", F1000_v2$author.response)

# remove Referee Report phrase
gsub("Referee Report","", F1000_v2[9:10, ]$referee.date, perl=TRUE)
F1000_v2$referee.date <- gsub("Referee Report","", F1000_v2$referee.date, perl=TRUE)

gsub("^\\s+|\\s+$", "", F1000_v2[9:10, ]$referee.date)
F1000_v2$referee.date <- gsub("^\\s+|\\s+$", "", F1000_v2$referee.date)

F1000_v2[9:10, ]$referee.report
sub(".*(?=\\bContinue reading)", "", F1000_v2[9:10, ]$referee.report, perl=TRUE) # includes "Continue reading"
sub(".*(?<=\\bContinue reading)", "", F1000_v2[9:10, ]$referee.report, perl=TRUE) # excludes "Continue reading"
F1000_v2$referee.report <- sub(".*(?<=\\bContinue reading)", "", F1000_v2$referee.report, perl=TRUE)


sapply(F1000_v2, typeof)


setwd("Name of the folder on your computer") #your file path will be different of course
write.csv(F1000_v2, file = "F1000_v3_clean2.csv", row.names = F)
#############################################################################
#If you want to look at the data after the above procedures 
##############################################################################

# read in use
# does not matter what name you call the dataframe. I use F1000
F1000_v3 <- read.csv(file = "F1000_v3_clean2.csv", stringsAsFactors=FALSE)
F1000_v3$referee.report

# Reference ######################################################################################                                                                                                                                                                                                                                                                                                                                       https://en.wikipedia.org/wiki/Dog 


# http://stackoverflow.com/questions/30586480/submit-urls-from-a-data-frame-column-using-rvest?rq=1
#http://stackoverflow.com/questions/27832757/how-can-i-use-a-loop-to-scrape-website-data-for-multiple-webpages-in-r
#http://zevross.com/blog/2015/05/19/scrape-website-data-with-the-new-r-package-rvest/
# 
# 
# F1000_v2 <- F1000[1:5,]
# dput(F1000_v2)
