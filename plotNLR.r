#!/usr/bin/Rscript
library(ggplot2)
library(egg)
library(cowplot)

# Saving data from bash script to nlrs
nlrs <- commandArgs( )

# Extracting the file path
nlrs_file <- nlrs[6]
# Extracting directory and file name from path
nlrs_file_path <- dirname( nlrs_file )
nlrs_file_name <- basename( nlrs_file )

print( paste0( "# Plotting data from ", nlrs_file_name ) )

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

#MADA
nlr_cc_mada <- nlrs_tbl[grep("MADA", nlrs_tbl$V2), ] 
print(nlr_cc_mada)

#Partial NLRs
nlr_cc_nb <- nlrs_tbl[grepl("^NBARC_CC.protein$", nlrs_tbl$V2), ]
nlr_tir_nb <- nlrs_tbl[grepl("^NBARC_TIR.protein$", nlrs_tbl$V2), ]
nlr_rpw8_nb <- nlrs_tbl[grepl("^NBARC_RPW8.protein$", nlrs_tbl$V2), ]
nlr_nb_lrr <- nlrs_tbl[grepl("^NBARC_LRR.protein$", nlrs_tbl$V2), ]
nlr_cc_lrr <- nlrs_tbl[grepl("^CC_LRR.protein$", nlrs_tbl$V2), ]
nlr_tir_lrr <- nlrs_tbl[grepl("^TIR_LRR.protein$", nlrs_tbl$V2), ]
nlr_nb <- nlrs_tbl[grepl("^NBARC.protein$", nlrs_tbl$V2), ]
nlr_cc <- nlrs_tbl[grepl("^CC.protein$", nlrs_tbl$V2), ]
nlr_tir <- nlrs_tbl[grepl("^TIR.protein$", nlrs_tbl$V2), ]
nlr_rpw8 <- nlrs_tbl[grepl("^RPW8.protein$", nlrs_tbl$V2), ]

nlr_part <- rbind(nlr_cc_nb,nlr_tir_nb,nlr_rpw8_nb,nlr_nb_lrr,nlr_cc_lrr,nlr_tir_lrr,nlr_nb,nlr_cc,nlr_tir,nlr_rpw8)

nlr_part$V2 <- factor ( nlr_part$V2,
                        levels = c( "NBARC_LRR.protein",
                                    "NBARC_CC.protein",
                                    "NBARC_TIR.protein",
                                    "NBARC_RPW8.protein",
                                    "CC_LRR.protein",
                                    "TIR_LRR.protein",
                                    "NBARC.protein",
                                    "TIR.protein",
                                    "CC.protein",
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
# pdf(paste0(nlrs_file_path,"/nlr.domain.pdf"))
p0<-ggplot( nlr_dom,
        aes( nlr_dom$V2,
             nlr_dom$V1,
             fill = nlr_dom$V2
            )
      )+
  geom_bar( stat = "identity",
            show.legend=FALSE,
            alpha = 0.7,
            color = "black"
          )+
  ylab( "# NLR" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.text.x = element_text( angle = 90,
                                     hjust = 1,
                                     vjust = 0.5,
                                     size = 12
                                    ),
         legend.title = element_blank()
        )+
  ggtitle( "NLR domains" )

# dev.off()

# Generating bar plot of data from NLRextract
# pdf(paste0(nlrs_file_path,"/nlr.protein.pdf"))
p1<-ggplot( nlr_prot,
        aes( x=reorder(V2, -V1),
             y=V1,
             fill = V2
            )
      )+
  geom_bar( stat = "identity",
            show.legend=FALSE,
            alpha = 0.7,
            color = "black"
          )+
  ylab( "# proteins" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.text.x = element_text( angle = 90,
                                     hjust = 1,
                                     vjust = 0.5,
                                     size = 12
                                    ),
         legend.title = element_blank()
        )+
  ggtitle( "All combinations" )

# dev.off()

# pdf(paste0(nlrs_file_path,"/nlr.protein.comp.pdf"))
p3<-ggplot( nlr_comp,
        aes( nlr_comp$V2,
             nlr_comp$V1,
             fill = nlr_comp$V2
        )
      )+
  geom_bar( stat = "identity",
            show.legend=FALSE,
            alpha = 0.7,
            width = 0.7,
            color = "black"
          )+
  geom_text(aes(label = V1), vjust = -0.5, show.legend = FALSE) +
  ylab( "# proteins" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.title.y = element_text(size = 14),
         axis.text.x = element_text( angle = 90,
                                     hjust = 1,
                                     vjust = 0.5,
                                     size = 12
         ),
         legend.title = element_blank()
       )+
  ggtitle( "NLR - complete proteins" )

# dev.off()


# pdf(paste0(nlrs_file_path,"/nlr.protein.part.pdf"))
p4<-ggplot( nlr_part,
        aes( nlr_part$V2,
             nlr_part$V1,
             fill = nlr_part$V2
        )
      )+
  geom_bar( stat = "identity",
            show.legend=FALSE,
            alpha = 0.7,
            color = "black",
            width = 0.8
          )+
  geom_text(aes(label = V1), vjust = -0.5,
            show.legend = FALSE) +
  ylab( "# proteins" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.title.y = element_blank(),
         axis.text.x = element_text( angle = 90,
                                     hjust = 1,
                                     vjust = 0.5,
                                     size = 12
         ),
         legend.title = element_blank()
       )+
  ggtitle( "NLR - partial proteins" )

p6<-ggplot( nlr_cc_mada,
            aes( reorder(nlr_cc_mada$V2, -nlr_cc_mada$V1),
                 nlr_cc_mada$V1,
                 fill = nlr_cc_mada$V2
               )
          )+
  geom_bar( stat = "identity",
            show.legend=FALSE,
            alpha = 0.7,
            color = "black",
            width = 0.8
          )+
  geom_text( aes(label = V1), 
             vjust = -0.5,
             show.legend = FALSE 
           )+
  ylab( "# proteins" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.title.y = element_blank(),
         axis.text.x = element_text( angle = 90,
                                     hjust = 1,                                                                                                 vjust = 0.5,
                                     size = 12),
                     legend.title = element_blank()
       )+
  ggtitle( "NLR - CC with MADA" )


# dev.off()
p5<-plot_grid(p3,p4, nrow = 1, align = "h", rel_widths = c(2.5,4))

ggsave(file = paste0(nlrs_file_path, "/nlr.protein.pdf"),
       width = 5, height = 5, p1)
ggsave(file = paste0(nlrs_file_path, "/nlr.domain.pdf"),
       width = 3, height = 5, p0)
ggsave(file = paste0(nlrs_file_path, "/nlr.protein.comp.pdf"),
       width = 3, height = 7, p3)
ggsave(file = paste0(nlrs_file_path, "/nlr.protein.part.pdf"),
       width = 5, height = 7, p4)
ggsave(file = paste0(nlrs_file_path, "/nlr.protein.comp_part.pdf"),
       width = 8, height = 7, p5)
ggsave(file = paste0(nlrs_file_path, "/nlr.protein.cc_mada.pdf"),
              width = 5, height = 7, p6)
print( paste0( "Done." ) )
