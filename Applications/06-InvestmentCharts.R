# http://www.r-bloggers.com/analyze-gold-demand-and-investments-using-r/

####################################
library(quantmod)
loadSymbols(c('^XAU', 'GLD', 'IAU'))


chartSeries(GLD)
chartSeries(GLD - IAU)
getMetals('gold', from='2010-01-01')

gold.demand=matrix(c(
  49.9,60.2,66.3,70.1,69.9,
  16.0,20.2,17.8,19.9,20.3,
  13.1,13.3,13.3,13.3,13.0,
  -28.1,70.8,85.6,58.6,89.7,
  69.4,56.0,48.9,54.2,50.0,
  3.9,13.8,17.7,21.2,17.2,
  99.2,48.2,36.2,50.5,25.6), nrow=7,ncol=5, byrow=TRUE)

rownames(gold.demand)=c('Electronics','Other Industrial','Dentistry','Bar Hoarding','Official Coin','Medals/Imitation Coin','Other identified retail invest')
colnames(gold.demand)=c('2009-Q1','2009-Q2','2009-Q3','2009-Q4','2010-Q1')

data=t(gold.demand)

# The "melt" function in the reshape library
# breaks out the cross tab organization into individual records.
library(reshape)

melted_gold=melt(gold.demand)
colnames(melted_gold)=c('Name','Quarter','Value')
####################################
library(ggplot2)
qplot(Quarter, Value, data=melted_gold, fill=Name, geom="bar" ) +
  theme(title='2009-2010 Gold Demand')


####################################
ggplot(melted_gold, aes(Quarter, Value)) + geom_bar() + facet_wrap(~Name)
####################################
ggplot(melted_gold, aes(Quarter, Value, fill=Name)) + 
  geom_bar(stat="identity") + 
  facet_wrap(~Name, nrow=4) + 
  coord_flip()

