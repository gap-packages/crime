# All the functions in this file are intended to 
# improve the readability of the rest of the program.

InstallGlobalFunction(ExtractColumn,function(M,n)
# Returns the transpose of column n of M.
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

InstallGlobalFunction(DiagonalAction,function(M,n)
# Returns a block diagonal matrix having M
# on the diagonal n times.
  return KroneckerProduct(
    IdentityMat(n,M[1][1]),M);
  end
);

InstallGlobalFunction(LiftChainMap,function(C,L,d,n)
  # Lifts the chain map L of degree d several times.
  # There will be a total of n lifts afterwords,
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
