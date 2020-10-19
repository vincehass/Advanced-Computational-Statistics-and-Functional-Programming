
#Question 1
#a)

vec<-c(2,10,4,6)
n<-100

simulateur1<-function(n){
  
  names(vec) <- as.character(vec)
  samples<- numeric(n)
  
  
  discrete_inv<- function(vec) {
    u<-runif(1)
    vect<-vec/sum(vec)
    if(u <= vect[1]){
      return(vec[1])
    }
    for(pos in 2:length(vec)) {
      if(sum(vect[1:(pos-1)]) < u && u <= sum(vect[1:pos]) ) {
        return(vec[pos])
      }
    }
    
  }
  
  for(i in seq_len(n) ) {
    samples[i] <- discrete_inv(vec)
  }
  return(samples)
  }


#b)

discrete_inverse_tran<-function(sim,trans){
  tr<<-function(x) trans
  return(sim(tr(x)))
  
}


simulateur2<-function(sim, trans){
  
  n<-length(sim)
  samples<- numeric(n)
  for(i in seq_len(n) ) {
    samples[i] <- discrete_inverse_tran(discrete_inv, trans)
  }
  
  return(samples)
}

simulateur2(simulateur1(100), vec**2)




### Question c)

simulateur_sum<-function(sim1, sim2){
  
  if(length(sim1) < length(sim2)){
    x_bis<-c(sim1, rep(0,abs(length(sim1)-length(sim2))))  
    x_bis<-x_bis+sim2
  }else if(length(sim2) < length(sim1)){
    x_bis<-c(sim2, rep(0,abs(length(sim1)-length(sim2))))  
    x_bis<-x_bis+sim1
  }else{
    x_bis<-sim1+sim2
  }
  
  return(simulateur2(simulateur1(length(x_bis)), x_bis))
  
}

simulateur_sum(simulateur1(100),simulateur2(simulateur1(100), vec**2))
simulateur_sum(simulateur1(10),simulateur1(50))


#Question d)

simulateur_prop<-function(sim){
  return(table(sim)/length(sim))
  
}


simulateur_prop(simulateur1(100))
simulateur_prop(simulateur2(simulateur1(100), vec**2))
simulateur_prop(simulateur_sum(simulateur1(n),simulateur2(simulateur1(n), vec**2)))

#Question e)

simulateur_bar<-function(sim){
  par(mfrow=c(1,2))
  names(vec)<-as.character(vec)
  barplot(vec, main='Vraie Distribution')
  barplot(simulateur_prop(sim), main='Distribution Empirique')
}

simulateur_bar(simulateur1(n))
simulateur_bar(simulateur2(simulateur1(n), vec**2))
simulateur_bar(simulateur_sum(simulateur1(n),simulateur2(simulateur1(n), vec**2)))


#Question 2)

x<-c(2,2,5,6,6,6,7,9)

NbSerie<-function(l){
  
  c((`*`(`+`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
    (`^`(`+`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
    (`^`(`-`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
    (`^`(`+`(`-`(`^`(l[1],l[2]),l[3]),l[4]),l[5])),
    (`^`(`*`(`*`(`^`(l[1],l[2]),l[3]),l[4]),l[5])))
}


models<-c("model.1", "model.2","model.3","model.4","model.5")
ab<-t(apply(combn(x,5),2,NbSerie))
colnames(ab)<-c(models)

#Pour la ligne 5 par exemple cette combinaison a ete generee par les chiffres:
combn(x,5)[,20]
#[1] 2 2 6 7 9
#toutes les combiniaisons qui sont dans l intervalles sont 
subset(ab,ab[ab>-1*10^10] && ab[ab<1*10^10])



