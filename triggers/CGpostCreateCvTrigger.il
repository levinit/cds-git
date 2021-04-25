procedure( CGpostCreateCvTrigger(parentId objPath objType dd) 
   let( (ddPath ddName)

      ddPath = dd~>readPath
      ddName = dd~>name
;      printf("ParentId: %L\nObj Path: %s\nObj Type: %s\nArg4: %L\n" parentId objPath objType dd~>name)
;      when( isLockableCV(gs dd)
      when( objType == "ddViewType"
         gs = GitShell( ?path ddPath ?dd dd ?name ddName ?skipRoot nil ?silent t)
         gs->libName = dd~>lib~>name
         gs->cellName = dd~>cell~>name
         gs~>viewName = dd~>name
         when( gs->valid
            printf("CdsGit CGpostCreateCVtrigger(): Locking view for edit\n")
            LFSlock(gs gs->path)
         )
      )
   )
   t
)