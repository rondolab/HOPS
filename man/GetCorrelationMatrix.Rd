\name{GetCorrelationMatrix}
\alias{GetCorrelationMatrix}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
    Get Z-scores Correlation Matrix
}
\description{
    Allows to obtain the pairwise correlation matrix between Z-scores.
}
\usage{
    GetCorrelationMatrix(ZscoreMatrix)
}

\arguments{
    \item{ZscoreMatrix}{a data.frame of Z-scores with SNPs in rows and traits in columns. Careful no to include any column with SNP ids, only Zscores should be included.}
}
\value{
    \item{ZscoreCorMatrix}{returns the pairwise correlation matrix between Z-scores}
}
\references{
    Daniel Jordan*, Marie Verbanck* and Ron Do. Pervasive pleiotropy driven by extreme polygenicity in the human genome revealed by a novel quantitative analysis of summary association statistics. BioRxiv.
}
\author{
    Marie Verbanck
}
\section{Warning }{
   For further computation of the HOrizontal Pleiotropy Score (HOPS), only traits with a paiwise correlation level lower than 0.8 (in absolute value) should be included.
}
\examples{
    data(UKBiobank_ZscoresSubset)
    ZscoreCorMatrixAllSNPs_UKBB <- GetCorrelationMatrix(ZscoreMatrix_UKBB)
}