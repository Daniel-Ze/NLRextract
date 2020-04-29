#!/usr/bin/Rscript
#install.packages("ggplot2")
library(ggplot2)

# Saving data from bash script to nlrs
nlrs <- commandArgs( )

# Extracting the file path
nlrs_file <- nlrs[6]

# Extracting directory and file name from path
nlrs_file_path <- dirname( nlrs_file )
nlrs_file_name <- basename( nlrs_file )

print( paste0( "Plotting data from ", nlrs_file_name ) )

# Reading the data as table with tab stop as delimiter
nlrs_tbl <- read.table( nlrs_file,
                        header = FALSE,
                        sep = "\t" )

# Sorting the levels of the file
nlr_prot <- nlrs_tbl[grepl(".protein", nlrs_tbl$V2), ]
#print(nlr_prot)
nlr_dom <- nlrs_tbl[!grepl(".protein", nlrs_tbl$V2), ]
#print(nlr_dom)

#Complete NLRs
nlr_cc_nb_lrr <- nlrs_tbl[grepl("NBARC_CC_LRR.protein", nlrs_tbl$V2), ]
nlr_tir_nb_lrr <- nlrs_tbl[grepl("NBARC_TIR_LRR.protein", nlrs_tbl$V2), ]
nlr_cc_rpw8_nb_lrr <- nlrs_tbl[grepl("NBARC_CC_RPW8_LRR.protein", nlrs_tbl$V2), ]
nlr_rpw8_nb_lrr <- nlrs_tbl[grepl("NBARC_RPW8_LRR.protein", nlrs_tbl$V2), ]

nlr_comp <- rbind(nlr_cc_nb_lrr,nlr_tir_nb_lrr,nlr_cc_rpw8_nb_lrr,nlr_rpw8_nb_lrr)

nlr_comp$V2 <- factor ( nlr_comp$V2,
                        levels = c( "NBARC_CC_LRR.protein",
                                    "NBARC_TIR_LRR.protein",
                                    "NBARC_CC_RPW8_LRR.protein",
                                    "NBARC_RPW8_LRR.protein"
                        )
)

#Partial NLRs
nlr_cc_nb <- nlrs_tbl[grepl("^NBARC_CC.protein$", nlrs_tbl$V2), ]
nlr_tir_nb <- nlrs_tbl[grepl("^NBARC_TIR.protein$", nlrs_tbl$V2), ]
nlr_rpw8_nb <- nlrs_tbl[grepl("^NBARC_RPW8.protein$", nlrs_tbl$V2), ]
nlr_nb_lrr <- nlrs_tbl[grepl("^NBARC_LRR.protein$", nlrs_tbl$V2), ]
nlr_cc_lrr <- nlrs_tbl[grep("^CC_LRR.protein$", nlrs_tbl$V2), ]
nlr_tir_lrr <- nlrs_tbl[grepl("^TIR_LRR.protein$", nlrs_tbl$V2), ]
nlr_nb <- nlrs_tbl[grepl("^NBARC.protein$", nlrs_tbl$V2), ]
nlr_cc <- nlrs_tbl[grepl("^CC.protein$", nlrs_tbl$V2), ]
nlr_tir <- nlrs_tbl[grepl("^TIR.protein$", nlrs_tbl$V2), ]
nlr_rpw8 <- nlrs_tbl[grepl("^RPW8.protein$", nlrs_tbl$V2), ]

nlr_part <- rbind(nlr_cc_nb,nlr_tir_nb,nlr_rpw8_nb,nlr_nb_lrr,nlr_cc_lrr,nlr_tir_lrr,nlr_nb,nlr_cc,nlr_tir,nlr_rpw8)

nlr_part$V2 <- factor ( nlr_part$V2,
                        levels = c( "NBARC_CC.protein",
                                    "NBARC_TIR.protein",
                                    "NBARC_RPW8.protein",
                                    "NBARC_LRR.protein",
                                    "CC_LRR.protein",
                                    "TIR_LRR.protein",
                                    "NBARC.protein",
                                    "CC.protein",
                                    "TIR.protein",
                                    "RPW8.protein"
                        )
)

nlr_dom$V2 <- factor( nlr_dom$V2,
                      levels = c( "NB-ARC",
                                  "CC",
                                  "TIR",
                                  "RPW8",
                                  "LRR"
                      )
)

# Generating bar plot of data from NLRextract
pdf(paste0(nlrs_file_path,"/nlr.domain.pdf"))
ggplot( nlr_dom,
        aes( nlr_dom$V2,
             nlr_dom$V1,
             fill = nlr_dom$V2
        )
)+
  geom_bar( stat = "identity" )+
  ylab( "# NLR" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.text.x = element_text( angle = 45,
                                     hjust = 1
         ),
         legend.title = element_blank()
  )+
  ggtitle( "NLR domains" )
dev.off()

# Generating bar plot of data from NLRextract
pdf(paste0(nlrs_file_path,"/nlr.protein.pdf"))
ggplot( nlr_prot,
        aes( nlr_prot$V2,
             nlr_prot$V1,
             fill = nlr_prot$V2
        )
)+
  geom_bar( stat = "identity" )+
  ylab( "# proteins" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.text.x = element_text( angle = 45,
                                     hjust = 1
         ),
         legend.title = element_blank()
  )+
  ggtitle( "NLR proteins" )
dev.off()

pdf(paste0(nlrs_file_path,"/nlr.protein.comp.pdf"))
ggplot( nlr_comp,
        aes( nlr_comp$V2,
             nlr_comp$V1,
             fill = nlr_comp$V2
        )
)+
  geom_bar( stat = "identity" )+
  ylab( "# proteins" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.text.x = element_text( angle = 45,
                                     hjust = 1
         ),
         legend.title = element_blank()
  )+
  ggtitle( "NLR complete proteins" )
dev.off()

pdf(paste0(nlrs_file_path,"/nlr.protein.part.pdf"))
ggplot( nlr_part,
        aes( nlr_part$V2,
             nlr_part$V1,
             fill = nlr_part$V2
        )
)+
  geom_bar( stat = "identity" )+
  ylab( "# proteins" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.text.x = element_text( angle = 45,
                                     hjust = 1
         ),
         legend.title = element_blank()
  )+
  ggtitle( "NLR - partial proteins" )
dev.off()

print( paste0( "Plot saved as pdf with 300 dpi (7 x 5 in) in ", nlrs_file_path, "nlr.domain.pdf and nlr.protein.pdf" ) )
