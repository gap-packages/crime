InstallGlobalFunction(ChangeOfBasisMatrix,function(G,K)
local A,i,e,P,Q,p,n,l,OldB,NewB,m;

  A:=GroupRing(K,G);
  i:=One(A);
  e:=Embedding(G,A);
  P:=Pcgs(G);
  Q:=List(P,x->x^e-i);
  p:=PrimePGroup(G);
  n:=Log(Size(G),p);
  l:=List(Tuples([0..p-1],n),Reversed);
  OldB:=Basis(A,List(l,x->PcElementByExponents(P,x)^e));
  NewB:=List(l,x->Product([1..Size(P)],y->Q[y]^x[y]));

  # OldB is the list of the elements g of G embedded in kG.
  # NewB is the list of the elements g-1 of kG in the same order.

  m:=List(NewB,x->Coefficients(OldB,x));
  ConvertToMatrixRep(m,K);
  return m;
  end
);
  
# The matrix returned is the change-of-basis matrix m
# going from NewB to OldB, that is,
# right multiplication by m of a row vector
# with respect to NewB returns a row vector
# with respect to OldB.
