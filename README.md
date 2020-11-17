
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fnpol

<!-- badges: start -->

<!-- badges: end -->

The goal of fnpol is to provide functionalities for fast computation for
the following methods: Fast fourrier methods, inverse generator
simulation and polynomials series.

## Installation

You can install the released version of fnpol from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("fnpol")
```

```{r setup}
library(fnpol)
```

This package describes functionalities for fast computation with the following methods: 
Fast fourier method `fft_c2`, random variable simulator which provides transformation such as sum `simulateur_sum`, proportion `simulateur_prop` and summary distribution `simulateur_bar`. In addition, we provide a class of polynomial that return a symbolic polynomials, their transformation such that sum of polynomials, multiplication of polynomials, derivative of polynomials and summary statistics which give their respective factorization.


## Fast Fourier Method
### Naive form Fast Fourier Inverse
```{r}
vec_com<-sample(complex(real=sample(1:20,16), imaginary = sample(1:20,16)),16)
vec_com
dft1_naive(vec_com,k=3)
```

### Iterative Form for Fast Fourier Transform
```{r}

dft1_iter(vec_com,k=3)
```
### Matrix Form for Fast Fourier Transform
```{r}

dft1_matrix(vec_com,k=3)
```
### Comparaison of all methods for Fast Fourier Transform
```{r}
c(all.equal(dft_factory_all(vec_com)[,1], Im(fft(vec_com))),
  all.equal(dft_factory_all(vec_com)[,2], Im(fft(vec_com))),
  all.equal(dft_factory_all(vec_com)[,3], Im(fft(vec_com))))
```




### Fibonacci sequence
```{r}
fib_mulPos_rec(3)
```
###  Scalable Fast Fourier Transform
```{r}
fft_ct2(vec_com)
```

## Comparaison tool Fast Fourier Transform

```{r}
all.equal(fft_ct2(vec_com), fft(vec_com))
```


## Generator of random variable

### Generator of a transformed Discrete distribution

This function generate a vector of realization from the same distribution of the input vector. The user can specify a transformation on the input vector otherwise it will return the identity transformation.

```{r}
f2<-function(x) x**2;
xs<-c(10,3,5,20,4,6);
simulator_tran<-function(xs,trans=identity) lapply(list(length(xs)),simulator(xs, trans))
sim_tran<-simulator_tran(xs)
```


### Generator of a sum of random variables
This function allows to the user to generate the sum of two generators. The user could specify a transformation for the input otherwise it will return the identity transformation.

```{r}
simulator_sum<-function(v1,v2,trans=identity){
lapply(list(length(c(v1,v2))),realization_sum(v1,v2, trans))};
simulator_sum(c(1,2,3),c(2,3,4), identity);
f2<-function(x) x**2;
sim_sum<-simulator_sum(c(1,2,3),c(2,3,4), f2);
sim_sum
```

### Proportion of the simulated random variable
```{r}
f2<-function(x) x**2;
xs<-c(10,3,5,20,4,6);
sim_tran<-simulator_tran(xs)
sim_tran2<-simulator_tran(xs,f2);
simulator_prop(sim_tran);
simulator_prop(sim_tran2)
```

### Histogram of realized random variables

```{r}
f2<-function(x) x**2;
xs<-c(10,3,5,20,4,6);
sim_tran<-simulator_tran(xs)
sim_tran2<-simulator_tran(xs,f2);
simulator_prop(sim_tran);
simulator_bar(sim_tran);
simulator_bar(sim_tran2)
```

### Random variable Sequence Generator 
This function allows to calculate the longest bounded sequence given a defined arithmetic operation. We can simply track the decomposition of a selected operation, we give two examples below.

```{r}
w<-sequence_long(sets = c(2L, 2L, 5L, 6L, 6L, 6L, 7L, 9L),
lowerb = -1e10,
upperb = 1e10,
nb_iters = 1e5L)
tracking_operator(w,k=10,4)
tracking_operator(w,k=100,5)
```

## Algebric description of Polynomials

The `PlynR` class allows to construct a family of polynomials in order to manipulate arithmetic operations on polynomials and provide their algebric decompisition. eg.: sum, multiplication, roots and factorization.

### Algebric expression of a simple Polynom
```{r}
printPol.plynR(c(1,2,30))
```

### Algebric expression of a sum of Polynoms

```{r}
printPol.plynR(plus.polynR(c(1,1,10), c(1,2,10)))
```

### Algebric expression of a multiplication of Polynoms

```{r}
printPol.plynR(fois.plynR(c(1,1,10), c(1,2,10)))
```

### Algebric expression of a derivative of a Polynom

```{r}
printPol.plynR(derive.plynR(c(1,1,10)))
```


### Summary of Polynom with its factorization

```{r}
summaryPol.plynR(plynR(c(1,2,3)))
```





You can check more the description on GitHub\!
