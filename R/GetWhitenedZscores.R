GetWhitenedZscores <- function(ZscoreMatrix, ZscoreCorMatrix = NULL){

	# Verifications
	if(nrow(ZscoreMatrix) < ncol(ZscoreMatrix))
		stop("ZscoreMatrix is a data.frame with SNPs in rows and traits in columns")

	if( ! is.null(ZscoreCorMatrix))
		if(ncol(ZscoreMatrix) != nrow(ZscoreCorMatrix))
			stop("The number of traits is different between ZscoreMatrix and ZscoreCorMatrix, please make the data.frames contain only Z-scores and correlation coefficients respectively. No column with RSID should be included.")

	# Functions
	"%^%" <- function(x, n) with(svd(x), u %*% (d^n * t(v)))

	# Correlation between the Zscores
	if(is.null(ZscoreCorMatrix)) {
		warning("The correlation between the Z-scores is computed using all the SNPs. If a set of independant SNPs would be preferably used, please precompute the correlation matrix using GetCorrelationMatrix()")
		ZscoreCorMatrix <- GetCorrelationMatrix(ZscoreMatrix)
	}

	# Reporting pairs with high correlations
	RefCor <- do.call("rbind", lapply(1:ncol(ZscoreCorMatrix), function(i) cbind.data.frame(row = 1:(i-1), col = i, ref = (sum((1:(i-1)) - 1)  + 1) : sum(0:(i-1)))))
	CorrelatedPairs <- which(abs(ZscoreCorMatrix[upper.tri(ZscoreCorMatrix, diag = FALSE)]) > 0.8)
	if(length(CorrelatedPairs) > 0){
		CorrelatedPairs <- cbind.data.frame(Trait1 = row.names(ZscoreCorMatrix)[RefCor$row[match(CorrelatedPairs, RefCor$ref)]], 
			Trait2 = row.names(ZscoreCorMatrix)[RefCor$col[match(CorrelatedPairs, RefCor$ref)]],
			CorLevel = ZscoreCorMatrix[upper.tri(ZscoreCorMatrix, diag = FALSE)][CorrelatedPairs]
		)
		warning("Some traits have pairwise correlation above the required cut-off of 0.8, please select one trait out of the pair (e.g. highest heritability). NB: the set of pairs is returned instead of the whitened Z-scores.")
		return(CorrelatedPairs)

	} else {
		# Pleiotropy score
		Zstar <- ZscoreCorMatrix %^%(-1/2) %*% t(ZscoreMatrix)
		Zstar <- data.frame(t(Zstar))
		colnames(Zstar) <- colnames(ZscoreMatrix)
		row.names(Zstar) <- row.names(ZscoreMatrix)
		return(Zstar)
	}
}