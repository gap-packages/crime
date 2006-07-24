InstallGlobalFunction(PCGens,function(G,K)
  local P,F,M,g,H,m,I,X,Y;
  
  # Generate a minimal generating set M for G.
  P:=Pcgs(G);
  F:=FrattiniSubgroup(G);
  M:=[];
  for g in P do
    H:=Subgroup(G,Concatenation(Elements(F),[g]));
    if Size(H)>Size(F) then
      Append(M,[g]); 
      F:=H;
    fi;
    if Size(F)=Size(G) then break;fi;
  od;
  
  m:=ChangeOfBasisMatrix(G,K);
  I:=IdentityMat(Size(G),K);

  # The following lists give the action of g-1 
  # on kG with respect to the basis of g-1's 
  # for all g in Pcgs(G) in the first list,
  # and for all g in a minimal generating
  # set of G in the second list.

  X:=List(_RegularModule(G,K),x->m*(x-I)*Inverse(m));
  Y:=ListX([1..Size(P)],x->P[x] in M,x->X[x]);
  for g in X do ConvertToMatrixRep(g,K);od;
  for g in Y do ConvertToMatrixRep(g,K);od;
  return [X,Y];
  end
);
