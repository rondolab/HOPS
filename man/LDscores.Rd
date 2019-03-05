\name{LDscores}
\alias{LDscores}
\docType{data}
\title{
	LD scores values
}
\description{
	LD scores downloaded from https://data.broadinstitute.org/alkesgroup/LDSCORE/1000G_Phase3_baseline_v1.1_ldscores.tgz and compiled into a data.frame.). LD scores are used in 'GetPleiotropyScore()'
		
}
\usage{data("LDscores")}
A data frame with 1,190,321 observations on the following 4 variables.
\describe{
  \item{\code{CHR}}{a numeric vector of chromosome number.}
  \item{\code{SNP}}{a character vector of RS ids (build 38).}
  \item{\code{BP}}{a numeric vector of chomosomal position.}
  \item{\code{baseL2}}{a numeric vector of LD scores.}
}

\references{
    Daniel Jordan*, Marie Verbanck* and Ron Do. Pervasive pleiotropy driven by extreme polygenicity in the human genome revealed by a novel quantitative analysis of summary association statistics. BioRxiv.
}