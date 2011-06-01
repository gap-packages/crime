# Any kG-homomorphism f from kG^r to another kG-module
# is determined by the images
# f(1,0,...,0), f(0,1,...,0), f(0,0,...,1)
# and the action of kG on the target.
# Given all this information, this function
# extends ("lifts") f to a homomorphism.

InstallGlobalFunction(LiftHom,function(L,R,p)
  # L is a list of the actions of the g-1's 
  # on the target for all g in Pcgs(G).
  # R is the list of images of the map constructed. 
  # p is the PrimePGroup of G
  
  local n,l,m,t,j,k,first,last,jg;
  n:=Size(R[1])/Size(L[1]); # Number of block columns in target
  l:=Size(L);               # Size of Pcgs(G); ie, |G|=p^l
  m:=[];

  for t in [1..Size(R)] do
    Append(m,[R[t]]);
    for j in [1..l] do
      for k in [1..p-1] do
        first:=(t-1)*p^l+(k-1)*p^(j-1)+1;
        last:= (t-1)*p^l+ k   *p^(j-1)  ;
        Append(m,ActDiagonally(m{[first..last]},L[j]));
      od;
    od;
  od;
  ConvertToMatrixRep(m,p);
  return m;
  end
);
