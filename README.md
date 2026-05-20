# Terrorist-network-analysis
## Overview
This project investigates whether the size of cities where members of Al-Qaeda (a terrorist organization) were born predicts their centrality within the 9/11 terrorist network. Using network analysis and statistical modeling in R, the study examines relationships between geographic, economic, and network variables.

This repository presents my individual implementation and documentation of a collaborative university research project.

## Research question
Does the sizes of the cities where the terrorists are born predict their centrality in the network of 37 Al-Qaeda terrorists involved in the 9/11 event? We expect to find out that the smaller the cities, the more central 
the terrorists are in the network.

## Dataset
- [Terrorist network relationship data](Datasets/terrorist_links.xlsx)
- [Terrorist demographic data](Datasets/terrorist_born__addresses.xlsx) (sheet 1)
- [City socioeconomic data](Datasets/terrorist_born__addresses.xlsx) (GDP per capita, population density, crime rate, education level) (sheet 2)

## Methods
### Statistical Analysis
- Descriptive statistics
- Correlation analysis
- Multivariate linear regression
- Hypothesis testing (t-tests)

### Network Analysis
- Degree centrality
- Betweenness centrality
- Eigenvector centrality
- Network visualization

## Tools
- R programming language (RStudio)
- igraph
- readxl

## Visualizations
<img width="212" height="63" alt="image" src="https://github.com/user-attachments/assets/f4791c8a-b8c9-47b4-bc72-47af6b83253f" />
Correlation matrix

<img width="410" height="238" alt="image" src="https://github.com/user-attachments/assets/273acfe8-3139-4c6f-a22f-df09d8667c95" />
Multivariate regression analysis

<img width="1332" height="897" alt="image" src="https://github.com/user-attachments/assets/a61d4f17-3d56-4c9e-bf62-f6dfd5b04242" />
Figure 5: Network visualization of the Al Qaeda Terrorists involved in the 9/11 attacks 

## Findings
- Weak negative correlation between city size and network centrality
- Regression results showed no statistically significant relationship between socioeconomic factors and the centrality of Al-Qaeda operatives

## Full report
(View the full academic report of the project)[Final_Report.pdf]
