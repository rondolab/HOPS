require(shiny)
require(shinydashboard)

RunHOPSApp <- function() {
	appDir <- system.file("shiny-examples", "HOPSApp", package = "HOPS")
	if (appDir == "") {
		stop("Could not find example directory. Try re-installing the package `HOPS`.", call. = FALSE)
	}
	shiny::runApp(appDir, display.mode = "normal")
}