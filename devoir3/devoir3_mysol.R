#Question a
polynR<- function(coefs) {
  
  is.numeric(coefs)||
    identical(length(coefs), as.integer(length(coefs))) ||
      stop("coefs doit etre un vecteur d entier")
    is.numeric(coefs)||
      stop("coefs doit être numeric")
  while ((lcoefs <- length(coefs)) > 1 && coefs[lcoefs] == 0) coefs <- coefs[-lcoefs]
  structure(as.numeric(coefs), class = c("polynR", "numeric"))
}

polynR(c(1,2,-3))



#Question b
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



print.polynR(c(1,2,30))



#Question c
plus<- function(...) UseMethod("plus")

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

print.polynR(plus.polynR(c(1,1,10), c(1,2,10)))



#Question d

fois<- function(...) UseMethod("fois")


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


print.polynR(fois.polynR(c(1,1,10), c(1,2,10)))



#Question e

deriv<- function(...) UseMethod("deriv")

deriv.polynR<-function(p){
  w<-p*(0:(length(p)-1))
  return(w[-1])  
  
}  


#visualiser le polynome
print.polynR(polynR(c(6,2,10,2,32)))
#visualiser la derivee du polynome
print.polynR(deriv.polynR(c(6,2,10,2,32)))

#Question f)
racines<- function(...) UseMethod("racines")

racines.polynR<-function(p){
  polyroot(rev(p))
}

#visualiser le polynome
print.polynR(polynR(c(3,-4,5)))
#visualiser les racines du polynome
print.polynR(Re(racines.polynR(polynR(c(3,-4,5)))))



#Question g)
summary.polynR<- function(...) UseMethod("summary")

summary.polynR<-function(object){
  cat("Summary P(n) \n")
  print(object)
  cat("\nSa factorisation est \n")
  lambda<-racines.polynR(object)[1]
  lambdaBar<-racines.polynR(object)[2]
  cat("(x",-1*lambda, ")(x+",lambdaBar,")")
}

#visualiser le sommaire ainsi que la factorisation du polynome
summary.polynR(polynR(c(3,-4,5)))



