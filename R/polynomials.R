
#' @title Class Polynomial
#' @description This class allows to construct a family of polynomials in order to manipulate arithmetic operations on polynomials.
#' eg. sum, multiplication, roots identification.
#' @param coefs an integer vector of  coefficients
#'
#' @return a polynomial class
#' @usage plynR(coefs)
#' @export
#' @examples
#' \dontrun{plynR(c(1,2,-3))}
plynR<- function(coefs) {

  is.numeric(coefs)||
    identical(length(coefs), as.integer(length(coefs))) ||
      stop("coefs doit etre un vecteur d entier")
    is.numeric(coefs)||
      stop("coefs doit etre numeric")
  while ((lcoefs <- length(coefs)) > 1 && coefs[lcoefs] == 0) coefs <- coefs[-lcoefs]
  structure(as.numeric(coefs), class = c("polynR", "numeric"))
}


printPol<- function(...) UseMethod("printPol")

#' @title Print Polynomials
#' @description A generic method of class Polynom that allows the user to print the algebric form of a polynom from a given input coefficients.
#' @param p an integer vector of  coefficients
#' @return print the algebric form of a class polynom.
#' @export
#' @examples
#' \dontrun{printPol.plynR(c(1,2,3))}
printPol.plynR<-function(p){

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
  cat("A polynom as ", exp)

}


plus<- function(...) UseMethod("plus")

#' @title Plus polynoms
#' @description Add two polynoms from class polynR
#' @param p1 an integer coefficient (first polynom)
#' @param p2 an integer coefficient (second polynom)
#' @return sum of two polynoms from the input coefficients
#' @export
#' @examples
#' \dontrun{printPol.plynR(plus.plynR(c(1,1,10), c(1,2,10)))}
plus.plynR<-function(p1,p2){

  l1 <- length(p1)
  l2 <- length(p2)
  p1 <- c(p1, rep.int(0, max(0, l2 - l1)))
  p2 <- c(p2, rep.int(0, max(0, l1 - l2)))
  `+` = {
    res<-mapply(`+`, p1,p2)
    res
  }
}



fois<- function(...) UseMethod("fois")

#' @title Fois polynoms
#' @description Multiply two polynomias from class polynR
#' @param p1 an integer coefficient (first polynom)
#' @param p2 an integer coefficient (first polynom)
#' @return multiplication of two polynoms from the input coefficients
#' @export
#' @examples
#' \dontrun{printPol.plynR(fois.plynR(c(1,1,10), c(1,2,10)))}
fois.plynR<-function(p1,p2){

  l1 <- length(p1)
  l2 <- length(p2)

  `*` = if (l1 == 1 || l2 == 1) {
    res<-p1*p2
  } else {
    m <- outer(p1, p2)
    res<-as.vector(tapply(m, row(m) + col(m), sum))
    res
  }

}




derive<- function(p) UseMethod("derive")

#' @title Derivative polynom
#' @description This function allows the user to compute the derivative of a polynom from class polynR
#' @param p an integer vector of  coefficients
#' @return the algebric form of the derivative of a polynom

#' @examples
#' \dontrun{printPol.plynR(derive.plynR(c(1,1,10)))}
#' @export
derive.plynR<-function(p){
  w<-p*(0:(length(p)-1))
  w[-1]
}




racines<- function(p) UseMethod("racines")

#' @title Racines polynoms
#' @description This function allows the user to determine the roots of a polynom from class polynR
#' @param p an integer vector of  coefficients
#' @return return reals and imaginary solutions of a polynom.
#' @export
#' @examples
#' \dontrun{printPol.plynR(racines.plynR(c(3,-4,5)))}
racines.plynR<-function(p){
  polyroot(p)
}



summaryPol.polynR<- function(...) UseMethod("summaryPol.polynR")

#' @title Summary polynom
#' @description This function allows the user to return the summary of a polynom from class polynR and gives its factorization
#' @param object a polynom object from class ploynR
#' @return summary of a polynom.
#' @export
#' @examples
#' \dontrun{summaryPol.plynR(plynR(c(1,2,3)))}
summaryPol.plynR<-function(object){
  cat("\n",printPol.plynR(object),"Its factorization is = \n")

  z_roots<-round(racines.plynR(object),2)

    if(length(racines.plynR(z_roots))==0 || isTRUE(all.equal(z_roots,0))){
      cat("Polynom must be of degree greater than 0")
    }else{
      if(isTRUE(all.equal(Re(z_roots),0))){
        ti<-paste(ifelse(Im(z_roots) > 0.0, "- ", "+ "),
                  abs(Im(z_roots)), "i", sep = "")
        paste("(x",ti,")", sep = "")

      }else if(isTRUE(all.equal(Im(z_roots),0))){
        tm<-paste(ifelse(Re(z_roots) > 0.0, "- ", "+ "),
                  abs(Re(z_roots)), sep = "")
        paste("(x",tm,")", sep = "")

        }else {
        mi<-paste(ifelse(Re(z_roots) > 0.0, "- ", "+ "), abs(Re(z_roots)), " ", ifelse(Im(z_roots) > 0.0, "- ", "+ "),
                  abs(Im(z_roots)), "i", sep = "")
        paste("(x",mi,")", sep = "")

      }
    }
}


