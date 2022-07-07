setwd("/mnt/woe-D/Documentos/coding-backup/projetos/rscripts/bib-packrat")
packrat::on("/mnt/woe-D/Documentos/coding-backup/projetos/rscripts/bib-packrat")

library(stringr)
library(arrow)
library(sparklyr)
library(dplyr)
library(tidyverse)
library(bibliometrix)
#setwd("~/Documentos/coding/projetos/rscripts/bib-packrat")
#packrat::on("~/Documentos/coding/projetos/rscripts/bib-packrat")

install.packages("bibliometrix")


#============
# Create Spark Session
#============
Sys.setenv(SPARK_HOME = "/opt/spark")

conf <- spark_config()
conf$sparklyr.defaultPackages <- c(
    "com.amazonaws:aws-java-sdk-pom:1.11.828"
)

conf$spark.home <- "/opt/spark"

conf$sparklyr.arrow <- TRUE
conf$sparklyr.apply.packages <- FALSE
conf$sparklyr.gateway.routing <- FALSE
conf$`sparklyr.shell.deploy-mode` <- "client"
conf$spark.kubernetes.file.upload.path <- "file:///tmp"
conf$sparklyr.connect.app.jar <- "local:///usr/local/lib/R/site-library/sparklyr/java/sparklyr-master-2.12.jar"

#sparklyr repo issue
conf$sparklyr.connect.aftersubmit <- function() {
  # wait for pods to launch
  print("[R] Waiting 30 seconds...")
  Sys.sleep(30)
  # port forwarding configuration
  system2(
    "kubectl",
    c("port-forward", "driver-r", "8880:8880", "8881:8881", "4040:4040"),
    wait = FALSE
  )
}

sc <- spark_connect(config = conf, spark_home = "/opt/spark", scala_version = "2.12.11")

# Access executor env variable
#
# Set via spark config:
# "sparkConf": {
#     "spark.executorEnv.SOME_VAR": "01234"
# }

runtime_config <- spark_context_config(sc)
some_var <- runtime_config$spark.executorEnv.SOME_VAR


#install.packages("sparklyr")
#library(sparklyr)
#?spark_config_kubernetes
#batches r-in-spark chapter 7 connections - path pros jars
#system.file("java/", package="sparklyr")



if (!is.null(sc)) {
	# part 1: load data
	# part 2: copy_to creates a spark DataFrame

	writeLines("=========================== Create Spark Data frame ======================")
	# Carrega a biblioteca bibliometrix
	library(bibliometrix)
	library(dplyr)
	load("./computer_TI_clean.Rda")

	# Remove linha duplicada
	M <- M[-c(500),]
	M <- M[-c(1177),]
	M <- M[-c(1177),]
	M <- M[-c(3612),]
	M <- M[-c(3615),]
	M <- M[-c(4611),]

}


# View(M)

# write.csv(M, "./teste.csv", row.names = FALSE)


M_slices <- timeslice(M, breaks = c(2010, 2020))
M2011_2020 <- M_slices[[2]]

N <- termExtraction(M2011_2020, Field = "AB", ngrams = 2,
                                 stemming=TRUE,language="english",
                                 remove.numbers=TRUE, remove.terms=NULL, keep.terms=NULL, verbose=TRUE)

#N <- termExtraction(M, Field = "TI", ngrams = 2,
#                    stemming=TRUE,language="english",
#                    remove.numbers=TRUE, remove.terms=NULL, keep.terms=NULL, verbose=TRUE)


# Passo 1
NetMatrix <- biblioNetwork(N, analysis="co-occurrences", network="abstracts", sep=";")


# Passo 2
# net = networkPlot(NetMatrix, normalize="association", n=30, Title="Test plot", type="fruchterman", size=5, edgesize=5, labelsize=0.7)
net = networkPlot(NetMatrix, normalize="association", n=10, Title="Test plot", type="fruchterman", size=10, edgesize=10, labelsize=0.7)
