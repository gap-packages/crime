InstallGlobalFunction(FirstStep,function(M,p)
  local I,L,RC;

  # Returns the first step of the projective resolution of M.
  # Not thoroughly tested in the case that M is not
  # the trivial G-module, but works in principle.

  I:=IdentityMat(MTX.Dimension(M),MTX.Field(M));
  L:=List(MTX.Generators(M),x->x-I); 
  if M!.isMTXModule and Size(MTX.BasisRadical(M))>1 then
    RC:=BaseOrthogonalSpaceMat(MTX.BasisRadical(M));
  else 
    RC:=I;
  fi;
  return LiftHom(L,RC,p);
  end
);
