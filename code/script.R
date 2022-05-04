# script for analysis ----—

# load packages needed in one go. 
# You should have pacman and follow-listed packages installed beforehand. 
pacman::p_load(pacman, dplyr, ggplot2, tidyr, rmarkdown, 
               shiny, readxl, psych, rio, vegan, agricolae, ggpubr, haven)

# load dummy data ----
data<-import('data/data.xlsx') # rio package is needed
head(data) # see the head of the data frame if corrected imported
str(data) # see the structure of the data. Some data types may be transformed, 
          # such as from chr to factor
data$cd<-as.factor(data$cd) # transform cadmium to factor
data$as<-as.factor(data$as) # transform arsenic to factor
data$sp<-as.factor(data$sp) # transform plant species to factor
str (data) # see if correctly transformed
summary(data$cd) # see if numbers of treatments and replications correct
summary(data$as)
summary(data$sp)
describe(data) # summarise and overview the data frame
summary(data$rt_cd) # summary root cadmium concentration, 
                    # you can do the same for other parameters. 
                    # just change the code after $.

# PCA ----
# select data for PCA
View(data)
data_pca <- select(data, cd, as, sp, rt_ros, sht_ros, rt_antio, sht_antio) 
# here 4 variables are included, you will see 4 PC using summary(pc)
# you can add more or less. 
pc <- prcomp(data_pca [, -1:-3], # exclude column 1-3, 
             # they are factors only (cd, as and sp), no need.
             center = TRUE,
             scale. = TRUE) 

pc
summary(pc) # get summary statistics
plot(pc) # plot bar chart of pc
biplot(pc) # plot the first two pc


pc_2 <- cbind(data_pca, pc$x)
head(pc_2)

# plot overall PCA result ----
library(ggplot2)
ggplot(pc_2, aes(PC1, PC2, col = trt, fill = sp)) + 
  # fill = sp, or as or cd, is to group using diff factors
  stat_ellipse(geom = "polygon", col = "black", alpha = 0.5) +
  geom_point(shape = 21, col = "black") +
  theme_classic()

