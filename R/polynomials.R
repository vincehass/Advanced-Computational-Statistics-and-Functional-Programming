
#' Polynomial 
#'
#' @param coefs an integer vector of  coefficients
#'
#' @return a polynomial class
#' @export
#'
#' @examples
#' polynR(c(1,2,-3))
polynR<- function(coefs) {
  
  is.numeric(coefs)||
    identical(length(coefs), as.integer(length(coefs))) ||
      stop("coefs doit etre un vecteur d entier")
    is.numeric(coefs)||
      stop("coefs doit être numeric")
  while ((lcoefs <- length(coefs)) > 1 && coefs[lcoefs] == 0) coefs <- coefs[-lcoefs]
  structure(as.numeric(coefs), class = c("polynR", "numeric"))
}






#' Print Polynomials
#' A generic method of class Polynom.
#' @param p an integer vector of  coefficients
#'
#' @return the algebric form of a polynom.
#' @export
#'
#' @examples
#' print.polynR(c(1,2,30))
print.polynR<-function(p){
  
  lp <- length(p) - 1
  names(p) <- 0:lp
  p <- p[p != 0]
  if (length(p) == 0)
    return("0")
  
  p <- rev(p)
  signs <- ifelse(p < 0, "- ", "+ ")
  signs[1] <- if (signs[1] == "- ")
    "-" else ""
  np <- names(p)
  pc<-p
  pc <- as.character(abs(pc))
  pc[pc == "1" & np != "0"] <- ""
  pow <- paste("x^", np, sep = "")
  pow[np == "0"] <- ""
  pow[np == "1"] <- "x"
  stars <- rep.int("*", length(pc))
  stars[pc == "" | pow == ""] <- ""
  exp<-paste(signs, pc, stars, pow, sep = "", collapse = " ")
  cat("Le resultat est un polynome de ", exp)  
  
}








plus<- function(...) UseMethod("plus")

#' Add two polynomial series
#' @param serie1 first polynom
#' @param serie2 second polynom
#' @return sum of two polynoms
#' @export
#'
#' @examples 
#' plus.polynR(c(1,1,10), c(1,2,10))
#' print.polynR(plus.polynR(c(1,1,10), c(1,2,10)))
plus.polynR<-function(...){
  suites<-list(...)
  p1 <- suites[[1]]
  p2 <- suites[[2]]
  l1 <- length(suites[[1]])
  l2 <- length(suites[[2]])
  p1 <- c(p1, rep.int(0, max(0, l2 - l1)))
  p2 <- c(p2, rep.int(0, max(0, l1 - l2)))
  `+` = {
    res<-mapply(`+`, p1,p2)
  }
}



fois<- function(...) UseMethod("fois")


#' Multiply two polynomial series
#' @param serie1 first polynom
#' @param serie2 second polynom 
#' @return multiplication of two polynoms
#' @export
#'
#' @examples 
#' print.polynR(fois.polynR(c(1,1,10), c(1,2,10)))
fois.polynR<-function(...){
  suites<-list(...)  
  p1 <- suites[[1]]
  p2 <- suites[[2]]
  l1 <- length(suites[[1]])
  l2 <- length(suites[[2]])
  
  `*` = if (l1 == 1 || l2 == 1) {
    res<-p1*p2
  } else {
    m <- outer(p1, p2)
    res<-as.vector(tapply(m, row(m) + col(m), sum))
  }

}



deriv<- function(...) UseMethod("deriv")

#' Derivative of a polynom
#'
#' @param p an integer vector of  coefficients 
#'
#' @return the algebric form of the derivative of a polynom
#' @export
#'
#' @examples
#' print.polynR(deriv.polynR(c(6,2,10,2,32)))
deriv.polynR<-function(p){
  w<-p*(0:(length(p)-1))
  return(w[-1])  
  
}  




racines<- function(...) UseMethod("racines")

#' Roots of a polynom
#'
#' @param p an integer vector of  coefficients 
#'
#' @return Reals and imaginaries solutions of a polynom.
#' @export
#'
#' @examples
#' print.polynR(Re(racines.polynR(polynR(c(3,-4,5)))))
racines.polynR<-function(p){
  polyroot(rev(p))
}






summary.polynR<- function(...) UseMethod("summary")

#' Summary of a polynom
#'
#' @param object a polynom object 
#'
#' @return summary of a polynom.
#' @export
#'
#' @examples
#' summary.polynR(polynR(c(3,-4,5)))
summary.polynR<-function(object){
  cat("Summary P(n) \n")
  print(object)
  cat("\nSa factorisation est \n")
  lambda<-racines.polynR(object)[1]
  lambdaBar<-racines.polynR(object)[2]
  cat("(x",-1*lambda, ")(x+",lambdaBar,")")
}






