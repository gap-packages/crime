# For efficiency, we're interested in ordering 
# the elements of G such that the PC exponents 
# are in reverse lexicographical order.

InstallGlobalFunction(ReverseLex,function(G)
  local p,n,l;
  p:=PrimePGroup(G);
  n:=Log(Size(G),p); # ie, |G|=p^n
  l:=List(Tuples([0..p-1],n),Reversed);
  return List(l,x->PcElementByExponents(Pcgs(G),x));
  end
);
