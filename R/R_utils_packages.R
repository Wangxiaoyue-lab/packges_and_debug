# CRAN and bioconductor
pkgs <- c(
  "Seurat", "assertthat", "scater", "scran", "tidyverse", "readxl", "magrittr",
  "Signac", "devtools", "DropletUtils", "EdgeR", "limma", "chromVAR",
  "clustree", "rlang", "monocle", "DESeq2", "GSVA", "org.Mm.eg.db",
  "org.Hs.eg.db", "clusterProfiler", "scCustomize", "scMAGeCK",
  "WGCNA", "GENIE3", "AUCell", "RcisTarget", "glmnetUtils", "Matrix.utils",
  "tximport", "RobustRankAggreg", "randomForest", "enrichplot", "e1071", "VennDiagram",
  "survival", "survivalROC", "factoextra", "FactoMineR", "survminer", "survMisc",
  "UpSetR", "ConsensusClusterPlus", "JASPAR2020", "Nebulosa", "caret",
  "circlize", "table1", "formattable", "webshot", "infercnv", "TxDb.Hsapiens.UCSC.hg19.knownGene",
  "dbscan", "AnnoProbe", "parallelDist", "ggpval", "biomaRt", "GSA",
  "sf", "sp", "rgal", "leidenbase", "magick", "BiocSingular", "forcats", "reactR",
  "bit64", "GenomeInfoDb"
)

# devtools::install_local(package_name,force = T,quiet = F)
# check_pkgs(pkgs)

# from https://github.com/compbioNJU/scPlant/blob/master/R/load_shinyApp.R
#' check_pkgs
#'
#' A function to check whether the required packages are installed or not.
#'
#' @param pkgs A vector of the required packages.
#'
#' @return No explicit return, but users can check the installation status of the pkgs.
#'
#' @examples
#' check_pkgs(c("packageA", "packageB"))
check_pkgs <- function(pkgs = pkgs) {
  options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
  unavail <- c()
  for (pkg in pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      unavail <- c(unavail, pkg)
    }
  }
  if (length(unavail) > 0) {
    message(
      "These packages are required but not installed: \n",
      paste(strwrap(paste(unavail, collapse = ", ")), collapse = "\n")
    )
    for (pkg in unavail) {
      tryCatch(install.packages(pkg),
        error = function(e) {
          message(
            "Installation from CRAN failed: \n", e$message,
            "\nTry to install ", pkg, " from Bioconductor"
          )
          if (!requireNamespace("BiocManager", quietly = TRUE)) {
            install.packages("BiocManager")
          }
          BiocManager::install(pkg)
        }
      )
    }
  }
}




# github
github_list <- c(
  "samuel-marsh/scCustomize",
  "mojaveazure/seurat-disk",
  "chris-mcginnis-ucsf/DoubletFinder",
  "Sun-lab/ideas",
  "aertslab/SCopeLoomR",
  "aertslab/SCENIC",
  "immunogenomics/harmony",
  "kostkalab/scds",
  # "satijalab/seurat","seurat5"
  # "satijalab/seurat-data","seurat5"
  # "stuart-lab/signac","seurat5"
  # "satijalab/seurat-wrappers","seurat5"
  "mojaveazure/seurat-disk",
  "bnprks/BPCells",
  "TheHumphreysLab/plot1cell",
  "icbi-lab/immunedeconv",
  # "Moonerss/CIBERSORT",
  "xuranw/MuSiC",
  "renozao/xbioc",
  "Jiaxin-Fan/MuSiC2",
  # "amitfrish/scBio"
  "bmbroom/tsvio",
  "broadinstitute/inferCNV_NGCHM",
  "JEFworks/HoneyBADGER",
  "akdess/CaSpER",
  "navinlabcode/copykat",
  "stemangiola/tidyHeatmap",
  "coolbutuseless/ggreverse",
  "KrishnaswamyLab/phateR",
  "theislab/kBET",
  "drieslab/Giotto",
  "ludvigla/semla",
  "drighelli/SpatialExperiment"
)

check_github <- function(github_list) {
  lapply(github_list, function(g) {
    pk <- g %>%
      str_split(., pattern = "/", simplify = T) %>%
      .[, 2]
    if (!requireNamespace("devtools", quietly = TRUE)) {
      install.packages("devtools")
    }
    if (!requireNamespace(pk, quietly = TRUE)) {
      devtools::install_github(g)
    }
  })
}


# 其他
install.packages("estimate", repos = "http://r-forge.r-project.org", dependencies = TRUE)

webshot::install_phantomjs()

devtools::install_github("bmbroom/NGCHMR", ref = "stable")
