procedure( CGpreDeleteTrigger(dd) 
   let( (ddPath ddName ddType validType)

      ddPath = dd->readPath
      ddName = dd->name
      ddType = dd~>type
      validType = case( ddType
         ('ddLibType t)
         ('ddCellType t)
         ('ddViewType t)
         (t nil))
      if( validType then
         gs = GitShell( ?path ddPath ?dd dd ?name ddName ?skipRoot nil ?silent t)
         gs->libName = dd~>lib~>name
         if( gs->valid then
            LFSunlock(gs gs->path)
         )
      )
   )
   t
)