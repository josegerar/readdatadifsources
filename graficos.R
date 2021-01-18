library(ggplot2)
library(gridExtra)

itemGraphics = function(datos, xdata, titlelab){
  bindw = (max(xdata)- min(xdata))/ceiling(sqrt(length(datos)))
  pl1 = ggplot(datos, aes(x = xdata)) +  
    geom_histogram(binwidth = bindw, fill = "red") + 
    geom_density(colour = "blue") +
    stat_function(fun = dnorm, args = list(mean = mean(xdata), sd = sd(xdata)))+
    labs(title = "Histograma", x = titlelab, caption = "")
  pl2 = ggplot(datos, aes(y=xdata)) + 
    geom_boxplot()
  res <- grid.arrange(pl1, pl2, nrow=2)
  return(res)
}

getLisNames = function(data){
  listnames = list()
  for (i in 1:length(names(data))) {
    name = names(data)[i]
    listnames[name] = i
  }
  return(listnames)
}
