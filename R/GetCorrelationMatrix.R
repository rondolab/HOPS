GetCorrelationMatrix <- function(ZscoreMatrix){

	# Functions
	fastCor <- function(mat){
		mat <- t(mat)
		mat <- mat - rowMeans(mat)
		mat <- mat / sqrt(rowSums(mat^2))
		cr <- tcrossprod(mat)
		return(cr)
	}

	# Correlation between the Zscores
	ZscoreCorMatrix <- fastCor(ZscoreMatrix)
	return(ZscoreCorMatrix)
}