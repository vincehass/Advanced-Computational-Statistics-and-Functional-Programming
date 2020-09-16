fact <- function(x){
    x < 0 && return(1) # Équivaut à if (x < 0) return(1).
    x * fact(x - 1)
}

fact(5)

fact <- function(x){
    x < 0 && return(1)

    print(x)

    x * fact(x - 1)
}

fact(5)

fact <- function(x){
    x <= 0 && return(1)
    x * fact(x - 1)
}

fact(5)

library(magrittr)

cutVector <- function(vec, m)
    list(n = length(vec) / m) %$%
        {lapply(0:(m - 1),
                function(x) vec[seq(n * x + 1, n * (x + 1))])}

dist0 <- function(m, n = 1e4){
    dat <- sample(0:9, size = n * m, replace = TRUE) %>%
        cutVector(m)

    lapply(dat, function(v) sapply(v, identical, y = 0)) %>%
        sapply(mean)
}

dist0(10)

dist0(10)

dist0 <- function(m, n = 1e4){
    dat <- sample(0:9, size = n * m, replace = TRUE) %>%
        cutVector(m) %>%
        lapply(as.numeric)

    lapply(dat, function(v) sapply(v, identical, y = 0)) %>%
        sapply(mean)
}

dist0(10)

dist0 <- function(m, n = 1e4){
    dat <- sample(0:9, size = n * m, replace = TRUE) %>%
        cutVector(m)

    lapply(dat, function(v) sapply(v, identical, y = 0L)) %>%
        sapply(mean)
}

dist0(10)

lmSlow <- function(m){
    res <- list()

    for (kk in 1:m){
        random_values <- rnorm(1e6)
        X <- matrix(random_values, ncol = 20)
        y <- rnorm(5e4)
        reg <- lm(y ~ X)
        b <- coef(reg)
        res %<>% append(coef)
    }
    res
}

system.time(lmSlow(20))

lmFast <- function(m){
    Xs <- rnorm(1e6 * m) %>%      ## Génération des données.
        cutVector(m) %>%          ## 1 entrée = 1 simulation.
        lapply(matrix, ncol = 20) ## vecteur -> matrice.

    ys <- rnorm(5e4 * m) %>%
        cutVector(m)

    mapply(function(X, y) lm(y ~ X) %>% coef, Xs, ys)
}

system.time(lmFast(20))

library(microbenchmark)

mb <- microbenchmark(lmSlow(10), lmFast(10), times = 20)
print(mb)

plot(mb)
