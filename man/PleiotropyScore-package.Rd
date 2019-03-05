\name{PleiotropyScore-package}
\alias{PleiotropyScore-package}
\alias{PleiotropyScore}
\docType{package}
\title{
\packageTitle{PleiotropyScore}
}
\description{
\packageDescription{PleiotropyScore}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{PleiotropyScore}
\packageIndices{PleiotropyScore}
	The PleiotropyScore package allows to compute the pleiotropy score as described in Jordan et al. The full set of pleiotropy scores computed on the UK Biobank summary statistics is available through the package using the function RunPleiotropyScoreApp().
}
\author{
\packageAuthor{PleiotropyScore}
	Maintainer: \packageMaintainer{PleiotropyScore}
}
\references{
	Daniel Jordan*, Marie Verbanck* and Ron Do. Pervasive pleiotropy driven by extreme polygenicity in the human genome revealed by a novel quantitative analysis of summary association statistics. BioRxiv.
}
\keyword{Horizontal pleiotropy}
\examples{
	################# 1- run the pleiotropy score on a subset of the UK Biobank summary stats #################

	# Load a subset of the UK Biobank summary statistics
    data(UKBiobank_ZscoresSubset)
    # Apply the whitening procedure
    ZscoreMatrixWhitened_UKBB <- GetWhitenedZscores(ZscoreMatrix = ZscoreMatrix_UKBB, ZscoreCorMatrix = ZscoreCorMatrix_UKBB)
    # Get the LD-corrected pleiotropy score
    PleiotropyScores_UKBB <- GetPleiotropyScore(ZscoreWhitenedMatrix = ZscoreMatrixWhitened_UKBB, RSids = SNPinfo_UKBB$SNPid, LDCorrected = TRUE, POLYGENICITYCorrected = FALSE, GlobalTest = TRUE)
    # Results
    GlobalTest_UKBB <- PleiotropyScores_UKBB[[1]]
    PleiotropyScores_UKBB <- PleiotropyScores_UKBB[[2]]

	################# 2- visualize the full set of pleiotropy score results in the UK Biobank #################
	# To run the pleiotropy score results interface
	RunPleiotropyScoreApp()
}
