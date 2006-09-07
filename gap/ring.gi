InstallMethod(CohomologyRing,[IsCObject,IsPosInt], 
  function(C,n)
    local L,R;
    ProjectiveResolution(C,n);
    if not IsBound(C!.A) or Dimension(C!.A)<Sum(C!.B{[1..n+1]}) then
      MakeMultiplicationTable(C,n);
      C!.A:=AlgebraByStructureConstants(C!.K,C!.T);
      L:=GeneratorsOfAlgebra(C!.A);
      R:=rec(
        source:=Integers,
        hom_components:=function(m)
          local r,s;
          if m<0 or m>n then 
            return Subspace(C!.A,[Zero(C!.A)]);fi;
          r:=Sum([1..m],  x->C!.B[x]);
          s:=Sum([1..m+1],x->C!.B[x]);
         return Subspace(C!.A,L{[r+1..s]});end,
        min_degree:=0,
        max_degree:=Size(C!.B)-1
      );
      C!.A!.AssociatedCohomologyObject:=C;
      SetGrading(C!.A,R);
    fi;
  return C!.A;
  end
);

InstallOtherMethod(CohomologyRing,
  [IsGroup,IsPosInt],
  function(G,n)
    local C;
    if not IsFinite(G) or not IsPGroup(G)
      then TryNextMethod();
    fi;
    C:=CohomologyObject(G);
    CohomologyRing(C,n);
    return C!.A;
  end
);
