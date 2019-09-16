library(magrittr)
library(microbenchmark)

add1 <- function(x) x + 1

add2 <- function(x) x + 2

for_add1_twice <- function(n){
    res <- integer(n)
    for (kk in 1:n)
        res[n] <- add1(add1(rpois(1, 1)))

    res
}

for_add2 <- function(n){
    res <- integer(n)
    for (kk in 1:n)
        res[n] <- add2(rpois(1, 1))

    res
}

for_noCall <- function(n){
    res <- integer(n)
    for (kk in 1:n)
        res[n] <- rpois(1, 1) + 2

    res
}

sapply_add1_twice <- function(n)
    sapply(rpois(n, 1), function(x) add1(add1(x)))

sapply_add2 <- function(n) sapply(rpois(n, 1), add2)

sapply_noCall <- function(n) sapply(rpois(n, 1), `+`, y = 1)

add2_correct <- function(n) rpois(n, 1) + 2


lcg <- function(a, b, m,
                seed = 0)
  function(){
    ret <- (a * seed + b) %% m
    seed <<- ret
    ret / m
  }

## LCG de numerical recipes.
nr_lcg <- lcg(1664525, 1013904223, 2^32)

rand_prealloc <- function(n){
    res <- numeric(n)
    for (kk in 1:n)
        res[kk] <- nr_lcg()

    res
}

rand_vec <- function(n){
    replicate(n, nr_lcg())
}

seed <- 42
lcg_bad <- function(a, b, m)
  function(){
    ret <- (a * seed + b) %% m
    seed <<- ret
    ret / m
  }

## microbenchmark(for_add1_twice(1e4), for_add2(1e4), for_noCall(1e4))
## microbenchmark(sapply_add1_twice(1e4), sapply_add2(1e4), sapply_noCall(1e4))
## microbenchmark(add2_correct, unit = "ms")
