# HOPS (HOrizontal Pleiotropy Score)

The HOPS package allows to compute the horizontal pleiotropy score (HOrizontal Pleiotropy Score) from summary statistics.
The package includes a shiny visualization tool to visualize and download the full set of HOPS results computed using UK Biobank summary statistics

### Reference

Daniel Jordan*, Marie Verbanck* and Ron Do. Pervasive pleiotropy driven by extreme polygenicity in the human genome revealed by a novel quantitative analysis of summary association statistics. BioRxiv.

<https://www.biorxiv.org/content/10.1101/311332v2>

### 1. Install and load PleiotropyScore
To install the latest development builds directly from GitHub, run this instead:
```r
if (!require("devtools")) { install.packages("devtools") } else {}
devtools::install_github("rondolab/HOPS")
```
Load HOPS 
```r
library(HOPS)
```

### 2. Example: run the HOPS on a subset of the UK Biobank summary stats
```r
# Load a subset of the UK Biobank summary statistics
data(UKBiobank_ZscoresSubset)
# Apply the whitening procedure
ZscoreMatrixWhitened_UKBB <- GetWhitenedZscores(ZscoreMatrix = ZscoreMatrix_UKBB, ZscoreCorMatrix = ZscoreCorMatrix_UKBB)
# Get the LD-corrected HOPS
HOPS_UKBB <- GetHOPS(ZscoreWhitenedMatrix = ZscoreMatrixWhitened_UKBB, RSids = SNPinfo_UKBB$SNPid, LDCorrected = TRUE, POLYGENICITYCorrected = FALSE, GlobalTest = TRUE)
# Results
GlobalTest_UKBB <- HOPS_UKBB[[1]]
HOPS_UKBB <- HOPS_UKBB[[2]]
```
### 3. Visualize and download the full set of HOPS results in the UK Biobank
```r
# To run the HOPS results interface
RunHOPSApp()
```
The full set of results is also directly downloadable here:

https://github.com/rondolab/HOPS/blob/master/inst/shiny-examples/HOPSApp/www/ScoresUKbbSAIGE_AllSNPs_LDTheo.txt.tar.gz

The Zscore correlation matrix for the 372 UK Biobank phenotypes is directly downloadable here:
https://github.com/rondolab/HOPS/blob/master/inst/shiny-examples/HOPSApp/www/UkBiobank_Zscore_CorrelationMat.xlsx
