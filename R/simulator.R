
#' Inverse Discrete Distribution
#'
#' @param vec an integer vector
#'
#' @return the inverse of discrete distribution
#' @export
#'
#' @examples
#' vec<-c(2,10,4,6)
#' discrete_inv(vec)
discrete_inv<- function(vec) {
  u<-runif(1)
  vect<-vec/sum(vec)
  if(u <= vect[1]){
    return(vec[1])
  }
  for(pos in 2:length(vec)) {
    if(sum(vect[1:(pos-1)]) < u && u <= sum(vect[1:pos]) ) {
      return(vec[pos])
    }
  }
  
}

#' Generator of Discrete distribution
#'
#' @param n an integer vector 
#'
#' @return a sequence of discrete random variable
#' @export
#'
#' @examples 
#' simulateur1(10)
simulateur1<-function(n){
  
  names(vec) <- as.character(vec)
  samples<- numeric(n)
  
  
  discrete_inv<- function(vec) {
    u<-runif(1)
    vect<-vec/sum(vec)
    if(u <= vect[1]){
      return(vec[1])
    }
    for(pos in 2:length(vec)) {
      if(sum(vect[1:(pos-1)]) < u && u <= sum(vect[1:pos]) ) {
        return(vec[pos])
      }
    }
    
  }
  
  for(i in seq_len(n) ) {
    samples[i] <- discrete_inv(vec)
  }
  return(samples)
  }



#' Discrete Inverse Transformation
#'
#' @param sim a method of generator random variable
#' @param trans a customized transformation function
#'
#' @return a vector of a transformed realisation
#' @export
#'
#' @examples
#' vec<-c(2,10,4,6)
#' discrete_inverse_tran(simulateur1(100), vec**2)
discrete_inverse_tran<-function(sim,trans){
  tr<<-function(x) trans
  return(sim(tr(x)))
  
}


#' Generator of a Transformed Discrete distribution
#'
#' @param sim a method of generator random variable
#' @param trans a customized transformation function
#'
#' @return a vector of a transformed realisation
#' @export
#'
#' @examples  
#' vec<-c(2,10,4,6)
#' simulateur2(simulateur1(100), vec**2).
simulateur2<-function(sim, trans){
  
  n<-length(sim)
  samples<- numeric(n)
  for(i in seq_len(n) ) {
    samples[i] <- discrete_inverse_tran(discrete_inv, trans)
  }
  
  return(samples)
}



#' Sum of two generators
#'
#' @param sim1 a vector of simulated distribution 
#' @param sim2 a vector of simulated distribution 
#'
#' @return a vector of simulated distribution
#' @export
#'
#' @examples
#' simulateur_sum(simulateur1(10),simulateur1(50))
#' simulateur_sum(simulateur1(100),simulateur2(simulateur1(100), vec**2))
#' simulateur_sum(simulateur1(10),simulateur1(50))

simulateur_sum<-function(sim1, sim2){
  
  if(length(sim1) < length(sim2)){
    x_bis<-c(sim1, rep(0,abs(length(sim1)-length(sim2))))  
    x_bis<-x_bis+sim2
  }else if(length(sim2) < length(sim1)){
    x_bis<-c(sim2, rep(0,abs(length(sim1)-length(sim2))))  
    x_bis<-x_bis+sim1
  }else{
    x_bis<-sim1+sim2
  }
  
  return(simulateur2(simulateur1(length(x_bis)), x_bis))
  
}



#Question d)

#' Generator of proportion
#'
#' @param sim a vector of simulated distribution  
#'
#' @return a vector of simulated distribution
#' @export
#'
#' @examples
#' simulateur_prop(simulateur1(100))
#' simulateur_prop(simulateur2(simulateur1(100), vec**2))
#' simulateur_prop(simulateur_sum(simulateur1(n),simulateur2(simulateur1(n), vec**2)))
simulateur_prop<-function(sim){
  return(table(sim)/length(sim))
  
}


#' Histogram of distributed realizations
#'
#' @param sim a generator of random variable
#'
#' @return histogram of the distribution returned
#' @export
#'
#' @examples
#'n<-100
#' simulateur_bar(simulateur1(n))
#' simulateur_bar(simulateur2(simulateur1(n), vec**2))
#  simulateur_bar(simulateur_sum(simulateur1(n),simulateur2(simulateur1(n), vec**2)))

simulateur_bar<-function(sim){
  par(mfrow=c(1,2))
  names(vec)<-as.character(vec)
  barplot(vec, main='Vraie Distribution')
  barplot(simulateur_prop(sim), main='Distribution Empirique')
}




#Question 2)



#' Sequence of a bounded arithmetic operation
#'
#' @param l an integer vector 
#'
#' @return the longest vector of realisation inside the bound.
#' @export
#'
#' @examples
#' NbSerie(c(2,2,5,6,6,6,7,9))
NbSerie<-function(l){
  
  operation<-function(l){
    c((`*`(`+`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
      (`^`(`+`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
      (`^`(`-`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
      (`^`(`+`(`-`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
      (`^`(`*`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])))
  }
  models<-c("model.1", "model.2","model.3","model.4","model.5")
  ab<-t(apply(combn(x,5),2,operation(l)))
  colnames(ab)<-c(models)
  subset(ab,ab[ab>-1*10^10] && ab[ab<1*10^10])

}





