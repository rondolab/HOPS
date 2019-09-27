# PleiotropyScore

The PleiotropyScore package allows to compute the pleiotropy score from summary statistics.
The package includes a shiny visualization tool to visualize and download the full set of pleiotropy score results computed using UK Biobank summary statistics

### Reference

Daniel Jordan*, Marie Verbanck* and Ron Do. Pervasive horizontal pleiotropy in human genetic variation is driven by extreme polygenicity of human traits and diseases. BioRxiv.

<https://www.biorxiv.org/content/10.1101/311332v3>

### 1. Install and load PleiotropyScore
To install the latest development builds directly from GitHub, run this instead:
```r
if (!require("devtools")) { install.packages("devtools") } else {}
devtools::install_github("rondolab/PleiotropyScore")
```
Load PleiotropyScore 
```r
library(PleiotropyScore)
```

### 2. Example: run the pleiotropy score on a subset of the UK Biobank summary stats
```r
# Load a subset of the UK Biobank summary statistics
data(UKBiobank_ZscoresSubset)
# Apply the whitening procedure
ZscoreMatrixWhitened_UKBB <- GetWhitenedZscores(ZscoreMatrix = ZscoreMatrix_UKBB, ZscoreCorMatrix = ZscoreCorMatrix_UKBB)
# Get the LD-corrected pleiotropy score
PleiotropyScores_UKBB <- GetPleiotropyScore(ZscoreWhitenedMatrix = ZscoreMatrixWhitened_UKBB, RSids = SNPinfo_UKBB$SNPid, LDCorrected = TRUE, POLYGENICITYCorrected = FALSE, GlobalTest = TRUE)
# Results
GlobalTest_UKBB <- PleiotropyScores_UKBB[[1]]
PleiotropyScores_UKBB <- PleiotropyScores_UKBB[[2]]
```
### 3. Visualize and download the full set of pleiotropy score results in the UK Biobank
```r
# To run the pleiotropy score results interface
RunPleiotropyScoreApp()
```
The full set of results is also directly downloadable here:

https://github.com/rondolab/PleiotropyScore/blob/master/inst/shiny-examples/PleiotropyScoreApp/www/ScoresUKbbSAIGE_AllSNPs_LDTheo.txt.tar.gz

The Zscore correlation matrix for the 372 UK Biobank phenotypes is directly downloadable here:
https://github.com/rondolab/PleiotropyScore/blob/master/inst/shiny-examples/PleiotropyScoreApp/www/UkBiobank_Zscore_CorrelationMat.xlsx
