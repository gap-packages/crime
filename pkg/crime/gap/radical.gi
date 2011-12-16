# Given as a matrix a kG-homomorphism d from kG^n to kG^m
# for some n and m, this function determines which 
# elements of kG^n generate ker(d) as a kG-submodule.

InstallGlobalFunction(GeneratorsOfRadical,function(d,L) 
  # L should be the minimal list of g-1's acting on kG.
  local N,n,NG;
  
  N:=TriangulizedNullspaceMat(d);
  n:=Size(N[1])/Size(L[1]); # n is the number of block columns, 
  NG:=BaseMat(Concatenation(List(L,x->N*DiagonalAction(x,n))));
  return BaseSteinitzVectors(N,NG).factorspace;
  end
);  
