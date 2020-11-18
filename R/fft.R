


#' @title Naive Fast Fourier Inverse
#' @description  This function allows the user to compute the fast fourier transform with a naive method.
#' @usage dft1_naive(x,k)
#' @param x a complex vector
#' @param k an integer
#' @return Imaginary part of fast fourier inverse
#' @export
#'
#' @examples
#' \dontrun{vec_com<-complex(real = sample(10), imaginary = sample(10))
#' dft1_naive(vec_com,3)}
dft1_naive<-function(x,k){

  (is.complex(x) && k%%1==0) && return(Im(sum(x*exp(-(seq(0,length(x)-1)/length(x))*(2*pi*complex(real = 0, imaginary = 1)*k)))))
  print("x must be a complex vector and k an integer")

}




#' @title Iterative Fast Fourier Transform
#' @description  This function allows the user to compute the fast fourier transform with an iterative method.
#' @usage dft1_iter(x,k)
#' @param x a complex vector
#' @param k an integer
#'
#' @return Imaginary part of fast fourier inverse
#' @export
#'
#' @examples
#' \dontrun{vec_com<-complex(real = sample(10), imaginary = sample(10))
#' dft1_iter(vec_com,3)}
dft1_iter<-function(x,k){

  (!is.complex(x) || k%%1!=0) && return(print("x must be a complex vector and k an integer"))
  X.k<-0
  for(j in (1:length(x))){
    X.k<-X.k+x[j]*exp(-((j-1)/length(x))*(2*pi*complex(real = 0, imaginary = 1)*k))
    }
  return(Im(X.k))

}





#' @title Matrix form of Fast Fourier Transform
##' @description  This function allows the user to compute the fast fourier transform with a matrix method.
#' @usage dft1_matrix(x,k)
#' @param x a complex vector
#' @param k an integer
#'
#' @return Imaginary part of fast fourier inverse
#' @export
#'
#' @examples
#' \dontrun{vec_com<-complex(real = sample(10), imaginary = sample(10))
#' dft1_matrix(vec_com,3)}
dft1_matrix<-function(x,k){

  (is.complex(x) && k%%1==0) && return(Im(crossprod(x,exp(-(seq(0,length(x)-1)/length(x))*(2*pi*complex(real = 0, imaginary = 1)*k)))))
  print("x must be a complex vector and k an integer")
}



#' @title Customized Fast Fourier method computation
#' @description Run a pre-specified method by user.
#' @param xk a complex vector
#' @param FunF method to be used
#' @usage dft_factory(xk,FunF)
#' @return Fast Fourier Transform according to the method specified
#' @export
#'
#' @examples
#' \dontrun{vec_com<-complex(real = sample(10), imaginary = sample(10))
#' dft_factory(vec_com,3)}
dft_factory<-function(xk,FunF){

  (is.complex(xk)) && return(sapply(0:(length(xk)-1),function(k) FunF(xk,k)))
  print("Choose a valide function")

}




#' @title Fast Fourier Transform method check
#' @description  This method allows to the user to compute all methods at once.
#' @param xk a complex vector
#' @usage dft_factory_all(xk)
#' @return Fast Fourier Transform for each method
#' @export
#'
#' @examples
#' \dontrun{vec_com<-complex(real = sample(10), imaginary = sample(10))
#' dft_factory_all(vec_com)}
dft_factory_all<-function(xk){

  sapply(c("dft1_naive"= dft1_naive, "dft1_iter" = dft1_iter, "dft1_matrix" = dft1_matrix), function(x) dft_factory(xk, x))

}



#' @title Fibonacci Serie
#' @description This function allows to compute the Fibonacci serie
#' @param k an integer
#' @return a fibonacci sequence
#' @usage fib_mulPos_rec(k)
#' @export
#'
#' @examples
#' \dontrun{fib_mulPos_sec(3)}
fib_mulPos_rec<-function(k){

  k <= 2 && return(k)
  k*fib_mulPos_rec(k-1)
}



#' @title Fast Fourier Transform
#' @description This function allows to compute the Fast Fourier Transform with a a faster computation method.
#' @param x a complex vector
#' @return Fast Fourier Transform sequence
#' @usage fft_ct2(x)
#' @export
#'
#' @examples
#' \dontrun{vec_com<-complex(real = sample(10), imaginary = sample(10))
#' fft_ct2(vec_com)}
fft_ct2 <- function(x){

  identical(ceiling(log2(length(x))), floor(log2(length(x)))) ||
    stop("La longueur de `x` doit etre une puissance de 2")
  identical(length(x), 1L) && return(x)

  pair.k<-fft_ct2(x[-seq(0,length(x),2)])
  impair.k<-fft_ct2(x[seq(0,length(x),2)])
  exp_factor<-exp((-2*pi*complex(real = 0, imaginary = 1)*seq(0, length(x)-1))/length(x))

  return(c(pair.k+exp_factor[0:(length(x)/2)]*impair.k, pair.k+exp_factor[((length(x)/2)+1):length(x)]*impair.k))

}




