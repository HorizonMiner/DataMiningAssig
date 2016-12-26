loadDataSetFromZip = function()
{
  dataset = read.csv(unz("dataset/dataset.zip", "uci-news-aggregator.csv"))
  dataset
}

dataset = loadDataSetFromZip()