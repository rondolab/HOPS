\name{GetWhitenedZscores}
\alias{GetWhitenedZscores}
\title{
    Get Whitened Z-scores
}
\description{
    Get whitened Z-scores from a matrix of Z-scores (SNPs in rows, traits in columns) and a correlation matrix between traits.
}
\usage{
    GetWhitenedZscores(ZscoreMatrix, ZscoreCorMatrix = NULL)
}
\arguments{
    \item{ZscoreMatrix}{data.frame of Z-scores with SNPs in rows and traits in columns.}
    \item{ZscoreCorMatrix}{data.frame of pairwise correlations between traits based on Z-scores. Usually computed using a pruned set of SNPs, see function 'GetCorrelationMatrix()'. If set to NULL, the full set of SNPs included in ZscoreMatrix is used. Default is NULL.}
}
\value{
    \item{ZscoreWhitenedMatrix }{data.frame of the same size as 'ZscoreMatrix' composed of whitened Z-scores.}
}
\references{
    Daniel Jordan*, Marie Verbanck* and Ron Do. HOPS: a quantitative score reveals pervasive horizontal pleiotropy in human genetic variation is driven by extreme polygenicity of human traits and diseases. Genome Biology 20, 222 (2019).
}
\author{
    Marie Verbanck
}
\seealso{
    \code{\link{GetCorrelationMatrix}}
}
\examples{
    data(UKBiobank_ZscoresSubset)
    ZscoreMatrixWhitened_UKBB <- GetWhitenedZscores(ZscoreMatrix = ZscoreMatrix_UKBB, ZscoreCorMatrix = ZscoreCorMatrix_UKBB)
}