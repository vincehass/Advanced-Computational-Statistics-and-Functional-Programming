

#' @title Generator of a transformed Discrete distribution
#' @description This function generate a vector of realization from the same distribution of the input vector.
#' The user can specify a transformation on the input vector otherwise it will return the identity transformation.
#' @param x_vec an integer vector
#' @param trans a transformation function
#' @return a sequence of discrete random variable from the input distribution
#' @usage simulator(x_vec, trans = identity)
#' @export
#' @importFrom stats runif
#' @examples
#' \dontrun{
#' f2<-function(x) x**2;
#' xs<-c(10,3,5,20,4,6);
#' simulator_tran<-function(xs,trans=identity) lapply(list(length(xs)),simulator(xs, trans))
#' sim_tran<-simulator_tran(xs)
#' }
simulator<-function(x_vec, trans = identity){

  is.numeric(x_vec)||
    identical(length(x_vec), as.integer(length(x_vec))) ||
      stop("the input vector must be an integer vector")

  discrete_inv<- function(x_vec) {
    u<-runif(1)
    vect<-x_vec/sum(x_vec)
    if(u <= vect[1]){
      return(x_vec[1])
    }
    for(pos in 2:length(x_vec)) {
      if(sum(vect[1:(pos-1)]) < u && u <= sum(vect[1:pos]) ) {
        return(x_vec[pos])
      }
    }

  }

    n<-length(x_vec)
    function(n){
      x_vec<-sample(x_vec)
      names(n) <- as.character(n)
      samples<- numeric(n)
      for(i in seq_len(n) ) {
        samples[i] <- sapply(discrete_inv(x_vec), trans)
      }
      samples
    }

}




#' @title Generator of a sum of random variables
#' @description This function allows to the user to generate the sum of two generators.
#' The user could specify a transformation for the input otherwise it will return the identity transformation.
#' @param vec1 an integer vector of realization (first)
#' @param vec2 an integer vector of realization (second)
#' @param trans a transformation function
#' @return a vector of a transformed sum from the input vectors
#' @usage realization_sum(vec1,vec2,trans=identity)
#' @export
#'
#' @examples
#' \dontrun{
#' simulator_sum<-function(v1,v2,trans=identity){
#'lapply(list(length(c(v1,v2))),realization_sum(v1,v2, trans))};
#'simulator_sum(c(1,2,3),c(2,3,4), identity);
#'f2<-function(x) x**2;
#' sim_sum<-simulator_sum(c(1,2,3),c(2,3,4), f2);
#' sim_sum
#' }
realization_sum<-function(vec1, vec2, trans=identity){

  l1 <- length(vec1)
  l2 <- length(vec2)
  p1 <- c(vec1, rep.int(0, max(0, l2 - l1)))
  p2 <- c(vec2, rep.int(0, max(0, l1 - l2)))
  simulator(p1+p2, trans)
}


#' @title Proportion of the generator
#' @description This function allows to the user to return the proportion of the realized input vector
#' The user could specify a transformation of the input vector otherwise it will return he identity transformation.
#' @param sim a simulator
#' @return the proportion of the input vector
#' @usage simulator_prop(sim)
#' @export
#'
#' @examples
#' \dontrun{
#' f2<-function(x) x**2;
#' xs<-c(10,3,5,20,4,6);
#' sim_tran<-simulator_tran(xs)
#' sim_tran2<-simulator_tran(xs,f2);
#' simulator_prop(sim_tran);
#' simulator_prop(sim_tran2)
#' }
simulator_prop<-function(sim){

  return(table(as.vector(sim))/length(as.vector(sim)))
}





#' @title Histogram of realized random variables
#' @description This function allows to the user to visualize the empirical distribution of the realized input vector
#' The user could specify a transformation of the input vector otherwise it will return he identity transformation.
#' @param sim a simulator
#'
#' @return a histogram of the realizations
#' @usage  simulator_bar(sim)
#' @export
#' @importFrom graphics barplot par
#' @examples
#' \dontrun{
#' f2<-function(x) x**2;
#' xs<-c(10,3,5,20,4,6);
#' sim_tran<-simulator_tran(xs)
#' sim_tran2<-simulator_tran(xs,f2);
#' simulator_prop(sim_tran);
#' simulator_bar(sim_tran);
#' simulator_bar(sim_tran2)
#' }

simulator_bar<-function(sim){
  barplot(simulator_prop(sim), main='Distribution')
}



#' @title Sequence Generator
#' @description This function allows to calculate the longest bounded sequence given a defined arithmetic operation.
#'
#' @param sets an integer vector
#' @param lowerb lower bound
#' @param upperb upper bound
#' @usage sequence_long(sets = c(2L, 2L, 5L, 6L, 6L, 6L, 7L, 9L),
#'lowerb = -1e10,
#'upperb = 1e10)
#' @return the longest sequence inside the given bound
#' @export
#'
#' @examples
#' \dontrun{
#' sequence_long(sets = c(2L, 2L, 5L, 6L, 6L, 6L, 7L, 9L),
#'lowerb = -1e10,
#'upperb = 1e10)}
sequence_long<-function(sets = c(2L, 2L, 5L, 6L, 6L, 6L, 7L, 9L),
         lowerb = -1e10,
         upperb = 1e10) {
  operators <- list(`+`, `-`, `*`, `/`, `^`)
  seq_length<-5000
  res_set<-replicate(n = 1e5L, simplify = FALSE,
                   expr=sample(sets,5))
  res_op<-replicate(n = 1e5L, simplify = FALSE,
                 expr=sample(operators,5, replace = T))

    ress<-as.list(rep(NA),length(res_set))
    operator_track<-as.list(rep(NA),length(res_op))
    for(k in 1:seq_length){
      for(i in 1:length(operators)){
        #store in ress results for each operation with different sets
          ress[[k]]<-res_op[[k]][[i]](c(res_set[[k]]),c(res_set[[k+1L]]))
          operator_track[[i]]<-res_op[[i]]

          ifelse(!is.integer(ress[[k]]), NA,ifelse(ress[[k]]>upperb,NA,
                                                    ifelse(ress[[k]]<lowerb,NA,ress[[k]])))
        }
      }
    return(list(ress, res_set, operator_track))

}




#' @title Sequence Tracker
#' @description This function allows to track the decomposition of a selected operation.
#'
#' @param data a list of stored operations
#' @param k the k_th result from the list (k correspond to the length of the sequence 5000 by default)
#' @param i the i_th operation performed randomly (5 operations performed for each set of number)
#' @usage tracking_operator(data,k,i)
#' @return the decomposition of the given result
#' @export
#' @examples
#' \dontrun{
#' w<-sequence_long(sets = c(2L, 2L, 5L, 6L, 6L, 6L, 7L, 9L),
#'lowerb = -1e10,
#'upperb = 1e10)
#'tracking_operator(data = w, k=30,i=4);
#'tracking_operator(data = w, k=10, i=5)
#' }
tracking_operator<-function(data,k,i){

  cat("The result of ",data[[1]][[k]][i],
  " has been obtained by this set of numbers ",
  data[[2]][[k]]," and the following operation\n")
  print(as.vector(data[[3]][[i]]))
}







