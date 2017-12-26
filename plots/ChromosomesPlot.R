#!/usr/bin/env Rscript
# @Date    : 2017-12-26 10:56:32
# @Author  : JTGuo
# @Email   : guojt-4451@163.com

library("karyoploteR")

kp <- plotKaryotype(chromosomes=c("autosomal"))

kp <- plotKaryotype(chromosomes=c("chr1"))
# kpDataBackground(kp)
# kpAxis(kp)
kpPoints(kp, chr="chr1", x=34915394, y=0, pch=6) ## triangle
kpRect(kp, chr="chr1", x0=100000000, x1=120000000, y0=0.2, y1=0.4)


kpPoints(kp, chr = data.points$chr, x=data.points$pos, y=data.points$value, col=rainbow(240))