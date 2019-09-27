require(data.table)

GetHOPS <- function(ZscoreWhitenedMatrix, RSids, LDCorrected = FALSE, POLYGENICITYCorrected = FALSE, NBSim = 25, GlobalTest = FALSE){

	# Compute the score
	Z0star2 <- 2
	Pn <- rowSums(abs(ZscoreWhitenedMatrix) > Z0star2, na.rm = TRUE)
	Pm <- sqrt(rowSums(ZscoreWhitenedMatrix^2))

	# Load LD scores
	if(LDCorrected){
		cat("using LD scores from https://data.broadinstitute.org/alkesgroup/LDSCORE/1000G_Phase3_baseline_v1.1_ldscores.tgz\n")
		data(LDscores)
		warning("Matching LD scores on RSids, please make sure the SNPs are in build 38.\n")
		LDscores <- LDscores[match(RSids, LDscores$SNP), ]

		warning(paste0(100 * sum(is.na(LDscores$baseL2)) / nrow(LDscores), "% of the SNPs will not be scored because of lacking LD scores.\n"))
		getLDCorrectedScore <- function(Pn, Pm, LDscores = LDscores){
			modPn <- lm(Pn ~ LDscores$baseL2)
			PnLD <- Pn - LDscores$baseL2 * modPn$coefficients[2]
			PnLD <- replace(PnLD, PnLD < 0, 0)
			modPm <- lm(Pm ~ LDscores$baseL2)
			PmLD <- Pm - LDscores$baseL2 * modPm$coefficients[2]
			PmLD <- replace(PmLD, PmLD < 0, 0)
			return(list(Pn = PnLD, Pm = PmLD))
		}
		lnormLD <- getLDCorrectedScore(Pn = Pn, Pm = Pm, LDscores = LDscores)
		Pn <- lnormLD$Pn
		Pm <- lnormLD$Pm
	}

	# Compute the pvalues
	if(POLYGENICITYCorrected){
		getEmpirical <- function(ZscoreWhitenedMatrix, LD = LD){
			ZscoreWhitenedMatrixRandom <- apply(ZscoreWhitenedMatrix, 2, sample)
			lnormRandom <- cbind.data.frame(Pn = rowSums(abs(ZscoreWhitenedMatrixRandom) > Z0star2, na.rm = TRUE), Pm = sqrt(rowSums(ZscoreWhitenedMatrixRandom^2)))
			if(LDCorrected)
				lnormRandom <- getLDCorrectedScore(Pn = lnormRandom$Pn, Pm = lnormRandom$Pm, LDscores = LDscores)
			return(lnormRandom)
		}

		set.seed(123)
		EmpP <- replicate(NBSim, getEmpirical(ZscoreWhitenedMatrix, LD = LDCorrected))
		lnormRandom <- list(Pn = unlist(EmpP[1, ]), Pm = unlist(EmpP[2, ]))
		Pn_percentiles <- rank(sort(lnormRandom$Pn) - 0.5)/length(lnormRandom$Pn)
		Pm_percentiles <- rank(sort(lnormRandom$Pm) - 0.5)/length(lnormRandom$Pm)
		Pn_Pvalue <- 1 - Pn_percentiles[pmax(findInterval(Pn, sort(lnormRandom$Pn)),1)]
		Pm_Pvalue <- 1 - Pm_percentiles[pmax(findInterval(Pm, sort(lnormRandom$Pm)),1)]

		Pn_Pvalue <- replace(Pn_Pvalue, Pn_Pvalue == 0, 0.99/(length(lnormRandom$Pn) * NBSim))
		Pm_Pvalue <- replace(Pm_Pvalue, Pm_Pvalue == 0, 0.99/(length(lnormRandom$Pm) * NBSim))

		if(GlobalTest){
			GT0 <- sapply(c("two.sided", "less", "greater"), function(alternative) wilcox.test(x = Pn, y = lnormRandom$Pn, exact = FALSE, alternative = alternative)$p.value)
			GT2 <- sapply(c("two.sided", "less", "greater"), function(alternative) wilcox.test(x = Pm^2, y = lnormRandom$Pm^2, exact = FALSE, alternative = alternative)$p.value)
		}

		# Empirical scores
		Pn <- qbinom(p = Pn_Pvalue, size = ncol(ZscoreWhitenedMatrix), prob = 0.045, lower.tail = FALSE, log.p = FALSE)
		Pm <- sqrt(qchisq(p = Pm_Pvalue, df = ncol(ZscoreWhitenedMatrix), lower.tail = FALSE, log.p = FALSE))

	} else {
		# Theoretical Pvalues
		Pn_Pvalue <- pbinom(q = Pn, size = ncol(ZscoreWhitenedMatrix), prob = 0.045, lower.tail = FALSE, log.p = FALSE)
		Pm_Pvalue <- pchisq(q = Pm^2, df = ncol(ZscoreWhitenedMatrix), lower.tail = FALSE, log.p = FALSE)

		if(GlobalTest){
			GT0 <- sapply(c("two.sided", "less", "greater"), function(alternative) wilcox.test(x = Pn, y = qbinom(p = seq(0, 1, length.out = length(Pn)), size = ncol(ZscoreWhitenedMatrix), prob = 0.045, lower.tail = FALSE, log.p = FALSE), exact = FALSE, alternative = alternative)$p.value)
			GT2 <- sapply(c("two.sided", "less", "greater"), function(alternative) wilcox.test(x = Pm^2, y = qchisq(p = seq(0, 1, length.out = length(Pn)), df = ncol(ZscoreWhitenedMatrix), lower.tail = FALSE, log.p = FALSE), exact = FALSE, alternative = alternative)$p.value)
		}
	}
	# Compile the results
	Scores <- cbind.data.frame(
		RSids = RSids,
		Pn = 100 * Pn / ncol(ZscoreWhitenedMatrix),
		Pn_Pvalue = Pn_Pvalue,
		Pm = 100 * Pm / ncol(ZscoreWhitenedMatrix),
		Pm_Pvalue = Pm_Pvalue, 
		`LD-corrected` = LDCorrected,
		`Polygenicity-corrected` = POLYGENICITYCorrected
	)
	if(GlobalTest){
		return(list(cbind.data.frame(GlobalTest_Pn = GT0, GlobalTest_Pm = GT2), Scores))
	} else {
		return(Scores)
	}
}

##########################################################################################
###################################### Get LD scores #####################################
##########################################################################################

# require(data.table)
# if(! file.exists("data/LDscores")){
# 	cat("Creating temporary directory LDscores/ to store LD scores\n")
# 	dir.create("data/LDscores/")
# 	cat("Downloading LDscores to directory LDscores/\n")
# 	system("cd data/LDscores/ ; wget --no-check-certificate https://data.broadinstitute.org/alkesgroup/LDSCORE/1000G_Phase3_baseline_v1.1_ldscores.tgz")
# 	system("cd data/LDscores ; tar -zxvf 1000G_Phase3_baseline_v1.1_ldscores.tgz")
# 	system("cd data/LDscores ; rm 1000G_Phase3_baseline_v1.1_ldscores.tgz ; mv baseline_v1.1/*ldscore.gz . ; rm -r baseline_v1.1")
# }
# LDscores <- lapply(1:22, function(chr){
# 	tmp <- fread(paste0("gunzip -c data/LDscores/baseline.", chr, ".l2.ldscore.gz"), data.table = FALSE, select = 1:4)
# 	return(tmp)
# })
# LDscores <- do.call("rbind", LDscores)
# save(LDscores, file = "data/LDscores.rda")
# system("rm -r data/LDscores")

##########################################################################################
