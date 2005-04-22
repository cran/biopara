\name{pboot}
\alias{pboot}
\title{Parallel Bootstrap}
\description{ Pboot is a parallelized version of the standard boot() function}
\usage{pboot(bioparatarget, bioparasource, bioparanruns, data2, statistic, R, sim="ordinary", stype="i",strata=rep(1,n), L=NULL, m=0, weights=NULL, ran.gen=function(d, p) d, mle=NULL, ...)}
\arguments{
\item{bioparatarget}{ A list containing a string for the hostname of the machine running the master process and a number for the port number of the masters client port}
\item{bioparasource}{ A list containing a string for the hostname of the machine running the client and a number for the local port to receive the return connection from the master. The local port is chosen arbitrarily by user. }
\item{bioparanruns}{ A double indicating the number of times to run the item in bioparafxn. This is ignored if there are multiple items in bioparafxn. Multiple items will generate 1 run for each item in the bioparafxn list. If bioparafxn is ignored for special commands.  The special command "setenv" allows bioparanruns to be substituted with a list.}
\item{data2}{The data as a vector, matrix or data frame. If it is a matrix or data frame then each row is considered as one multivariate observation.}
\item{statistic}{A function which when applied to data returns a vector containing the statistic(s) of interest. When sim="parametric", the first argument to statistic must be the data. For each replicate a simulated dataset returned by ran.gen will be passed. In all other cases statistic must take at least two arguments. The first argument passed will always be the original data. The second will be a vector of indices, frequencies or weights which define the bootstrap sample. Further, if predictions are required, then a third argument is required which would be a vector of the random indices used to generate the bootstrap predictions. Any further arguments can be passed to statistic through the ...{} argument.}
\item{R}{The number of bootstrap replicates. Usually this will be a single positive integer. For importance resampling, some resamples may use one set of weights and others use a different set of weights. In this case R would be a vector of integers where each component gives the number of resamples from each of the rows of weights.}
\item{sim}{A character string indicating the type of simulation required. Possible values are "ordinary" (the default), "parametric", "balanced", "permutation", or "antithetic". Importance resampling is specified by including importance weights; the type of importance resampling must still be specified but may only be "ordinary" or "balanced" in this case.}
\item{stype}{A character string indicating what the second argument of statistic represents. Possible values of stype are "i" (indices - the default), "f" (frequencies), or "w" (weights).}
\item{strata}{An integer vector or factor specifying the strata for multi-sample problems. This may be specified for any simulation, but is ignored when sim is "parametric". When strata is supplied for a nonparametric bootstrap, the simulations are done within the specified strata.}
\item{L}{Vector of influence values evaluated at the observations. This is used only when sim is "antithetic". If not supplied, they are calculated through a call to empinf. This will use the infinitesimal jackknife provided that stype is "w", otherwise the usual jackknife is used.}
\item{m}{The number of predictions which are to be made at each bootstrap replicate. This is most useful for (generalized) linear models. This can only be used when sim is "ordinary". m will usually be a single integer but, if there are strata, it may be a vector with length equal to the number of strata, specifying how many of the errors for prediction should come from each strata. The actual predictions should be returned as the final part of the output of statistic, which should also take a vector of indices of the errors to be used for the predictions.}
\item{weights}{Vector or matrix of importance weights. If a vector then it should have as many elements as there are observations in data. When simulation from more than one set of weights is required, weights should be a matrix where each row of the matrix is one set of importance weights. If weights is a matrix then R must be a vector of length nrow(weights). This parameter is ignored if sim is not "ordinary" or "balanced".}
\item{ran.gen}{This function is used only when sim is "parametric" when it describes how random values are to be generated. It should be a function of two arguments. The first argument should be the observed data and the second argument consists of any other information needed (e.g. parameter estimates). The second argument may be a list, allowing any number of items to be passed to ran.gen. The returned value should be a simulated data set of the same form as the observed data which will be passed to statistic to get a bootstrap replicate. It is important that the returned value be of the same shape and type as the original dataset. If ran.gen is not specified, the default is a function which returns the original data in which case all simulation should be included as part of statistic. Use of sim="parametric" with a suitable ran.gen allows the user to implement any types of nonparametric resampling which are not supported directly.}
\item{mle}{The second argument to be passed to ran.gen. Typically these will be maximum likelihood estimates of the parameters. For efficiency mle is often a list containing all of the objects needed by ran.gen which can be calculated using the original data set only.}
\item{...}{Any other arguments for statistic which are passed unchanged each time it is called. Any such arguments to statistic must follow the arguments which statistic is required to have for the simulation.}
}
\details{ Pboot is an example function for use with the biopara parallel system. It is essentially a wrapper around the R boot function. It assumes that there is a running cluster. The first 3 arguments are identical to biopara and the remaining arguments are identical to R boot. The pboot function call returns a list of boot objects identical to the original R boot.}
\value{
The returned value is a list of bioparanruns objects of class "boot", each containing the following components :
\item{t0}{The observed value of statistic applied to data.}
\item{t}{A matrix with R rows each of which is a bootstrap replicate of statistic.}
\item{R}{The value of R as passed to boot.}
\item{data}{The data as passed to boot.}
\item{seed}{The value of .Random.seed when boot was called.}
\item{statistic}{The function statistic as passed to boot.}
\item{sim}{Simulation type used.}
\item{stype}{Statistic type as passed to boot.}
\item{call}{The original call to boot as a character array.}
\item{strata}{The strata used. This is the vector passed to boot, if it was supplied or a vector of ones if there were no strata. It is not returned if sim is "parametric".}
\item{weights}{The importance sampling weights as passed to boot or the empirical distribution} function weights if no importance sampling weights were specified. It is omitted if sim is not one of "ordinary" or "balanced".
\item{pred.i}{If predictions are required (m>0) this is the matrix of indices at which predictions were calculated as they were passed to statistic. Omitted if m is 0 or sim is not "ordinary".}
\item{L}{The influence values used when sim is "antithetic". If no such values were specified and stype is not "w" then L is returned as consecutive integers corresponding to the assumption that data is ordered by influence values. This component is omitted when sim is not "antithetic".}
\item{ran.gen}{The random generator function used if sim is "parametric". This component is omitted for any other value of sim.}
\item{mle}{The parameter estimates passed to boot when sim is "parametric". It is omitted for all other values of sim.}
}
\references{}
\author{ Peter Lazar  
  \email{plazar@amber.mgh.harvard.edu}
         and
         David Schoenfeld 
  \email{dschoenfeld@partners.org}
}
\notes{}
\seealso{\code{\link{boot.array},\link{boot}}}
\examples{
#These examples assume a master called my.server.edu running on port 39000 and a client 
#1.2.3.4 using return port 40000. This can be configured by running the single machine
#example at the bottom of user function biopara.
#The examples are copied from the standard function boot and shown run through biopara in parallel.

#We need to load the boot library to get the datasets. This will need to be done for the workers
library(boot)

data(city);
ratio <- function(d, w) sum(d$x * w)/sum(d$u * w)
\dontrun{out<-biopara(list("localhost",39000),list("localhost",40000),1,list("setenv"))}
#Since we are using a data set directly, we will need to query the number of servers and send
#that many runs library and data
\dontrun{out<-biopara(list("localhost",39000),list("localhost",40000),1,list("numservers"))}
\dontrun{out<-biopara(list("localhost",39000),list("localhost",40000),out,list("library(boot);data(city)"))}
#Finally a call to pboot
\dontrun{out<-pboot(list("localhost",39000),list("localhost",40000),5,city, ratio, R=999, stype="w")}


#We do not have to call biopara on data here since the data set becomes a user defined object
data(gravity)
diff.means <- function(d, f)
{    n <- nrow(d)
     gp1 <- 1:table(as.numeric(d$series))[1]
     m1 <- sum(d[gp1,1] * f[gp1])/sum(f[gp1])
     m2 <- sum(d[-gp1,1] * f[-gp1])/sum(f[-gp1])
     ss1 <- sum(d[gp1,1]^2 * f[gp1]) - 
            (m1 *  m1 * sum(f[gp1]))
     ss2 <- sum(d[-gp1,1]^2 * f[-gp1]) - 
            (m2 *  m2 * sum(f[-gp1]))
     c(m1-m2, (ss1+ss2)/(sum(f)-2))
}
grav1 <- gravity[as.numeric(gravity[,2])>=7,]
\dontrun{out<-biopara(list("localhost",39000),list("localhost",40000),1,list("setenv"))}
\dontrun{out<-pboot(list("localhost",39000),list("localhost",40000),5,grav1, diff.means, R=999, stype="f", strata=grav1[,2])}


data(nuclear)
nuke <- nuclear[,c(1,2,5,7,8,10,11)]
nuke.lm <- glm(log(cost)~date+log(cap)+ne+ ct+log(cum.n)+pt, data=nuke)
nuke.diag <- glm.diag(nuke.lm)
nuke.res <- nuke.diag$res*nuke.diag$sd
nuke.res <- nuke.res-mean(nuke.res)
nuke.data <- data.frame(nuke,resid=nuke.res,fit=fitted(nuke.lm))
new.data <- data.frame(cost=1, date=73.00, cap=886, ne=0, ct=0, cum.n=11, pt=1)
new.fit <- predict(nuke.lm, new.data)
nuke.fun <- function(dat, inds, i.pred, fit.pred, x.pred)
{
     assign(".inds", inds, envir=.GlobalEnv)
     lm.b <- glm(fit+resid[.inds] ~date+log(cap)+ne+ct+
          log(cum.n)+pt, data=dat)
     pred.b <- predict(lm.b,x.pred)
     remove(".inds", envir=.GlobalEnv)
     c(coef(lm.b), pred.b-(fit.pred+dat$resid[i.pred]))
}
\dontrun{out<-biopara(list("localhost",39000),list("localhost",40000),1,list("setenv"))}
\dontrun{nuke.boot<-pboot(list("localhost",39000),list("localhost",40000),5,nuke.data, nuke.fun, R=999, m=1, fit.pred=new.fit, x.pred=new.data)}
#The bootstrap prediction error for the first bootstrap
\dontrun{mean(nuke.boot[[1]][[2]][,8]^2)}
#Basic bootstrap prediction limits on first bootstrap
\dontrun{new.fit-sort(nuke.boot[[1]][[2]][,8]^2)[c(975,25)]}

}
\keyword{ misc }
\keyword{ utilities }
\keyword{ optimize }
\keyword{ manip }
\keyword{ data }
