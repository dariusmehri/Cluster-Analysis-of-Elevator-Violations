
install.packages("stats")
library(stats)

install.packages("cluster")
library(cluster)

install.packages("fpc")
library(fpc)


teens <- read.csv("S:\\Office of Risk Management\\User Folders\\Darius Mehri\\Books and Articles\\Machine-Learning-with-R-datasets-master\\snsdata.csv")


str(teens)

names(teens)

#table with NA count
table(teens$gender, useNA = "ifany")


#check age
summary(teens$age)

#age has outliers so need to remove (keep ages 13 to 20, make NA all other ages:
teens$age <- ifelse(teens$age >= 13 & teens$age < 20, teens$age, NA)

#recode gender and gender NAs
teens$female <- ifelse(teens$gender == "F" & !is.na(teens$gender), 1, 0)
teens$no_gender <- ifelse(is.na(teens$gender), 1, 0)

#imputation for missing age values
mean(teens$age, na.rm = TRUE)

summary(teens$age)

aggregate(data = teens, age ~ gradyear, mean, na.rm = TRUE)

ave_age <- ave(teens$age, teens$gradyear, FUN = function(x) mean(x, na.rm = TRUE))

teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)

#The kmeans() function requires a data frame containing only numeric data and a
#parameter specifying the desired number of clusters.

#create a new data frame with 
interests <- teens[5:40]



#z score standardize, Since lapply() returns a matrix, it must be coerced back to data frame form using
#the as.data.frame() function.
interests_z <- as.data.frame(lapply(interests, scale))

set.seed(2345)
teen_clusters <- kmeans(interests_z, 5)
plotcluster(interests_z, teen_clusters$cluster, pch = teen_clusters$cluster)


#plot elbow method
plot(1:15, teen_clusters, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

summary(teen_clusters)
teen_clusters


#################################
# CLUSTER ANALYSIS CRANE ACCIDENTS

crane <- read.csv("S:\\Office of Risk Management\\User Folders\\Darius Mehri\\Crane Incidents\\Crane Accidents 2007-2016 Edit2.csv")

names(crane)

crane <-  crane[,c('Injury','DOB.Action','Record.Type.Description','Equipment.Details', 'Eqacctype') ]

table(crane$Fatality, useNA = "ifany")

unique(crane$Record.Type.Description)

#recode data
#recode, if injutry > 0 then code as 1, otherwise 0
crane$Injury <- ifelse(crane$Injury > 0, 1, 0)

#recode DOB Action, if element exists, =1, otherwise =0
crane$ECB_DOB_Violation_Served <- ifelse(crane$DOB.Action == "ECB and/or DOB Violation Served", 1, 0)
crane$No_Action_Necessary <- ifelse(crane$DOB.Action == "No Action Necessary", 1, 0)
crane$ECB_Violation <- ifelse(crane$DOB.Action == "ECB Violation", 1, 0)

crane$No_Dispatch <- ifelse(crane$DOB.Action == "No Dispatch", 1, 0)
crane$DOB_Violation <- ifelse(crane$DOB.Action == "DOB Violation", 1, 0)

crane$Stop_Work_Order<- ifelse(crane$DOB.Action == "Stop Work Order Served", 1, 0)

crane$Request_Report<- ifelse(crane$DOB.Action == "Request Report from PE/RA of Record", 1, 0)

#recode Record Type Description
crane$Record.Type.Description<- ifelse(crane$Record.Type.Description == "Accident", 1, 0)

unique(crane$Eqacctype)

#recode equipment details
crane$Tower_Crane <- ifelse(crane$Equipment.Details == "Tower Crane", 1, 0)
crane$Mobile_Truck_Crane <- ifelse(crane$Equipment.Details == "Mobile Truck Crane", 1, 0)
crane$Crawler_Crane <- ifelse(crane$Equipment.Details == "Crawler Crane", 1, 0)
crane$Truck_Crane <- ifelse(crane$Equipment.Details == "Truck Crane", 1, 0)

#
crane$Drop_load <- ifelse(crane$Eqacctype == "Drop Load", 1, 0)
crane$Eq_Collapsed <- ifelse(crane$Eqacctype == "Eq Collapsed", 1, 0)
crane$Eq_Damaged <- ifelse(crane$Eqacctype == "Eq Damaged", 1, 0)
crane$Eq_Hit_Building <- ifelse(crane$Eqacctype == "Eq Hit Building", 1, 0)
crane$Eq_Hit_Const_Installation <- ifelse(crane$Eqacctype == "Eq Hit Construction Installation", 1, 0)
crane$Eq_Hit_Worker <- ifelse(crane$Eqacctype == "Eq Hit Worker", 1, 0)
crane$Eq_Unsafe_Condition <- ifelse(crane$Eqacctype == "Eq Unsafe Condition", 1, 0)
crane$Other <- ifelse(crane$Eqacctype == "Other", 1, 0)

crane$DOB.Action <- NULL
crane$Eqacctype <- NULL
crane$Equipment.Details <- NULL

#Convert NAs in df column to 0
crane$Injury[is.na(crane$Injury)] <- 0

#z-score the dataframe
#crane <- as.data.frame(lapply(crane, scale))

#cluster
#plot elbow method to determine number of clusters
wss <- (nrow(crane)-1)*sum(apply(crane,2,var)) 
for (i in 2:15) wss[i] <- sum(kmeans(crane, centers=i)$withinss)
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

set.seed(12345)
crane_clusters <- kmeans(crane, 5)
#plotcluster(crane, crane_clusters$cluster, pch = crane_clusters$cluster)

plotcluster(crane, crane_clusters$cluster)

#crane <- as.numeric(crane)

clusplot(crane, crane_clusters$cluster, color=TRUE, shade=FALSE, labels=2, lines=0)


#Analyze Clusters:
#load clusters into dataframe
crane$cluster <- crane_clusters$cluster

centers <- crane_clusters$centers

centers

write.csv(centers, file = "S:\\Office of Risk Management\\User Folders\\Darius Mehri\\Crane Incidents\\CentersData.csv")


crane[1:10, c("cluster", "Injury", "Record.Type.Description")]

aggregate(data = crane, Injury ~ cluster, mean)

crane_clusters$iter

#################################
# CLUSTER ANALYSIS ELEV CEASE USE AND VIOLATIONS

df <- read.csv("C:\\Users\\dmehri\\Documents\\DATA\\Elevator Analysis\\Elev Viol_CeaseUse Cluster.csv")
names(df)

df$VIO_CU<-NULL
df$Borough<-NULL
df$DV_MACHINE_TYPE<-NULL
df$NumberFloors<-NULL

df$YearBuilt<-NULL
df$MACHINE_DRUM<-NULL

df$TaxLien<-NULL
df$Bldg_class<-NULL

#df$SINGLE<-NULL

names(df)

#z score the data so to get results better to interpret
df_z <- as.data.frame(lapply(df, scale))

set.seed(12345)
elev_clusters <- kmeans(df_z, 4)
#plotcluster(crane, crane_clusters$cluster, pch = crane_clusters$cluster)

#evaluate size of cluster
elev_clusters$size

plotcluster(df_z, elev_clusters$cluster)

#crane <- as.numeric(crane)

clusplot(df, elev_clusters$cluster, color=TRUE, shade=FALSE, labels=4, lines=0)


df_z$cluster <- elev_clusters$cluster

centers <- elev_clusters$centers

centers

write.csv(centers, file = "C:\\Users\\dmehri\\Documents\\DATA\\Elevator Analysis\\ClusterResults.csv")


