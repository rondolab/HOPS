require(shiny)
require(shinydashboard)

RunPleiotropyScoreApp <- function() {
	appDir <- system.file("shiny-examples", "PleiotropyScoreApp", package = "PleiotropyScore")
	if (appDir == "") {
		stop("Could not find example directory. Try re-installing the package `PleiotropyScore`.", call. = FALSE)
	}
	shiny::runApp(appDir, display.mode = "normal")
}