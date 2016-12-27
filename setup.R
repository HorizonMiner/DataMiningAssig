loadDataSetFromZip = function()
{
  # dataset = read.csv(unz("dataset/dataset.zip", "uci-news-aggregator.csv"))
  dataset = read.csv("dataset/movie_metadata.csv")
  dataset
}

dataset = loadDataSetFromZip()