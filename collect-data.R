###############################################################################
## Script to pull down and work through the College Scorecard Data
## @brocktibert
## September 14, 2015
###############################################################################

options(stringsAsFactors=F)

## load the libraries
library(stringr)
library(dplyr)


#====================================================
## Download the large dataset
#====================================================

## get the data
URL = "https://s3.amazonaws.com/ed-college-choice-public/CollegeScorecard_Raw_Data.zip"
download.file(URL, destfile = "data/scorecard.zip")

## unzip it
unzip("data/scorecard.zip", exdir = "data")


#====================================================
## stack the data files
#====================================================

FILES = list.files("data/CollegeScorecard_Raw_Data/", full.names = TRUE)
FILES = FILES[str_detect(FILES, pattern = "MERGED")]

scorecard = data.frame()

for (FILE in FILES) {
  ## bring in the data
  tmp = read.csv(FILE)
  colnames(tmp) = tolower(colnames(tmp))
  ## extract the year from the file name
  YEAR = str_extract(FILE, "[0-9]{4}")
  ## append that year to the file
  tmp$year = YEAR
  ## fix problem columns that change types-- because why wouldnt they?
  tmp$zip = as.character(tmp$zip)
  tmp$st_fips = as.character(tmp$st_fips)
  tmp$region = as.character(tmp$region)
  tmp$control = as.character(tmp$control)
  tmp$opeid = as.character(tmp$opeid)
  ## append the data
  scorecard = bind_rows(scorecard, tmp)
  ## cleanup
  rm(tmp, YEAR)
  cat("finished ", FILE, "\n")
} 

#====================================================
## write the data
#====================================================

saveRDS(scorecard, file="scorecard.rds")
save(scorecard, file="scorecard.Rdata")
write.table(scorecard, file="scorecard.csv", sep=",", row.names=F, na="")
