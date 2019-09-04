library(testthat)
library(magrittr)

### Insctructions.

## -- Ouvrez une session R dans ce répertoire.
##
## -- Invoquez la fonction test_file avec comme argument le nom de ce fichier:
##      testthat::test_file("test_katas.R")
##
## -- Recommencer jusqu'à ce que tous les tests réussissent.

source("katas.R")

## Kata 1.
context("Vérification du kata 1.")
test_that("Kata 1", {
    n_lim <- 100
    shift_lim <- 1000

    replicate(500, {
        shift <- sample(-shift_lim:shift_lim, 1)
        n <- sample(n_lim, 1)
        vec <- sample(letters, n, replace = TRUE)
        shifted_vec <- circShift(vec, shift)

        ## Vecteur vide.
        expect_identical(circShift(c(), shift), c())

        ## Préservation de la longueur.
        expect_length(shifted_vec, n)

        ## Inverse.
        expect_identical(circShift(circShift(vec, shift), -shift), vec)

        ## Points fixes.
        mult <- sample(0:10, 1) %>% as.numeric
        expect_identical(circShift(vec, n * mult), vec)
    })
})

## Kata 2.
context("Vérification du kata 2.")
test_that("Kata 2", {
    n_lim <- 100
    shift_lim <- 1000

    replicate(500, {
        shift <- sample(-shift_lim:shift_lim, 1)
        n <- sample(n_lim, 1)
        vec <- sample(1000, n)

        expect_equal(circAutoCor(vec, shift), cor(vec, circShift(vec, shift)))
    })
})

## Kata 3.
context("Vérification du kata 3.")
test_that("Kata 3", {
    set.seed(42)
    expected <- c(0.07, 0.04, 0.07, 0.01, 0.01, 0.01, 0.05)
    names(expected) <- c("Wichmann-Hill",
                         "Marsaglia-Multicarry",
                         "Super-Duper",
                         "Mersenne-Twister",
                         "Knuth-TAOCP-2002",
                         "Knuth-TAOCP",
                         "L'Ecuyer-CMRG")
    expect_identical(prngSimStudy(100), expected)

    set.seed(0)
    expected <- c(0.02, 0.05, 0.03, 0.03, 0.06, 0.03, 0)
    names(expected) <- c("Wichmann-Hill",
                         "Marsaglia-Multicarry",
                         "Super-Duper",
                         "Mersenne-Twister",
                         "Knuth-TAOCP-2002",
                         "Knuth-TAOCP",
                         "L'Ecuyer-CMRG")
    expect_identical(prngSimStudy(100), expected)
})

## Kata 4.
context("Vérification du kata 4.")
test_that("Kata 4", {
    expect_identical(euler1(), 233168)
    expect_identical(euler1(53478), 667261050)
    expect_identical(euler1(1347629), 423757536795)
})


## Kata 5.
context("Vérification du kata 5.")
test_that("Kata 5", {
    expect_identical(fib(1), 1)
    expect_identical(fib(2), 1)
    expect_identical(fib(7), 13)
    expect_identical(fib(13), 233)
    expect_identical(fib(25), 75025)
})

## Kata 6.
context("Vérification du kata 6.")
test_that("Kata 6", {
    expect_identical(fibMem(1), 1)
    expect_identical(fibMem(2), 1)
    expect_identical(fibMem(7), 13)
    expect_identical(fibMem(13), 233)
    expect_identical(fibMem(25), 75025)
})

## Kata 7.
context("Vérification du kata 7.")
test_that("Kata 7", {
      ## Element nul.
    replicate(250, {
        mat_dim <- sample(100, 1)
        mat <- matrix(rnorm(mat_dim^2), mat_dim)

        expect_equal(powD(mat, 1), mat)
    })

    ## Matrices symmétriques.
    replicate(250, {
        mat_dim <- as.numeric(sample(100, 1))
        p <- sample(100, 1)
        l <- matrix(rnorm(mat_dim^2), mat_dim)
        l[lower.tri(l)] <- 0
        mat <- l %*% t(l)

        if (identical(p, 1))
            expect_identical(powD(mat, p, TRUE), mat)
        else
            expect_equal(powD(mat, p, TRUE),
                         Reduce(`%*%`, list(mat)[rep(1, p - 1)], mat))
    })

    ## Matrices non symmétriques.
    replicate(250, {
        mat_dim <- as.numeric(sample(100, 1))
        p <- sample(100, 1)
        u <- matrix(rnorm(mat_dim^2), mat_dim)
        r_sucks <- ifelse(identical(mat_dim, 1), as.matrix, diag)
        mat <- u %*% r_sucks(rnorm(mat_dim)) %*% solve(u)

        if (identical(p, 1))
            expect_identical(powD(mat, p), mat)
        else
            expect_equal(powD(mat, p),
                         Reduce(`%*%`, list(mat)[rep(1, p - 1)], mat))
    })
})

## Kata 8.
context("Vérification du kata 8.")
test_that("Kata 8", {
    ## cars.
    reg1 <- cars %$% lm(speed ~ dist)
    reg_basic1 <- cars %$% lm_basic(speed, 1, dist)

    expect_equal(reg_basic1$b, coefficients(reg1), check.attributes = FALSE)
    expect_equal(reg_basic1$e, residuals(reg1), check.attributes = FALSE)
    expect_equal(reg_basic1$s2, summary(reg1)$sigma^2)
    expect_equal(reg_basic1$r2, summary(reg1)$r.squared)
    expect_equal(reg_basic1$s2b, vcov(reg1), check.attributes = FALSE)

    ## trees.
    reg2 <- trees %$% lm(Girth ~ Height + Volume)
    reg_basic2 <- trees %$% lm_basic(Girth, 1, Height, Volume)

    expect_equal(reg_basic2$b, coefficients(reg2), check.attributes = FALSE)
    expect_equal(reg_basic2$e, residuals(reg2), check.attributes = FALSE)
    expect_equal(reg_basic2$s2, summary(reg2)$sigma^2)
    expect_equal(reg_basic2$r2, summary(reg2)$r.squared)
    expect_equal(reg_basic2$s2b, vcov(reg2), check.attributes = FALSE)
})
