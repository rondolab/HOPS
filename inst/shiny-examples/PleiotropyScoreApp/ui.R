library(shiny)
library(shinydashboard)
library(data.table)
# library(shinyjs)

#####################################################################################
# cd ~/Minerva-files/MRmetabolites/Scripts/ ; R 
# library(rsconnect) ; rsconnect::setAccountInfo(name='mverbanck', token='926B5809D9AE28EF7D4C59B79E7FC91D', secret='BOtSoYVaN7CblCZD1Cvmw4SDSeMIQ/vRPuk8VuvZ') ; deployApp("PleiotropyScore", account = 'mverbanck')

shinyUI(dashboardPage(skin = "blue",

    dashboardHeader(
        title = "Pleiotropy Score",
        dropdownMenuOutput("messageMenu")
    ),

####################################################################
############################# Sidebar ##############################
 
	dashboardSidebar(
		sidebarMenu(
			menuItem("About",
				tabName = "About", 
				icon = icon("info")
			),
			menuItem("Pleiotropy Score Results",
				tabName = "PleiotropyScore", 
				icon = icon("area-chart")
			)
		)
	),

################################################################
############################# Body ##############################

	dashboardBody(
		# useShinyjs(),
		tabItems(
			tabItem(tabName = "About",
				h1("The landscape of pervasive horizontal pleiotropy in human genetic variation"),
				br(), br(),
				
				fluidRow(
					box(title = "Description of the pleiotropy score results",
  						"Horizontal pleiotropy, where one variant has independent effects on multiple traits, is important for our understanding of the genetic architecture of human phenotypes. We applied a method to quantify horizontal pleiotropy using genome-wide association summary statistics to 372 heritable phenotypes measured in 361,194 UK Biobank individuals. We observed horizontal pleiotropy is: 1) pervasive throughout the human genome and across a wide range of phenotypes; 2) especially prominent among highly polygenic phenotypes; 3) detected in 24,968 variants in 7,831 loci; and 4) enriched in active regulatory regions. Our results highlight the central role horizontal pleiotropy plays in the genetic architecture of human phenotypes",
							solidHeader = TRUE,
  							status = "primary",
  							width = 12
  					)
  				),
				fluidRow(
  					box(title = "Reference",
	  					uiOutput("JordanEtAl"),
	  					solidHeader = TRUE,
	  					status = "primary",
	  					width = 12
  					)
  				), 
  				fluidRow(
    				column(width = 4, valueBox(372, HTML("UK Biobank Heritable<br>medical phenotypes"), icon = icon("medkit"), width = 12, color = "blue")),
  					column(width = 4, valueBox(format(1183386, big.mark = ","), HTML("Variants scored for<br>horizontal pleiotropy"), color = "light-blue", icon = icon("pie-chart"), width = 12)),
  					column(width = 4, valueBox(format(7831, big.mark = ","), HTML("Significant loci for<br>horizontal pleiotropy"), color = "blue", icon = icon("check"), width = 12))
  				),
  				
  				fluidRow(
					column(
  							infoBox(title = "About",
  							uiOutput("info"),
  							width = 12,
  							icon = icon("info"),
  							fill = FALSE,
  							color = "light-blue"
  						),
  						width = 6
  					 ),
					column(
  							infoBox(title = "Contact information",
  							uiOutput("email"),
  							width = 12,
  							icon = icon("envelope"),
  							fill = FALSE,
  							color = "navy"
  						),
  						width = 6
  					)
				)
			),
#################################################################################################################################
			tabItem(tabName = "PleiotropyScore",
				h1("Pleiotropy Score results"),
				br(), br(),
			
				fluidRow(
					infoBoxOutput("CharacterizationDownload", width = 6),
					infoBox(title = "About", uiOutput("AboutPage"), icon = icon("undo"), width = 6, fill = FALSE, color = "light-blue"),
					infoBox(title = "Pm (LD)", 
						HTML("LD-corrected magnitude-of-effect Pleiotropy Score and its associated Pvalue"),
						fill = TRUE,
						color = "light-blue",
						icon = icon("calculator"),
	  					width = 6),
					infoBox(title = "Pn (LD)", 
						HTML("LD-corrected number-of-traits Pleiotropy Score and its associated Pvalue"),
	  					fill = TRUE,
						color = "light-blue",
						icon = icon("calculator"),
	  					width = 6),
					box(title = "Pleiotropy Score full table",
						dataTableOutput("PleiotropyScoreTable"),
						solidHeader = TRUE,
  						status = "primary",
  						width = 12
  					)
				)
			)
#################################################################################################################################			
		)
	)
))