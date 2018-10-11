DeclareRepresentation("IsCObjectCompRep",
  IsComponentObjectRep, ["G","K","M","e","d","L","R","B","H","P"]);
CObject:=NewType(NewFamily("Cohomology Object"),
  IsCObject and IsCObjectCompRep);

# The components of a CObject are the following.

# G the group
# p the PrimePGroup of G
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

InstallMethod(CohomologyObject,
  "Creates a cohomology object",[IsGroup,IsRecord],
  function(G,M)
    local K,p;
    if not MTX.IsMTXModule(M) then
      Error("M should be a MeatAxe module\n");fi;
    if not IsFinite(G) or not IsPGroup(G) or IsTrivial(G) then
      Error("G should be a finte, nontrivial p-group\n");fi;
    if IsEmpty(MTX.Generators(M)) then
      Error("M should be a module over some nontrivial group\n");fi;
    K:=MTX.Field(M);
    p:=PrimePGroup(G);
    if not p=Characteristic(K) then
      Error("PrimePGroup(G) should equal Characteristic(K)\n");fi;
    return Objectify(CObject, rec(G:=G,p:=p,K:=K,M:=M));
  end
);

InstallOtherMethod(CohomologyObject,
  "Creates a cohomology object",[IsGroup],
  function(G)
    local p,K;
    if not IsFinite(G) or not IsPGroup(G) or IsTrivial(G) then
      Error("G should be a finte, nontrivial p-group\n");fi;
    p:=PrimePGroup(G);
    K:=GF(p);
    return CohomologyObject(G,
      GModuleByMats(List(Pcgs(G),x->[[One(K)]]),K)
    );
    # Have to call GModuleByMats because TrivialGModule 
    # uses GeneratorsOfGroup instead of Pcgs.
  end
);

# Called as ProjectiveResolution(C,n), the following function computes
# P_n -> P_{n-1} -> ... -> P_1 -> P_0 -> M -> 0.

InstallMethod(ProjectiveResolution,"Computes a minimal projective resolution",
  [IsCObject,IsPosInt], 
  function(C,n)
    local p,d;
    if not IsBound(C!.e) then C!.e:=FirstStep(C!.M,C!.p);fi;
    if not IsBound(C!.B) then C!.B:=[];fi;
    if not IsBound(C!.B[1]) then C!.B[1]:=Size(C!.e)/Size(C!.G);fi;
    if not IsBound(C!.L) then C!.L:=PCGens(C!.G,C!.K);fi;
    if not IsBound(C!.R) then C!.R:=[];fi;
    if not IsBound(C!.d) then C!.d:=[];fi;
    if not IsBound(C!.R[1]) then
     C!.R[1]:=GeneratorsOfRadical(C!.e,C!.L[2]);
     C!.d[1]:=LiftHom(C!.L[1],C!.R[1],C!.p);
     C!.B[2]:=Size(C!.R[1]);
   fi;

   for d in [Size(C!.R)+1..n] do
     C!.R[d]:=GeneratorsOfRadical(C!.d[d-1],C!.L[2]);
     C!.d[d]:=LiftHom(C!.L[1],C!.R[d],C!.p);
     C!.B[d+1]:=Size(C!.R[d]);
   od;
    return C!.B;
  end
);

InstallMethod(BoundaryMap,"Returns a boundary map",
  [IsCObject,IsInt],
  function(C,n)
    if n<0 then Error("n should be nonnegative\n");
    elif n=0 then ProjectiveResolution(C,1); return C!.e;
    else ProjectiveResolution(C,n); return C!.R[n];
    fi;
  end
);
