# Risk Analytics using K-Means Clustering to Generate a List for Sweeps

3.5% of residential elevators in NYC buildings receive a violation or cease use order due to routine inspections. The objective of this analysis was to come up with a list of 100 risky buildings to be given to the elevator unit for inspection. Data included 7 years of routine elevator inspections 

Input variables: 
VIO_CU: 1 = cease use or violation, 0 = no violation or cease use
Single: 1 = building had a single elevator, 0 = more than one elevator
CAT1_Unsat: 1 = considered unsafe during CAT 1 inspection, 0 = safe
hpd_vio: 1 = received previous HPD violation, 0 = no violation
md: multi-dwelling building
Age categories based on building code changes: pre_1900, 1900_1915, 1916_1937, 1938_1967, 1968_2007, 2008_2018
Number of floors: 0-5, 6-9, 10-29, and above 29 floors
Device Type: Gearless traction (GL), oil hydraulic (OH), basement drum (BD), overhead gear traction (OG), basement gear traction (BG), overhead drum (OD)

Results:
The cluster


![cluster plot 2](https://user-images.githubusercontent.com/11237613/40857907-99fba8f4-65aa-11e8-80ce-8e0f1fba7f06.png)

