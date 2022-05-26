workflow FAVORannotator{ 
  
    call FunctionalAnnotation {

    }

}

task FunctionalAnnotation{
    File InputaGDS       = "gs://fc-c8284810-fa31-4e6d-baa2-6aef5a5ef3e1/FAVOR.T2210k.gds"  
    runtime{
      docker: "zilinli/staarpipeline:0.9.6"
    }
    
    command <<< 
      R --no-save --args ~{~{InputaGDS}} <<RSCRIPT
        library(gdsfmt)
        library(SeqArray)
        args <- commandArgs(trailingOnly = TRUE)
        gds.ot.fn<-args[1]
        genofile<-seqOpen(gds.ot.fn, readonly = FALSE)
        print("GDS built")
        genofile
        seqClose(genofile)
      RSCRIPT
      echo "Finished step2: in wdl r scripts"
    >>>	      
}

