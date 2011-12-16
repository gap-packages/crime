InstallGlobalFunction(ReverseLexBasis,function(G)
local p,n,l;

  # For efficiency, we're interested in ordering 
  # the elements of G such that the PC exponents 
  # are in reverse lexicographical order.

  p:=PrimePGroup(G);
  n:=Log(Size(G),p); # ie, |G|=p^n
  l:=List(Tuples([0..p-1],n),Reversed);
  return List(l,x->PcElementByExponents(Pcgs(G),x));
  end
);

InstallGlobalFunction(GMinusOneBasis,function(G,K)
  local A,i,e,P,Q,p,l,OldB,NewB,m;

  # Defines the following bases of KG:
  # OldB is the list of the elements g of G embedded in kG.
  # NewB is the list of the elements g-1 of kG in the same order.
    
  # The matrix returned is the change-of-basis matrix m
  # going from NewB to OldB, that is,
  # right multiplication by m of a row vector
  # with respect to NewB returns a row vector
  # with respect to OldB.

  A:=GroupRing(K,G);
  i:=One(A);
  e:=Embedding(G,A);
  P:=Pcgs(G);
  Q:=List(P,x->x^e-i);
  p:=PrimePGroup(G);
  l:=List(Tuples([0..p-1],Size(P)),Reversed);
  OldB:=Basis(A,List(l,x->PcElementByExponents(P,x)^e));
  NewB:=List(l,x->Product([1..Size(P)],y->Q[y]^x[y]));
  m:=List(NewB,x->Coefficients(OldB,x));
  ConvertToMatrixRep(m,K);
  return m;
  end
);

InstallGlobalFunction(ActionOfPCGenerators,function( G, K )
  local gens, mats, elms, d, zero, i, mat, j, o;

  # This is a modified version of the library 
  # function RegularModule by Bettina Eick.
  # Returns a list of matrices giving the actions
  # of g on kG for all g in Pcgs(G) with respect
  # to the basis ReverseLexBasis(G) of KG.

  # And just so everyone is clear, no one being
  # more confused about this than me, RIGHT 
  # multiplication by one of these matrices 
  # corresponds with RIGHT multiplication 
  # by the corresponding group element.
    
  gens := Pcgs(G);
  mats := List( gens, x -> false );
  elms := ReverseLexBasis(G);
  d    := Length(elms);
  zero := NullMat( d, d, K );
  for i in [1..Length( gens )] do
    mat := List( zero, ShallowCopy ); 
    for j in [1..d] do
      o := Position( elms, elms[j]*gens[i] );
      mat[j][o] := One( K );
    od;
    ConvertToMatrixRep(mat,K);
    mats[i] := mat;
  od;
  return  mats;
  end
);

InstallGlobalFunction(PCGens,function(G,K)
  local P,M,m,I,X,g,Y;
  
  P:=Pcgs(G);
  M:=SmallGeneratingSet(G);
  m:=GMinusOneBasis(G,K);
  I:=IdentityMat(Size(G),K);

  # The following lists give the action of g-1 
  # on kG with respect to the basis of g-1's 
  # for all g in Pcgs(G) in the first list,
  # and for all g in a minimal generating
  # set of G in the second list.

  X:=List(ActionOfPCGenerators(G,K),x->m*(x-I)*Inverse(m));
  for g in X do ConvertToMatrixRep(g,K);od;
  Y:=ListX([1..Size(P)],x->P[x] in M,x->X[x]);
  return [X,Y];
  end
);
