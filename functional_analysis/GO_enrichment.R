#!/mnt/shared/scratch/jnprice/apps/conda/bin/R

library(optparse)
library(topGO)
library(ggplot2) 
library(scales)

opt_list = list(
  make_option("--genes_of_interest", type="character", help="list of gene names in txt file"),
  make_option("--GO_annotations", type="character", help="output from GO_table.py"),
  make_option("--out_dir", type="character", help="output directory for the analysis")
  )

opt = parse_args(OptionParser(option_list=opt_list))
f1 = opt$genes_of_interest
f2 = opt$GO_annotations
o = opt$out_dir

# ---
# Load in data
# ----
genesOfInterest <- read.table(f1, header=FALSE)
genesOfInterest <- as.character(genesOfInterest$V1)

geneID2GO <- readMappings(file = f2) 
geneUniverse <- names(geneID2GO)

geneList <- factor(as.integer(geneUniverse %in% genesOfInterest))
names(geneList) <- geneUniverse

# ---
# Test enrichment of Molecular Function ontologies
# ----
MFdata <- new("topGOdata", description = "MF data", ontology = "MF", allGenes = geneList, annot = annFUN.gene2GO, gene2GO = geneID2GO)
MFdata

MFresultFisher <- runTest(MFdata, algorithm="weight01", statistic="fisher")
MFresultFisher

MFallGO = usedGO(object = MFdata)

MFallRes <- GenTable(MFdata, classicFisher = MFresultFisher, orderBy = "MFresultFisher", ranksOf = "classicFisher", topNodes = length(MFallGO), numChar=1000)
table_out <- paste(o, "/", "TopGO_MF.tsv", sep="")
write.table(MFallRes, file = table_out, sep = "\t")

showSigOfNodes(MFdata, score(MFresultFisher), firstSigNodes = 10, useInfo ='all')
graph_out <- paste(o, "/", "TopGO_MF", sep="")
printGraph(MFdata, MFresultFisher, firstSigNodes = 10, fn.prefix = graph_out, useInfo = "all", pdfSW = TRUE)
length(usedGO(MFdata))

MFallRes$classicFisher <- as.numeric(MFallRes$classicFisher)
MFsigRes <- MFallRes[MFallRes$classicFisher < 0.05, ]

MFsigRes$Significant <- as.numeric(MFsigRes$Significant)
MFsigRes$Annotated <- as.numeric(MFsigRes$Annotated)
MFsigRes$classicFisher <- as.numeric(MFsigRes$classicFisher)
MFsigRes$geneRatio <- (MFsigRes$Significant / MFsigRes$Annotated)

MFdotplot <- 
  ggplot(MFsigRes, aes(x = geneRatio, y = reorder(Term, geneRatio), size = Significant, color = classicFisher)) +
  geom_point() +
  scale_size_continuous(name = "Count") +
  scale_color_continuous(name = "p-value") +
  scale_y_discrete(labels = label_wrap(50)) +
  labs(title = "Molecular Function", x = "Gene Ratio", y = "") +
  theme_minimal() +
  scale_x_continuous(limits = c(-0.05, 1.05))

plot_out <- paste(o, "/", "TopGO_MF_dotplot.jpg", sep="")
ggsave(plot_out, plot = MFdotplot, width = 10, height = 18, dpi = 300, bg = "white")


# ---
# Test enrichment of Biological Process ontologies
# ----
BPdata <- new("topGOdata", description = "BP data", ontology = "BP", allGenes = geneList, annot = annFUN.gene2GO, gene2GO = geneID2GO)
BPdata

BPresultFisher <- runTest(BPdata, algorithm="weight01", statistic="fisher")
BPresultFisher

BPallGO = usedGO(object = BPdata)

BPallRes <- GenTable(BPdata, classicFisher = BPresultFisher, orderBy = "BPresultFisher", ranksOf = "classicFisher", topNodes = length(BPallGO), numChar=1000)
table_out <- paste(o, "/", "TopGO_BP.tsv", sep="")
write.table(BPallRes, file = table_out, sep = "\t")

