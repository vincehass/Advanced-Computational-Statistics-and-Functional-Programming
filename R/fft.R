#Fourier transform
#Exercice 1

#a) Naive
#' Naive form Fast Fourier Inverse
#'
#' @param x a complex vector 
#' @param k an integer
#'
#' @return Imaginary part of fast fourier inverse
#' @export
#'
#' @examples
dft1_naive<-function(x,k){
  
  (is.complex(x) && k%%1==0) && return(Im(sum(x*exp(-(seq(0,length(x)-1)/length(x))*(2*pi*complex(real = 0, imaginary = 1)*k)))))
  print("x must be a complex vector and k an integer")

}


#b) Iterative

#' Iterative Form for Fast Fourier Transform
#'
#' @param x a complex vector 
#' @param k an integer
#'
#' @return Imaginary part of fast fourier transform
#' @export
#'
#' @examples
#' 
dft1_iter<-function(x,k){
  
  (!is.complex(x) || k%%1!=0) && return(print("x must be a complex vector and k an integer"))
  X.k<-0
  for(j in (1:length(x))){
    X.k<-X.k+x[j]*exp(-((j-1)/length(x))*(2*pi*complex(real = 0, imaginary = 1)*k))
    }
  return(Im(X.k))

}



#c) Matrix form

#' Matrix form of Fast Fourier Transform
#'
#' @param x a complex vector 
#' @param k an integer
#'
#' @return Imaginary part of fast fourier inverse
#' @export
#'
#' @examples
dft1_matrix<-function(x,k){
  
  (is.complex(x) && k%%1==0) && return(Im(crossprod(x,exp(-(seq(0,length(x)-1)/length(x))*(2*pi*complex(real = 0, imaginary = 1)*k)))))
  print("x must be a complex vector and k an integer")
}



# d) Abstraction de la méthode

#' Title
#'
#' @param xk a complex vector
#' @param FunF method to be used
#'
#' @return Fast Fourier Transform
#' @export
#'
#' @examples
dft_factory<-function(xk,FunF){
  
  (is.complex(xk)) && return(sapply(0:(length(xk)-1),function(k) FunF(xk,k))) 
  print("Choose a valide function")
  
}



# e) Implementation de la méthode


#' Title
#'
#' @param xk 
#'
#' @return Fast Fourier Transform for each method
#' @export
#'
#' @examples
dft_factory_all<-function(xk){
  
  sapply(c("dft1_naive"= dft1_naive, "dft1_iter" = dft1_iter, "dft1_matrix" = dft1_matrix), function(x) dft_factory(xk, x))
  
}









# set.seed(1234)
# vec.comp<-sample(complex(real=sample(1:20,16), imaginary = sample(1:20,16)),16)
# 
# # Implementation de la methode
# dft_factory_all(vec.comp)
# 
# # Verfification avec la fonction fft
# 
# c(all.equal(dft_factory_all(vec.comp)[,1], Im(fft(vec.comp))),
#   all.equal(dft_factory_all(vec.comp)[,2], Im(fft(vec.comp))),
#   all.equal(dft_factory_all(vec.comp)[,3], Im(fft(vec.comp))))
# # EXERCICE 2 

#' Fibonacci Serie
#'
#' @param k an integer
#'
#' @return fibonacci sequence 
#' @export
#'
#' @examples
fib_mulPos_rec<-function(k){
  
  k <= 2 && return(k)
  k*fib_mulPos_rec(k-1)
}

#fib_mulPos_rec(3)

# EXERCICE 3

#' Scalable Fast Fourier Transform
#'
#' @param x an integer
#'
#' @return Fast Fourier Transform sequence
#' @export
#'
#' @examples
fft_ct2 <- function(x){
  
  identical(ceiling(log2(length(x))), floor(log2(length(x)))) ||
    stop("La longueur de `x` doit être une puissance de 2") ## Condition d'arrêt.
  identical(length(x), 1L) && return(x)
  
  # initialisation des variables pour une meilleur lisibilité
  
  pair.k<-fft_ct2(x[-seq(0,length(x),2)])
  impair.k<-fft_ct2(x[seq(0,length(x),2)])
  exp_factor<-exp((-2*pi*complex(real = 0, imaginary = 1)*seq(0, length(x)-1))/length(x))
  # Calcul
  return(c(pair.k+exp_factor[0:(length(x)/2)]*impair.k, pair.k+exp_factor[((length(x)/2)+1):length(x)]*impair.k))
  
}



# # Verification
# fft_ct2(vec.comp)
# fft(vec.comp)
# all.equal(fft_ct2(vec.comp), fft(vec.comp))
