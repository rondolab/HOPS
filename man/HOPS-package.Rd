\name{HOPS-package}
\alias{HOPS-package}
\alias{HOPS}
\docType{package}
\title{
\packageTitle{HOPS}
}
\description{
\packageDescription{HOrizontal Pleiotropy Score (HOPS)}
}
\details{

The DESCRIPTION file:
\packageDescription{HOrizontal Pleiotropy Score (HOPS)}
\packageIndices{HOPS}
	The HOPS package allows to compute the HOPS (HOrizontal Pleiotropy Score) as described in Jordan et al. The full set of HOPS computed on the UK Biobank summary statistics is available through the package using the function RunHOPSApp().
}
\author{
\packageAuthor{HOPS}
	Maintainer: \packageMaintainer{HOPS}
}
\references{
	Daniel Jordan*, Marie Verbanck* and Ron Do. HOPS: a quantitative score reveals pervasive horizontal pleiotropy in human genetic variation is driven by extreme polygenicity of human traits and diseases. Genome Biology 20, 222 (2019).
}
\keyword{Horizontal pleiotropy}
\examples{
	################# 1- run the HOPS on a subset of the UK Biobank summary stats #################

	# Load a subset of the UK Biobank summary statistics
    data(UKBiobank_ZscoresSubset)
    # Apply the whitening procedure
    ZscoreMatrixWhitened_UKBB <- GetWhitenedZscores(ZscoreMatrix = ZscoreMatrix_UKBB, ZscoreCorMatrix = ZscoreCorMatrix_UKBB)
    # Get the LD-corrected HOPS
    HOPS_UKBB <- GetHOPS(ZscoreWhitenedMatrix = ZscoreMatrixWhitened_UKBB, RSids = SNPinfo_UKBB$SNPid, LDCorrected = TRUE, POLYGENICITYCorrected = FALSE, GlobalTest = TRUE)
    # Results
    GlobalTest_UKBB <- HOPS_UKBB[[1]]
    HOPS_UKBB <- HOPS_UKBB[[2]]

	################# 2- visualize the full set of HOPS results in the UK Biobank #################
	# To run the HOPS results interface
	RunHOPSApp()
}
