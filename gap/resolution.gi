DeclareRepresentation("IsCObjectCompRep",
  IsComponentObjectRep, ["G","K","M","e","d","L","R","B","H","P","V"]);
CObject:=NewType(NewFamily("Cohomology Object"),
  IsCObject and IsCObjectCompRep);

# The components of a CObject are the following.

# G the group
# K the field
# M the KG-module M in Ext(M,N)
# e the augmentation P_0 -> K
# d the boundary maps P_i -> P_{i-1}
#   -- these could arguably be thrown away
# L the full and minimal lists of matrices
#   giving the action of G on KG
# R the boundary maps in "non-lifted" form
# B the Betti numbers, that is, the dimensions
#   of the groups Ext^i(K,K)=H^i(G)
# H the chain maps corresponding with the cohomology
#   generators -- these could arguably be thrown away
# P for internal usage in calculating generators
# V the variables used in the cohomology ring

InstallMethod(CohomologyObject,
  "Creates a cohomology object",[IsGroup,IsField,IsObject],
  function(G,K,M)
    return Objectify(CObject,
      Immutable(rec(G:=G,K:=K,M:=M)));
  end
);

InstallOtherMethod(CohomologyObject,
  "Creates a cohomology object",[IsGroup],
  function(G)
    local K;
    K:=GF(PrimePGroup(G));
    return CohomologyObject(G,K,
      GModuleByMats(List(Pcgs(G),x->[[One(K)]]),K)
    );
  end
);

# Called as ProjectiveResolution(C,n), the following function computes
# P_n -> P_{n-1} -> ... -> P_1 -> P_0 -> M -> 0.

InstallMethod(ProjectiveResolution,"Computes a minimal projective resolution",
  [IsCObject,IsPosInt], 
  function(C,n)
    local d;
    if not IsBound(C!.e) then C!.e:=FirstStep(C!.M);fi;
    if not IsBound(C!.B) then C!.B:=[];fi;
    if not IsBound(C!.B[1]) then C!.B[1]:=Size(C!.e)/Size(C!.G);fi;
    if not IsBound(C!.L) then C!.L:=PCGens(C!.G,C!.K);fi;
    if not IsBound(C!.R) then C!.R:=[];fi;
    if not IsBound(C!.d) then C!.d:=[];fi;
    if not IsBound(C!.R[1]) then
      C!.R[1]:=GeneratorsOfRadical(C!.e,C!.L[2]);
      C!.d[1]:=LiftHom(C!.L[1],C!.R[1],C!.K);
      C!.B[2]:=Size(C!.R[1]);
    fi;
    for d in [Size(C!.R)+1..n] do
      C!.R[d]:=GeneratorsOfRadical(C!.d[d-1],C!.L[2]);
      C!.d[d]:=LiftHom(C!.L[1],C!.R[d],C!.K);
      C!.B[d+1]:=Size(C!.R[d]);
    od;
    return C!.B;
  end
);
