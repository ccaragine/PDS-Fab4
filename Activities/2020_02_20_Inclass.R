rm(list = ls())
library(tidyverse)

mayors<-read_csv(file="https://raw.githubusercontent.com/jmontgomery/jmontgomery.github.io/master/PDS/Datasets/Mayors.csv")
tweets<-read_csv("C:/Users/cmcar/Dropbox/School/Stats/Tweets.csv/Tweets.csv")

#LydaKrewson
lydatweets = tweets %>%
  filter(ScreenName == "lydakrewson")

#Number of tweets
num_tweets = length(str_split(lydatweets$Text, pattern  = " "))

#Mean number of words
mean_words = length(unlist(str_split(lydatweets$Text, pattern  = " ")))/num_tweets[1]

#Number of unique words
num_unique_words = length(unique(unlist(str_split(lydatweets$Text, pattern  = " "))))

#First five characters of unique words
unique_words = unique(unlist(str_split(lydatweets$Text, pattern  = " ")))
sub_words = str_sub(unique_words,1,5)
length(unique(sub_words))

#Number of tweets with 'polic'
sum(str_detect(str_to_lower(lydatweets$Text),pattern = 'polic'))

#Number of tweets with 'police'
sum(str_detect(str_to_lower(lydatweets$Text),pattern = 'police'))

#Number of tweets with a link
sum(str_detect(str_to_lower(lydatweets$Text),pattern = 'http'))


#################ACTIVITY FOR CLASS#########################

#######1
#number of tweets that mention police
sum(str_detect(str_to_lower(tweets$Text),pattern = 'police|policing|cops|law enforcement'))
sum(str_detect(str_to_lower(tweets$Text),pattern = 'black lives matter|blm'))

#vector of logicals where these appear
copmatch <- str_detect(str_to_lower(tweets$Text),pattern = 'police|policing|cops|law enforcement')
blmmatch <- str_detect(str_to_lower(tweets$Text),pattern = 'black lives matter|blm')

#######2
# merging data sets
tweets <- rename(tweets, TwitterHandle=ScreenName)
mayors$TwitterHandle

maytweet <- merge(mayors, tweets, by="TwitterHandle")
head(maytweet)  

# percent of tweets containing police for each mayor
mayortweets <- NULL
num_tweets_mayors <- NULL
percent <- NULL

for (i in maytweet$TwitterHandle){
  mayortweets <- maytweet %>%
    filter(TwitterHandle == "i")
  num_tweets_mayors <- length(str_split(mayortweets$Text, pattern  = 'police'))
  percent[i] <- num_tweets_mayors/nrow(mayortweets$TweetID) }


for (i in maytweet$TwitterHandle){
  mayortweets <- maytweet[ which(maytweet$TwitterHandle=='i' ), ]
  if(nrow(mayortweets$TweetID == 0))
    next 
  num_tweets_mayors <- length(str_split(mayortweets$Text, pattern  = 'police'))
  percent[i] <- num_tweets_mayors/nrow(mayortweets$TweetID) }
