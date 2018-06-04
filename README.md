# Elevator Risk Analytics using K-Means Clustering

3.5% of residential elevators in NYC buildings receive a violation or cease use order due to routine inspections. The objective of this analysis was to come up with a list of 100 risky buildings to be given to the elevator unit for inspection. 

### Data  
7 years of routine elevator inspections, elevator and building characteristics

### Input variables

VIO_CU: 1 = cease use or violation, 0 = no violation or cease use.\
Single: 1 = building had a single elevator, 0 = more than one elevator.

CAT1_Unsat: 1 = considered unsafe during CAT 1 inspection, 0 = safe.

hpd_vio: 1 = received previous HPD violation, 0 = no violation.

md: 1 = multi-dwelling, 0 = not multi-dwelling

Age categories based on building code changes: pre_1900, 1900_1915, 1916_1937, 1938_1967, 1968_2007, 2008_2018

Number of floors: 0-5, 6-9, 10-29, and above 29 floors

Device Type: Gearless traction (GL), oil hydraulic (OH), basement drum (BD), overhead gear traction (OG), basement gear traction (BG), overhead drum (OD)

The elbow method was used to determine the number of clusters, and the data was z-scored to evaluate the results above or below the mean.


### Results
The cluster with the highest rate of violations and cease use included these variables
Single elevator, previous HPD violation, multi-dwelling, year built between 1916 and 1937, 6 to 9 floors, device type overhead gear traction and basement gear traction.

Based on the results, the list of active elevators was created by subsetting the list of all active elevators (i.e. removing elevators that did not have a previous HPD violation, years built not within the range of 1916 to 1937, and so on).

A sample of 100 was drawn from the final subsetted list resulting in a threefold increase in the violation and cease use rate (from 3.5% to 15.2%).


![cluster plot 2](https://user-images.githubusercontent.com/11237613/40857907-99fba8f4-65aa-11e8-80ce-8e0f1fba7f06.png)

### Logistic Regression
Results were very similar to logistic regression:

![image](https://user-images.githubusercontent.com/11237613/40933693-3d02934e-6800-11e8-85ce-ea34ef07006a.png)

