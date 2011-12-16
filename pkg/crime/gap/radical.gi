# Given as a matrix a kG-homomorphism d from kG^n to kG^m
# for some n and m, this function determines which 
# elements of kG^n generate ker(d) as a kG-submodule.

InstallGlobalFunction(GeneratorsOfRadical,function(d,L) 
  # L should be the minimal list of g-1's acting on kG.
  local N,n,NG;
  
  N:=TriangulizedNullspaceMat(d);
  NG:=BaseMat(Concatenation(List(L,x->ActDiagonally(N,x))));
  return BaseSteinitzVectors(N,NG).factorspace;
  end
); 

