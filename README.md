
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Fnpol Package

<!-- badges: start -->

[![documentation](https://img.shields.io/badge/documentation-fnpol-green.svg)](https://github.com/vincehass/Advanced-Computational-Statistics-and-Functional-Programming/tree/master/1-Fnpol)
[![contributions](https://img.shields.io/badge/contributions-welcome-red.svg)](https://github.com/vincehass/Advanced-Computational-Statistics-and-Functional-Programming/tree/master/1-Fnpol)
[![check](https://img.shields.io/badge/check-passed-green.svg)](https://github.com/vincehass/Advanced-Computational-Statistics-and-Functional-Programming/tree/master/1-Fnpol)
<!-- badges: end -->

The goal of fnpol is to provide functionalities for fast computation for
the following methods: Fast fourrier methods, random variable generator
and polynomials series.

### Author: Nadhir Hassen

## Installation

You need to load `usethis::use_package(devtools)` and
`library(devtools)`. You can install the released version of **fnpol**
from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("fnpol")
```

``` r
library(fnpol)
library(devtools)
#> Loading required package: usethis
devtools::load_all()
#> Loading fnpol
```

This package describes functionalities for fast computation with the
following methods: Fast fourier method `fft_c2`, random variable
simulator which provides transformation such as sum `simulateur_sum`,
proportion `simulateur_prop` and summary distribution `simulateur_bar`.
In addition, we provide a class of polynomial that return a symbolic
polynomials, their transformation such that sum of polynomials,
multiplication of polynomials, derivative of polynomials and summary
statistics which give their respective factorization.

## Fast Fourier Method

The fourier transform is defined as the sum of \(N\) complexs number
\((X_k)_{k=0}^{N-1}\) such that

where \(i\) is the imaginary part and the complex serie
\((x_n)_{n=0}^{N-1}\) \(\in \mathbb{C}\).

### Naive form Fast Fourier Transform

``` r
vec_com<-sample(complex(real=sample(1:20,16), imaginary = sample(1:20,16)),16)
vec_com
#>  [1] 15+11i  5+ 7i  6+17i  9+10i  7+16i 19+ 4i 17+ 1i 20+20i 13+ 8i 10+19i
#> [11] 14+18i  1+12i 18+ 9i  3+ 5i 16+ 3i 12+ 2i
dft1_naive(vec_com,k=3)
#> [1] -7.901219
```

### Iterative Form for Fast Fourier Transform

``` r

dft1_iter(vec_com,k=3)
#> [1] -7.901219
```

### Matrix Form for Fast Fourier Transform

``` r

dft1_matrix(vec_com,k=3)
#>           [,1]
#> [1,] -7.901219
```

### Comparaison of all methods for Fast Fourier Transform

``` r
c(all.equal(dft_factory_all(vec_com)[,1], Im(fft(vec_com))),
  all.equal(dft_factory_all(vec_com)[,2], Im(fft(vec_com))),
  all.equal(dft_factory_all(vec_com)[,3], Im(fft(vec_com))))
#> [1] TRUE TRUE TRUE
```

### Fibonacci sequence

``` r
fib_mulPos_rec(3)
#> [1] 6
```

### Scalable Fast Fourier Transform

We use a recursive algorithm to calculate the fast Fourier transform.
This method allows us to benefit from an important concept in
algorithmic “divide to conquer”. For this we decompose the Fourier
transform into an even and odd sequence and exploit the symmetry of this
decomposition such that

Using symmetry allows us to halve the computational complexity by going
from \(\mathcal{O}(N^2)\) to \(\mathcal{O}(M^2)\), for \(0\leq k < N\)
and \(0\leq n <M / 2\). In addition, using the recursive method has
allowed us to further reduce this complexity. Therically this method
reaches a complexity (assymptotically) of \(\mathcal{O}(N\log N)\). We
implement the algorithm below.

``` r
fft_ct2(vec_com)
#>  [1] 185.000000+162.000000i -15.032721- 31.763374i  56.627417+ 39.526912i
#>  [4]   8.350120-  7.901219i  -9.000000+ 10.000000i  21.760457+ 25.312533i
#>  [7] -26.585786- 10.514719i   5.353723-  7.464730i  27.000000+  4.000000i
#> [10]  16.062158+ 71.077083i  11.372583- 25.526912i  -9.864838+  0.386500i
#> [13]   9.000000+  0.000000i  13.210106-  8.626241i -29.414214- 27.485281i
#> [16] -23.839004- 17.020551i
```

## Comparaison tool Fast Fourier Transform

``` r
all.equal(fft_ct2(vec_com), fft(vec_com))
#> [1] TRUE
```

## Generator of random variable

### Generator of a transformed Discrete distribution

This function generate a vector of realization from the same
distribution of the input vector. The user can specify a transformation
on the input vector otherwise it will return the identity
transformation.

``` r
f2<-function(x) x**2;
xs<-c(10,3,5,20,4,6);
simulator_tran<-function(xs,trans=identity) lapply(list(length(xs)),simulator(xs, trans))
sim_tran<-simulator_tran(xs)
```

### Generator of a sum of random variables

This function allows to the user to generate the sum of two generators.
The user could specify a transformation for the input otherwise it will
return the identity transformation. We give two examples, the first with
no transformation and the second with a transformation such as
\(f(x) = x^2\).

``` r
simulator_sum<-function(v1,v2,trans=identity){
lapply(list(length(c(v1,v2))),realization_sum(v1,v2, trans))};
simulator_sum(c(1,2,3),c(2,3,4), identity);
#> [[1]]
#> [1] 5 7 7 5 7 7
f2<-function(x) x**2;
sim_sum<-simulator_sum(c(1,2,3),c(2,3,4), f2);
sim_sum
#> [[1]]
#> [1]  9  9 25 49 49 49
```

### Proportion of the simulated random variable

``` r
f2<-function(x) x**2;
xs<-c(10,3,5,20,4,6);
sim_tran<-simulator_tran(xs)
sim_tran2<-simulator_tran(xs,f2);
simulator_prop(sim_tran);
#> 
#>  3  4 10 20 
#>  1  1  1  3
simulator_prop(sim_tran2)
#> 
#>  25  36 100 400 
#>   1   1   2   2
```

### Histogram of realized random variables

``` r
f2<-function(x) x**2;
xs<-c(10,3,5,20,4,6);
sim_tran<-simulator_tran(xs)
sim_tran2<-simulator_tran(xs,f2);
simulator_prop(sim_tran);
#> 
#>  4  5 20 
#>  2  3  1
simulator_bar(sim_tran);
```

<img src="man/figures/README-unnamed-chunk-12-1.png" width="100%" />

``` r
simulator_bar(sim_tran2)
```

<img src="man/figures/README-unnamed-chunk-12-2.png" width="100%" />

### Random variable Sequence Generator

This function allows to calculate the longest bounded sequence given a
defined arithmetic operation. We can simply track the decomposition of a
selected operation. The `tracking_operator` takes as input the
`sequence_long` which is the the sequence generator, `k` the index of a
given result and `i` the operation performed to get the result. We have
restrict ourselves to \(5\) operations per set of number sampled, where
\(1\leq i\leq 5\) and \(1\leq k\leq 5000\).

``` r
w<-sequence_long(sets = c(2L, 2L, 5L, 6L, 6L, 6L, 7L, 9L),
lowerb = -1e10,
upperb = 1e10)
tracking_operator(data = w, k=30,i=4)
#> The result of  15625  has been obtained by this set of numbers  2 9 6 5 6  and the following operation
#> [[1]]
#> function (e1, e2)  .Primitive("+")
#> 
#> [[2]]
#> function (e1, e2)  .Primitive("*")
#> 
#> [[3]]
#> function (e1, e2)  .Primitive("-")
#> 
#> [[4]]
#> function (e1, e2)  .Primitive("^")
#> 
#> [[5]]
#> function (e1, e2)  .Primitive("/")
tracking_operator(data = w, k=10, i=5)
#> The result of  13  has been obtained by this set of numbers  6 5 2 9 6  and the following operation
#> [[1]]
#> function (e1, e2)  .Primitive("*")
#> 
#> [[2]]
#> function (e1, e2)  .Primitive("/")
#> 
#> [[3]]
#> function (e1, e2)  .Primitive("/")
#> 
#> [[4]]
#> function (e1, e2)  .Primitive("-")
#> 
#> [[5]]
#> function (e1, e2)  .Primitive("+")
```

## Algebric description of Polynomials

The `PlynR` class allows to construct a family of polynomials in order
to manipulate arithmetic operations on polynomials and provide their
algebric decompisition. eg.: sum, multiplication, roots and
factorization.

### Algebric expression of a simple Polynom

``` r
printPol.plynR(c(1,2,30))
#> A polynom as  30*x^2 + 2*x + 1
```

### Algebric expression of a sum of Polynoms

``` r
printPol.plynR(plus.plynR(c(1,1,10), c(1,2,10)))
#> A polynom as  20*x^2 + 3*x + 2
```

### Algebric expression of a multiplication of Polynoms

``` r
printPol.plynR(fois.plynR(c(1,1,10), c(1,2,10)))
#> A polynom as  100*x^4 + 30*x^3 + 22*x^2 + 3*x + 1
```

### Algebric expression of a derivative of a Polynom

``` r
printPol.plynR(derive.plynR(c(1,1,10)))
#> A polynom as  20*x + 1
```

### Summary of Polynom with its factorization

``` r
summaryPol.plynR(plynR(c(1,2,3)))
#> A polynom as  3*x^2 + 2*x + 1
#>  Its factorization is =
#> [1] "(x+ 0.33 - 0.47i)" "(x+ 0.33 + 0.47i)"
```

You can check more the description on Cran\!
