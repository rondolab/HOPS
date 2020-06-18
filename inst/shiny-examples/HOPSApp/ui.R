library(shiny)
library(shinydashboard)
library(data.table)

#####################################################################################

shinyUI(dashboardPage(skin = "blue",

    dashboardHeader(
        title = "HOPS",
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
			menuItem("HOPS Results",
				tabName = "HOPS", 
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
					box(title = "Horizontal pleiotropy, where one variant has independent effects on multiple traits, is important for our understanding of the genetic architecture of human phenotypes. We develop a method to quantify horizontal pleiotropy using genome-wide association summary statistics and apply it to 372 heritable phenotypes measured in 361,194 UK Biobank individuals. Horizontal pleiotropy is pervasive throughout the human genome, prominent among highly polygenic phenotypes, and enriched in active regulatory regions. Our results highlight the central role horizontal pleiotropy plays in the genetic architecture of human phenotypes.",
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
			tabItem(tabName = "HOPS",
				h1("HOPS (HOrizontal Pleiotropy Score) results"),
				br(), br(),
			
				fluidRow(
					infoBoxOutput("CharacterizationDownload", width = 6),
					infoBox(title = "About", uiOutput("AboutPage"), icon = icon("undo"), width = 6, fill = FALSE, color = "light-blue"),
					infoBox(title = "Pm (LD)", 
						HTML("LD-corrected magnitude-of-effect HOPS and its associated Pvalue"),
						fill = TRUE,
						color = "light-blue",
						icon = icon("calculator"),
	  					width = 6),
					infoBox(title = "Pn (LD)", 
						HTML("LD-corrected number-of-traits HOPS and its associated Pvalue"),
	  					fill = TRUE,
						color = "light-blue",
						icon = icon("calculator"),
	  					width = 6),
					box(title = "HOPS full table",
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