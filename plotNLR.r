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
  ylab( "# NLR" )+
  theme_bw()+
  theme( axis.title.x = element_blank(),
         axis.text.x = element_text( angle = 45,
                                     hjust = 1
                                    ),
         legend.title = element_blank()
        )+
  ggtitle( "NLR proteins" )
dev.off()

print( paste0( "Plot saved as pdf with 300 dpi (7 x 5 in) in ", nlrs_file_path, "nlr.domain.pdf and nlr.protein.pdf" ) )
