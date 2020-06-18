\name{GetHOPS}
\alias{GetHOPS}
\title{
    Get HOrizontal Pleiotropy Score (HOPS).
}
\description{
    Allows to compute the HOrizontal Pleiotropy Score (HOPS) from the matrix of whitened Zscores.
}
\usage{
GetHOPS(ZscoreWhitenedMatrix, RSids, LDCorrected = FALSE, POLYGENICITYCorrected = FALSE, NBSim = 25, GlobalTest = FALSE)
}
\arguments{
    \item{ZscoreWhitenedMatrix}{a data.frame of Z-scores with SNPs in rows and traits in columns. Careful no to include any column with SNP ids, SNP ids should be specified using the argument 'RSids', only Zscores should be included.}
    \item{RSids}{Character vector of RS ids, in the same order as rows of ZscoreWhitenedMatrix, used to match the SNPs to LD scores for the LD-corrected HOPS (in case argument 'LDCorrected' set to TRUE). RS ids must be in build 38.}
    \item{LDCorrected}{Boolean, TRUE if LD-corrected HOPS should be computed. Default is TRUE.}
    \item{POLYGENICITYCorrected}{Boolean, TRUE if polygenicity-corrected HOPS should be computed. Default is FALSE.}
    \item{NBSim}{Integer, Number of permutations to compute empirical P-values in case POLYGENICITYCorrected is set to TRUE. Default is 25.}
    \item{GlobalTest}{Boolean, if TRUE the results of the global test testing for a shift in the distribution of the HOPS for all SNPs. Default is FALSE.}
}
\value{
    \item{GlobalTest }{if 'GlobalTest' set to TRUE, P-value of the global test.}
    \item{HOPS }{data.frame containing the HOrizontal Pleiotropy Score (HOPS) for all SNPs}
}
\references{
    Daniel Jordan*, Marie Verbanck* and Ron Do. HOPS: a quantitative score reveals pervasive horizontal pleiotropy in human genetic variation is driven by extreme polygenicity of human traits and diseases. Genome Biology 20, 222 (2019).
}
\author{
    Marie Verbanck
}
\examples{
    # Load a subset of the UK Biobank summary statistics
    data(UKBiobank_ZscoresSubset)
    # Apply the whitening procedure
    ZscoreMatrixWhitened_UKBB <- GetWhitenedZscores(ZscoreMatrix = ZscoreMatrix_UKBB, ZscoreCorMatrix = ZscoreCorMatrix_UKBB)
    # Get the LD-corrected HOPS
    HOPS_UKBB <- GetHOPS(ZscoreWhitenedMatrix = ZscoreMatrixWhitened_UKBB, RSids = SNPinfo_UKBB$SNPid, LDCorrected = TRUE, POLYGENICITYCorrected = FALSE, GlobalTest = TRUE)
    # Results
    GlobalTest_UKBB <- HOPS_UKBB[[1]]
    HOPS_UKBB <- HOPS_UKBB[[2]]
}