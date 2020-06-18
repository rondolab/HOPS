library(shiny)
library(shinydashboard)
library(data.table)
# library(shinyjs)

############################################################################################################
# showReactLog()

shinyServer(function(input, output, session){

	# addClass(selector = "body", class = "sidebar-collapse")

############################################################################################################
	output$JordanEtAl <- renderUI({
		tagList(a(
			"Daniel Jordan*, Marie Verbanck* and Ron Do. HOPS: a quantitative score reveals pervasive horizontal pleiotropy in human genetic variation is driven by extreme polygenicity of human traits and diseases. Genome Biology 20, 222 (2019).", 
			href = "https://doi.org/10.1186/s13059-019-1844-7",
			target = "_blank"
		))
	})
	output$email <- renderUI({
		tagList(a(
			h5("ron.do [at] mssm.edu"), 
			href = "mailto:ron.do@mssm.edu")
		)
	})
	output$info <- renderUI({
		tagList(a(
			h5("Further information on the Do Lab"),
			href = "http://labs.icahn.mssm.edu/dolab/",
			target = "_blank")
		)
	})

	output$AboutPage <- renderUI({
		tagList(
			a("Back to the about tab", onclick = "openTab('About')"),
			tags$script(HTML("
				var openTab = function(tabName){
		  			$('a', $('.sidebar')).each(function() {
						if(this.getAttribute('data-value') == tabName) {
							this.click()
						};
					});
				}
			")
		))
	})

############################################################################################################

	getPleiotropyScoreTable <- reactive({
		PleiotropyScoreTable <- fread("gunzip -c www/ScoresUKbbSAIGE_AllSNPs_LDTheo.txt.tar.gz", data.table = FALSE)
		PleiotropyScoreTable
	})

	output$downloadData <- downloadHandler(
		filename = function() {
		  paste0("PleiotropyScore", ".csv")
		},
		content = function(file) {
			withProgress(message = "Preparing to download the table", detail = "This may take a few minutes ...", value = 1, {
				write.csv(getPleiotropyScoreTable(), file, row.names = FALSE)
			})
		}
	)
						
	output$CharacterizationDownload <- renderInfoBox({
		infoBox(paste("Download the complete Pleiotropy Score result table"), 
			downloadButton("downloadData", "Download"),
			icon = icon("download"), fill = TRUE, color = "aqua")
	})

############################################################################################################

	output$PleiotropyScoreTable <- renderDataTable({
		getPleiotropyScoreTable()
	})

	# Download filtered data
	# https://stackoverflow.com/questions/48493829/download-filtered-data-from-renderdatatable-in-shiny
})