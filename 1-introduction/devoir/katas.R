library(magrittr)

### Instructions.

## -- Remplacez les stop("???") par les bonnes expressions afin que la fonction
##    accomplice la tâche demandée.
##
## -- Ne modifiez rien d'autre!

### Informations.

## -- x && y est équivalent à if (x) y
##    (https://en.wikipedia.org/wiki/Short-circuit_evaluation).
##
## -- x %>% f est équivalent à f(x) et y %>% f(x, .) est équivalent à
##    f(x, y) (https://magrittr.tidyverse.org/).
##
## -- X %*% Y représente la multiplication matricielle, t(X) la
##    transposée de X, crossprod(X, Y) équivaut à t(X) %*% Y et
##    crossprod(X) à t(X) %*% X.
##
## -- N'hésitez pas à consulter la documentation si vous rencontrez des
##    fonctions qui vous sont inconnues.

### Kata 1.

## Implémentez la fonction circshift de Mathlab
## (https://www.mathworks.com/help/matlab/ref/circshift.html)
## -- v: vecteur.
## -- shift: entier.
circShift <- function(v, shift){
    ## Si v est vide, on retourne v sans modification.
    is.null(v) && return(v)

    ## On corrige pour shift < 0 et shift > n.
    n <- length(v)
    actual_shift <- as.numeric(shift) %% n

    ## Si actual_shift = 0, on retourne v sans modification.
    identical(as.numeric(actual_shift), 0) && return(v)

    rg <- seq(from = actual_shift+1, by = 1, length.out = n-actual_shift)

    c(v[rg], v[-rg])
}

### Kata 2.

## Implémentez autoCor, une fonction calculant l'autocorrélation
## circulaire d'ordre tau arbitraire. Indice: faites appel à la
## fonction circShift.
## -- v: vecteur.
## -- tau: lag.
circAutoCor <- function(v, tau)
    v %>%
        scale(scale = FALSE) %>%
        {crossprod(., circShift(v,tau)) / crossprod(.)} %>%
        as.numeric

### Kata 3.

## Implémentez prgnSimStudy, une fonction étudiant très sommairement
## les générateurs de nombres pseudo aléatoires implémentés par R.
## -- m: nombre de jeux de donnée à simuler.
## -- n: nombre de données par jeu de données.
## -- alpha: seuil du test.
prngSimStudy <- function(m, n = 1000, alpha = 0.05){
    ## Générateurs à tester.
    rngs <- c("Wichmann-Hill",
              "Marsaglia-Multicarry",
              "Super-Duper",
              "Mersenne-Twister",
              "Knuth-TAOCP-2002",
              "Knuth-TAOCP",
              "L'Ecuyer-CMRG")

    ## Sauvegarde du générateur courant.
    previous_rng <- RNGkind()[1]

    ## Test de chacun des générateurs.
    res <- sapply(rngs, function(rng){
        ## On choisi un générateur.
        RNGkind(rng)

        ## Données pour l'étude de simulation.
        dat <- matrix(data=runif(n=n*m),nrow=m,ncol=n)

        ## On applique le test de Ljung-Box à chacune des colonne pour
        ## détecter une éventuelle autocorrélation
        ## (https://www.mathworks.com/help/econ/ljung-box-q-test.html).
        lb_test <- apply(X = dat, MARGIN = 1, FUN = Box.test,
                         lag = log(n), type = "Ljung-Box")
        p_values <- sapply(lb_test, function(x) x[["p.value"]])

        ## On compte la proportion de p values inférieures au seuil fixé.
        sum(p_values[p_values<alpha]) / m
    })

    ## On rétablit le générateur précédant.
    RNGkind(kind = previous_rng)

    res
}

### Kata 4.

## Solution du premier problème du Projet Euler.
## (https://projecteuler.net/problem=1).
## -- uLim: limite supérieure.
euler1 <- function(uLim = 1e3){
    actual_uLim <- uLim-1

    mult5 <- seq(from = 5, to = actual_uLim, by = 5)
    mult3 <- seq(from = 3, to = actual_uLim, by = 3) %>%
        ## Indice: il manque un opérateur infixe et un vecteur.
        subset(!(. %in% mult5))

    sum(mult3, mult5)
}

### Kata 5.

## Calcul des nombres de Fibonacci. Il s'agit de la solution récursive
## naïve.
## -- n: nombre à calculer.
fib <- function(n){
    if(identical(as.numeric(n), 1) || identical(as.numeric(n), 2))
         return(1)

    fib(n-1) + fib(n-2)
}

### Kata 6.

## Calcul des nombres de Fibonacci. Solution récursive faisant appel à
## une technique célèbre de programmation dynamique: la memoïsation
## (https://bit.ly/2yNDySE).
## -- n: nombre à calculer.
fibMem <- function(n){
    mem <- c(rep(1, 2), rep(NA, max(n - 2, 0)))

    ## Si le nombre à la position n n'a pas déjà été calculé, on le
    ## calcule récursivement, mais en faisant appel aux nombres déjà
    ## calculés.
    getMem <- function(n){
        if (is.na(mem[n]))
            mem[n] <<-  getMem(n-1)+getMem(n-2) 
        mem[n]
    }

    getMem(n)
}

### Kata 7.

## Calcul des puissances d'une matrice diagonalisable.
## -- m: matrice.
## -- p: puissance.
## -- symmetric: TRUE si m est symmétrique.
powD <- function(m, p, symmetric = FALSE){
    if (identical(as.numeric(p), 1) ||
        identical(as.numeric(dim(m)), rep(1, 2)))
        return(m)

    ## Calcul de la décomposition spectrale de m
    ## (http://mathworld.wolfram.com/EigenDecomposition.html).
    eg <- eigen(m, symmetric)
    e_vectors <- eg$vectors
    e_values <- eg$values

    ## Si m est symmétrique, l'inverse de u est simplement sa
    ## transposée. Sinon, on calcule son inverse en appelant solve.
    inv <- ifelse(symmetric, t(e_vectors), solve(e_vectors))

    ## M^p = U(D^p)U^(-1)
    e_vectors%*%diag(as.numeric(e_values)^p)%*%inv
}

### Kata 8.

## Calcul des estimateurs d'un modèle de régression linéaire y = Xb.
## -- y: réponse.
## -- ...: vecteurs de la matrice de design.
lm_basic <- function(y, ...){
    X <- cbind(...)

    decomposition <- qr(X)
    r <- qr.R(decomposition)

    ## Estimateur de b. Remarquez qu'on appele qr.qty afin d'éviter le
    ## calcul explicite de la matrice Q pour calculer t(Q) %*% y.
    b <- backsolve(stop("???"), qr.qty(stop("???")))

    ## Estimateur du vecteur de résidu.
    e <- as.numeric(stop("???"))

    ## Estimateur de la variance.
    s2 <- as.numeric(stop("???") / stop("???"))

    r2 <- as.numeric(1 - stop("???") / crossprod(y - mean(y)))

    ## Estimateur de la variance de l'estimateur de b.
    s2b <- s2 * chol2inv(r)

    list(b = b, e = e, s2 = s2, r2 = r2, s2b = s2b)
}