showSigOfNodes(BPdata, score(BPresultFisher), firstSigNodes = 10, useInfo ='all')
graph_out <- paste(o, "/", "TopGO_BP", sep="")
printGraph(BPdata, BPresultFisher, firstSigNodes = 10, fn.prefix = graph_out, useInfo = "all", pdfSW = TRUE)
length(usedGO(BPdata))

BPallRes$classicFisher <- as.numeric(BPallRes$classicFisher)
BPsigRes <- BPallRes[BPallRes$classicFisher < 0.05, ]

BPsigRes$Significant <- as.numeric(BPsigRes$Significant)
BPsigRes$Annotated <- as.numeric(BPsigRes$Annotated)
BPsigRes$classicFisher <- as.numeric(BPsigRes$classicFisher)
BPsigRes$geneRatio <- (BPsigRes$Significant / BPsigRes$Annotated)

BPdotplot <- 
  ggplot(BPsigRes, aes(x = geneRatio, y = reorder(Term, geneRatio), size = Significant, color = classicFisher)) +
  geom_point() +
  scale_size_continuous(name = "Count") +
  scale_color_continuous(name = "p-value") +
  scale_y_discrete(labels = label_wrap(50)) +
  labs(title = "Biological Process", x = "Gene Ratio", y = "") +
  theme_minimal() +
  scale_x_continuous(limits = c(-0.05, 1.05))

plot_out <- paste(o, "/", "TopGO_BP_dotplot.jpg", sep="")
ggsave(plot_out, plot = BPdotplot, width = 10, height = 18, dpi = 300, bg = "white")

# ---
# Test enrichment of Cellular Component ontologies
# ----
CCdata <- new("topGOdata", description = "CC data", ontology = "CC", allGenes = geneList, annot = annFUN.gene2GO, gene2GO = geneID2GO)
CCdata

CCresultFisher <- runTest(CCdata, algorithm="weight01", statistic="fisher")
CCresultFisher

CCallGO = usedGO(object = CCdata)

CCallRes <- GenTable(CCdata, classicFisher = CCresultFisher, orderBy = "CCresultFisher", ranksOf = "classicFisher", topNodes = length(CCallGO), numChar=1000)
table_out <- paste(o, "/", "TopGO_CC.tsv", sep="")
write.table(CCallRes, file = table_out, sep = "\t")

showSigOfNodes(CCdata, score(CCresultFisher), firstSigNodes = 10, useInfo ='all')
graph_out <- paste(o, "/", "TopGO_CC", sep="")
printGraph(CCdata, CCresultFisher, firstSigNodes = 10, fn.prefix = graph_out, useInfo = "all", pdfSW = TRUE)
length(usedGO(CCdata))

CCallRes$classicFisher <- as.numeric(CCallRes$classicFisher)
CCsigRes <- CCallRes[CCallRes$classicFisher < 0.05, ]

CCsigRes$Significant <- as.numeric(CCsigRes$Significant)
CCsigRes$Annotated <- as.numeric(CCsigRes$Annotated)
CCsigRes$classicFisher <- as.numeric(CCsigRes$classicFisher)
CCsigRes$geneRatio <- (CCsigRes$Significant / CCsigRes$Annotated)

CCdotplot <- 
  ggplot(CCsigRes, aes(x = geneRatio, y = reorder(Term, geneRatio), size = Significant, color = classicFisher)) +
  geom_point() +
  scale_size_continuous(name = "Count") +
  scale_color_continuous(name = "p-value") +
  scale_y_discrete(labels = label_wrap(50)) +
  labs(title = "Cellular Component", x = "Gene Ratio", y = "") +
  theme_minimal() +
  scale_x_continuous(limits = c(-0.05, 1.05))

plot_out <- paste(o, "/", "TopGO_CC_dotplot.jpg", sep="")
ggsave(plot_out, plot = CCdotplot, width = 10, height = 18, dpi = 300, bg = "white")