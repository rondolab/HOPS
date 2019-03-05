\name{GetPleiotropyScore}
\alias{GetPleiotropyScore}
\title{
    Get Pleiotropy Score.
}
\description{
    Allows to compute the pleiotropy score from the matrix of whitened Zscores.
}
\usage{
GetPleiotropyScore(ZscoreWhitenedMatrix, RSids, LDCorrected = FALSE, POLYGENICITYCorrected = FALSE, NBSim = 25, GlobalTest = FALSE)
}
\arguments{
    \item{ZscoreWhitenedMatrix}{a data.frame of Z-scores with SNPs in rows and traits in columns. Careful no to include any column with SNP ids, SNP ids should be specified using the argument 'RSids', only Zscores should be included.}
    \item{RSids}{Character vector of RS ids, in the same order as rows of ZscoreWhitenedMatrix, used to match the SNPs to LD scores for the LD-corrected pleiotropy score (in case argument 'LDCorrected' set to TRUE). RS ids must be in build 38.}
    \item{LDCorrected}{Boolean, TRUE if LD-corrected pleiotropy score should be computed. Default is TRUE.}
    \item{POLYGENICITYCorrected}{Boolean, TRUE if polygenicity-corrected pleiotropy score should be computed. Default is FALSE.}
    \item{NBSim}{Integer, Number of permutations to compute empirical P-values in case POLYGENICITYCorrected is set to TRUE. Default is 25.}
    \item{GlobalTest}{Boolean, if TRUE the results of the global test testing for a shift in the distribution of the pleiotropy score for all SNPs. Default is FALSE.}
}
\value{
    \item{GlobalTest }{if 'GlobalTest' set to TRUE, P-value of the global test.}
    \item{PleiotropyScore }{data.frame containing the pleiotropy score for all SNPs}
}
\references{
    Daniel Jordan*, Marie Verbanck* and Ron Do. Pervasive pleiotropy driven by extreme polygenicity in the human genome revealed by a novel quantitative analysis of summary association statistics. BioRxiv.
}
\author{
    Marie Verbanck
}
\examples{
    # Load a subset of the UK Biobank summary statistics
    data(UKBiobank_ZscoresSubset)
    # Apply the whitening procedure
    ZscoreMatrixWhitened_UKBB <- GetWhitenedZscores(ZscoreMatrix = ZscoreMatrix_UKBB, ZscoreCorMatrix = ZscoreCorMatrix_UKBB)
    # Get the LD-corrected pleiotropy score
    PleiotropyScores_UKBB <- GetPleiotropyScore(ZscoreWhitenedMatrix = ZscoreMatrixWhitened_UKBB, RSids = SNPinfo_UKBB$SNPid, LDCorrected = TRUE, POLYGENICITYCorrected = FALSE, GlobalTest = TRUE)
    # Results
    GlobalTest_UKBB <- PleiotropyScores_UKBB[[1]]
    PleiotropyScores_UKBB <- PleiotropyScores_UKBB[[2]]
}