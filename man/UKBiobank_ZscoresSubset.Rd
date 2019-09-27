\name{UKBiobank_ZscoresSubset}
\alias{UKBiobank_ZscoresSubset}
\docType{data}
\title{
	Subset of the UK Biobank summary stats.
}
\description{
	Contains 3 elements 'SNPinfo_UKBB', 'ZscoreMatrix_UKBB' and 'ZscoreCorMatrix_UKBB' to compute the HOPS (HOrizontal Pleiotropy Score) on a subset of 10,000 from the UK Biobank summary stats.

	SNP information for the subset of UK Biobank summary stats (10,000 SNPs).
}
\usage{data("UKBiobank_ZscoresSubset")}
\format{
	\describe{
		\item{\code{SNPinfo_UKBB}}{data.frame with 10,000 SNPs in rows and information in columns (RS ids, chromosome, position)}
		\item{\code{ZscoreMatrix_UKBB}}{data.frame of Z-scores with 10,000 SNPs in row and 372 UK Biobank phenotypes in columns.}
        \item{\code{ZscoreCorMatrix_UKBB}}{data.frame of pairwise correlations between Z-scores of the 372 UK Biobank phenotypes.}
	}
}

\references{
    Daniel Jordan*, Marie Verbanck* and Ron Do. Pervasive pleiotropy driven by extreme polygenicity in the human genome revealed by a novel quantitative analysis of summary association statistics. BioRxiv.
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
