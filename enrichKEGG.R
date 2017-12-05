#!/usr/bin/env Rscript
# -*- coding: utf-8 -*-
# @Date    : 2016-12-22 20:24:14
# @Author  : Jintao Guo
# @Email   : guojt-4451@163.com
# @Version : 1.0

DOC = "KEGG analysis"

library("optparse")

option_list = list(
  make_option(c("-i", "--input"), type="character", default=NULL,
              help="input genes names", metavar="file",dest="gene"),
  make_option(c("-b", "--background"), type="character", default=NULL,
              help="background genes", metavar="file", dest="background"),
  make_option(c("-o", "--out"), type="character", default=NULL,
              help="output KEGG result", metavar="file", dest="output")
)

opt_parser = OptionParser(usage = "usage: %prog [options]", option_list = option_list, add_help_option = TRUE, prog = NULL, description = "", epilogue = "")

opt = parse_args(opt_parser, print_help_and_exit=TRUE)

if (length(opt)==1){
  print_help(opt_parser)
  q()
}


library(clusterProfiler)
library(org.Hs.eg.db)


genes = read.table(opt$gene, stringsAsFactors=F)

eg = bitr(genes$V1, fromType="SYMBOL", toType="ENTREZID", OrgDb="org.Hs.eg.db")

if(!is.null(opt$background)){
    background = read.table(opt$background, stringsAsFactors=F)
    bg = bitr(background$V1, fromType="SYMBOL", toType="ENTREZID", OrgDb="org.Hs.eg.db")
    kk = enrichKEGG(eg$ENTREZID, organism = "hsa", universe=bg$ENTREZID)
}else{
    kk = enrichKEGG(eg$ENTREZID, organism = "hsa")
}

if(!is.null(kk)){
    if(nrow(kk@result)>0){
        write.table(kk@result, opt$output, sep="\t", quote=F, col.names=T,
            row.names=F)
        }else{
            stop("No gene set")
        }
}else{
    stop("Error")
}


