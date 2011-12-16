# This function calls CohomologyGenerators and
# locates the generators in the cohomology ring.
InstallGlobalFunction(LocateGeneratorsInCohomologyRing,function(C)
  local b,n,L,i,v;
  if not IsBound(C!.A) then Error("Call CohomologyRing() first\n");fi;
  b:=Basis(C!.A);
  n:=Grading(C!.A).max_degree;
  CohomologyGenerators(C,n);
  L:=[];
  for i in [1..Size(C!.D)] do
    v:=ExtractColumn(C!.H[i][1],1);
    Append(L,[Position(v,One(C!.K))+Sum(C!.B{[1..C!.D[i]]})]);
  od;
  return List(L,x->b[x]);
  end
);

