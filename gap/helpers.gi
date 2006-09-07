# All the functions in this file are intended to 
# improve the readability of the rest of the program.

InstallGlobalFunction(ExtractColumn,function(M,n)
# Returns column n of M as a list.
  return List(M,x->x[n]);
  end
);

InstallGlobalFunction(FirstLift,function(C,v) 
# Returns a list containing a |v|x|G| matrix 
# having the transpose of v in the first column.
  local N,j;
  N:=NullMat(Size(v),Size(C!.G),C!.K);
  for j in [1..Size(v)] do N[j][1]:=v[j];od;
  return [N];
  end
);

InstallGlobalFunction(DownTheMiddle,function(M,d)
# Returns a block diagonal matrix having M
# on the diagonal d times.
  local m,n,N,i,j,k;
  m:=Size(M);
  n:=Size(M[1]);
  N:=NullMat(m*d,n*d,M[1][1]);
  for k in [1..d] do
    for i in [1..m] do for j in [1..n] do
      N[m*(k-1)+i][n*(k-1)+j]:=M[i][j];
    od;od;
  od;
  return N;
  end
);

InstallGlobalFunction(LiftChainMap,function(C,L,d,n)
  # Lifts the chain map L of degree d several times.
  # There will be a total of n lifts afterwards,
  # not including the first map P_d -> P_0 in position 1.
  # Thus, the last map in position n+1 will be P_{n+d} -> P_n.
  local j,c;
  ProjectiveResolution(C,d+n);
  for j in [Size(L)..n] do
    c:=C!.R[d+j]*LiftHom(C!.L[1],L[j],C!.K);
    Append(L,[List(c,x->SolutionMat(C!.d[j],x))]);
  od;
  end
);

InstallGlobalFunction(LiftChainMapMassey,function(C,L,d,n)
  # Same as the previous function, but with a sign change.
  # Read the documentation for an explanation of the (-1)^n.
  local j,c;
  ProjectiveResolution(C,d+n);
  for j in [Size(L)..n] do
    c:=C!.R[d+j]*LiftHom(C!.L[1],L[j],C!.K);
    Append(L,[List((-1)^d*c,x->SolutionMat(C!.d[j],x))]);
  od;
  end
);

InstallMethod(Inclusion,"Inclusion of a subgroup",
  [IsGroup,IsGroup], function(H,G)
    return GroupHomomorphismByImages(H,G,
      GeneratorsOfGroup(H),GeneratorsOfGroup(H));
  end
);
