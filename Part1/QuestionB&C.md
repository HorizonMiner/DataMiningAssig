## B. Possible Insights
1. Plot of facebook likes agaisnt year:
```r
plot(x = dataset$title_year, y = dataset$movie_facebook_likes, xlab = "Year", ylab = "Facebook Likes", main = "Facebook Likes against Year", type = "l")
```
![alt text](imageurl "Facebook Likes against Year")
This plot shows that older movies clearly have less facebook likes and recent movies have the most facebook likes.

## C. Relevant Data Mining Techniques
1. In order to find movies with similar plot and genre, a clustering algorithm can be used, such as k-nearest neighbours and k-keans. Clustering is suitable for finding similar plot, since our dataset contains a plot_keywords feature, which provides keywords related to the story of the movie. Similar words are best represented with a clustering algorithm. This can be used in a recommendation system.
2. For predicting whether a given movie is of a certain category or not, a classification algorithm can be used, such as decision tree.
3. Association rule mining technique can be used to determine the kind of movie that a director will most likely make next given the most frequent genre of movie that the director makes.