library(dplyr)
library(ggplot2)
library(tidyr)
d<-read.csv("911.csv")
d$Date<-as.Date(d$timeStamp)
d<-separate(d,col=title,into=c("Type","SubType"),sep=":")
d$SubType<-gsub(" -","",d$SubType)
bD<-d%>%group_by(Date)%>%summarise(Total=n())
ggplot(bD,aes(Date,Total))+geom_line(color="red")
bDT<-d%>%group_by(Date,Type)%>%summarise(Total=n())
ggplot(bDT,aes(Date,Total))+geom_line(aes(color=Type))
tT<-as.data.frame(table(d$SubType))
tT<-tT[order(-tT$Freq),]
t10ST<-tT[1:10,]
ggplot(t10ST,aes(reorder(Var1,Freq),Freq,fill=Var1))+geom_bar(stat="identity")+theme(legend.position="none")+ggtitle("Emergency Calls")+xlab("Subtype")+ylab("No. of 911 Calls")+coord_flip()
tTp<-as.data.frame(table(d$twp))
tTp<-tTp[order(-tTp$Freq),]
t10Tp<-tTp[1:10,]
names(t10Tp)<-c("Twp","Total")
t10Tp$Twp<-factor(t10Tp$Twp)
ggplot(d[d$twp%in%t10Tp$Twp,],aes(twp,fill=Type))+geom_bar(position="dodge")+theme(axis.text.x=element_text(angle=45,vjust=0.5))+xlab("Township")+ggtitle("Type of calls in Top 10 Towns")
