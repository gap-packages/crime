InstallGlobalFunction(FirstStep,function(M)
  local I,L,RC;
  I:=IdentityMat(MTX.Dimension(M),MTX.Field(M));
  L:=List(MTX.Generators(M),x->x-I); 
  if MTX.IsMTXModule(M) and Size(MTX.BasisRadical(M))>1 then
    RC:=BaseOrthogonalSpaceMat(MTX.BasisRadical(M));
  else 
    RC:=I;
  fi;
  return LiftHom(L,RC,MTX.Field(M));
  end
);

# Returns the first step of the projective resolution of M.
# Not thoroughly tested in the case that M is not
# the trivial G-module, but works in principle.
