rm(list=ls())
#setworkdirectory

library("igraph")
library("devtools")
library("readxl")

#import terrorist network dataset
terrorist_links <- read_excel("C:/Users/ngang/OneDrive/Documents/2nd year/5- Network Economics/SG assignments/terrorist_links.xlsx")

###plot network dataset###
# make the network a graph
g1 <- graph_from_data_frame(d = terrorist_links, directed = FALSE)

#plot the network
layout <- layout_with_kk(g1)
plot(g1, layout = layout,
     vertex.size = 10,                 # Adjust size of nodes
     vertex.label = V(g1)$name,         # Ensure nodes have labels if needed
     vertex.color = "darkseagreen",            # Color of nodes
     vertex.label.color = "black",     # Color of labels
     vertex.label.cex = 0.5,           # Font size of labels1
     vertex.label.dist = 0.5,          # Distance of labels from nodes
     edge.color = "darkgray",              # Color of edges
     edge.width=2,
     main = "New Network Plot")  # Title of the plot

#put width as 1000 and height as 700 when export Plot image

numberOfNodes<-vcount(g1)
numberOfNodes
numberOfEdge<-ecount(g1)
numberOfEdge

####Statistics table###
#Degree is number of direct links 1 node has
DegreeVector<-degree(g1)
DegreeVector[12]
AverageDegree<-mean(DegreeVector)

#the number of actual links divided by the number of potential links
Density<-edge_density(g1)

#path length is number of edges that must be used, of the shortest path from i to j
AveragePathLength<-mean_distance(g1,unconnected=T)

#clustering/cliquishness
Clustering<-transitivity(g1, type = "local")
Clustering[is.na(Clustering)] <- 0
AverageClustering <- mean(Clustering)

#betweeness is the amount of times the node becomes the bridge
Betweenness<-betweenness(g1)
AverageBetween<-mean(Betweenness)

#idk what eigen is
EigenvalueCentralityVector<-eigen_centrality(g1)

#Statistics table
Statistics_name<-c("AverageDegree","AveragePathLength","Density","AverageClustering","AverageBetween")
Statistics_value<-mget(Statistics_name)

Statistics_table <- data.frame(
  Name = Statistics_name,
  Value = sapply(Statistics_value, function(x) if(is.null(x)) NA else x),
  stringsAsFactors = FALSE
)

print(Statistics_table)

###add address table###
Terrorist_address<-read_excel("C:/Users/ngang/OneDrive/Documents/2nd year/5- Network Economics/SG assignments/Terrorist born addresses.xlsx",sheet = "Sheet2",range="A1:G38")

#mean and standard deviation of suburb level
city_size_level <- Terrorist_address$`City size level`[match(V(g1)$name, Terrorist_address$Name)]
mean_city_size <- mean(city_size_level)
print(paste("Mean:", mean_city_size))
sd_city_size <- sd(city_size_level)
print(paste("Standard Deviation:",sd_city_size))



###Correlation between suburb level and centrality (degree)###
# Create a data frame with suburban levels and degree centrality
cor_data <- data.frame(Name = V(g1)$name, Small_city = city_size_level, Centrality = DegreeVector)

# correlation matrix
correlation_matrix <- cor(cor_data[c("Small_city","Centrality")])

print(correlation_matrix)

###multivariate regression###
#add the control variables and merge Name column
crime_rate<-Terrorist_address$`Crime rate`[match(V(g1)$name, Terrorist_address$Name)]
population_density<-Terrorist_address$`Population density`[match(V(g1)$name, Terrorist_address$Name)]
GDP_per_capita<-Terrorist_address$`GDP per capita`[match(V(g1)$name, Terrorist_address$Name)]
city_size_level<-as.integer(city_size_level)
#put in a table
regre_data <- data.frame(
  CitySize = city_size_level,
  Centrality = DegreeVector,
  CrimeRate = crime_rate,
  PopulationDensity = population_density,
  GDPperCapita =GDP_per_capita
)

#do it!!
Regression_model<-lm(Centrality~CitySize+CrimeRate+PopulationDensity+GDPperCapita,data=regre_data)

summary(Regression_model)


###not in program, so you do not need to check this part, I keep it for myself only###
#struggle but dunno if it's needed
options(max.print=4000,width=2000)
as_adjacency_matrix(g1)
#wrong.adj.matrix.df<-as.data.frame(as.table(as_adjacency_matrix(g1)))
adjMat = get.adjacency(g1)
adjMat = as_adj(g1)
adjMat

#dunno if needed

el<-get.edgelist(g1)                             
el<-as.data.frame(el)
el

#diameter is longest shortest path
Diameter<-diameter(g1)

EigenvalueCentralityVector<-eigen_centrality(g1)

eigen<-data.frame(Centrality=EigenvalueCentralityVector$vector)
library(tibble)
eigen <- rownames_to_column(eigen, var = "Name")
terrorist_pairs<-merge(Terrorist_address,eigen,by = "Name")
cor_matrix <- cor(terrorist_pairs, use = "pairwise.complete.obs")

# Assume we have some hypothetical eigenvector centrality scores
eigenvector_centrality <-EigenvalueCentralityVector
suburban_levels <- Terrorist_address$'Suburb level'

data <- data.frame(Suburban = suburban_levels, Eigenvector = eigenvector_centrality)

# Step 2: Calculate the correlation matrix
correlation_matrix <- cor(data)

# Print the correlation matrix
print(correlation_matrix)

# Step 3: Visualize the correlation matrix
corrplot(correlation_matrix, method = "circle")

#correlation struggle
g2<-delete_vertices(g1,38:62)

DegreeVector2<-degree(g2)
data_frame <- data.frame(SuburbanLevels = suburban_levels, DegreeVector = DegreeVector2)
cor_matrix <- cor(data_frame, use = "complete.obs")  # 'complete.obs' handles missing values by omitting them
view(cor_matrix)
