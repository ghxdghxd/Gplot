Test_cluster <- function(mat){
  library(proxy)
  disFunc = c('cosine', "euclidean", "maximum", "manhattan" , "canberra"); 
  # disFunc = c("euclidean", "cosine"); 
  cluFunc = c("complete", "single", "average", "ward.D", "mcquitty", "median", "centroid"); 
  cluster_data = data.frame()
  for (dis in disFunc) { 
    for (clu in cluFunc) { 
      qcDis = dist(mat, method=dis); 
      c = hclust(qcDis, method=clu); 
      cop = cophenetic(c); 
      r = cor(cop,qcDis);
      cluster_data <- rbind(cluster_data, data.frame(dis, clu, r))
    } 
  } 
  return(cluster_data)
}

Test_cluster(na.omit(Clinical_sig[, paste0("S",1:4)]))


