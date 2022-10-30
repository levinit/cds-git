

procedure(CGcopyTrigger(myFunction copyPhaseStr checkOffList supplementList otherFromSpecs
          otherToSpecs updateList retHint ctxList reserved "stgggggggx")
   let( (toLibName libState pathList nextSpec filePath pathList)

     libState=nil
     toLibName = car(gdmInspectSpec(gdmNextFromSpecList(otherToSpecs)))
     if(toLibName && toLibName != "" then
        gs = CGMlmgrCB_gs(toLibName nil nil ?skipRoot t)
        libState = gs->valid
        printf("Library %s is Git library=%L\n" toLibName libState)
     )
     
     when( libState
       gdmResetSpecList( otherToSpecs )
       pathList = nil
       while( nextSpec = gdmNextFromSpecList( otherToSpecs ) 
             filePath = gdmInspectSpec( nextSpec "CDBA" )
             filePath = list(car(filePath) cadr(filePath) caddr(filePath))
             unless( member(nil filePath) pathList = cons(filePath pathList))
            )
       pathList = removeListDuplicates(pathList)

       foreach( path pathList
          gs = CGMlmgrCB_gs(car(path) cadr(path) caddr(path) ?skipRoot t)
          printf("CdsGit CGpostCopyTrigger: Locking %s %s %s\n" car(path) cadr(path) caddr(path))
          LFSlock(gs gs->path ?checkOut nil)  ; Do not try to checkout the latest version of a copied file
       )
    )
  )
)