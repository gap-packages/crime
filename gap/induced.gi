# Given a map f:H->G, this function produces 
# the induced map H*(G)->H*(H) to degree n.

InstallGlobalFunction(InducedHomomorphismOnCohomology,
  function(C,D,f,n)
  local B,P,Q,M,L,F,c,i,j,k,I,J;
  
  if not C!.K=D!.K then 
    Error("Fields not the same\n");fi;
  if not Source(f)=C!.G then 
    Error("Source(f) not the correct group\n");fi;
  if not Range(f)=D!.G then 
    Error("Range(f) not the correct group\n");fi;
  if not C!.p=D!.p then
    Error("Primes not the same\n");fi;

  CohomologyRing(C,n);
  CohomologyRing(D,n);
  B:=Basis(C!.A);

  # kG is a kH module via f. The list L below
  # gives the action of H on kG.
  P:=Pcgs(C!.G);
  Q:=Pcgs(D!.G);
  M:=IdentityMat(Size(D!.G),D!.K);
  L:=List(P,x->
    LinearCombinationPcgs(
      D!.L[1]+M,
      ExponentsOfPcElement(Q,x^f),
      IdentityMat(Size(D!.G),C!.K)
    )-M
  );
  
  # Lift 1:K->K to a chain map.
  F:=[[ListWithIdenticalEntries(Size(D!.G),Zero(C!.K))]];
  F[1][1][1]:=One(C!.K);
  for j in [1..n] do
    c:=C!.R[j]*LiftHom(L,F[j],C!.p);
    F[j+1]:=List(c,x->SolutionMat(D!.d[j],x));
  od;
  
  # Bookeeping. Produce the list J of 
  # images of the map we're constructing.
  I:=[];
  for j in [1..n+1] do
    for k in [1..D!.B[j]] do
      Append(I,
        [Concatenation(
          ListWithIdenticalEntries(Sum(C!.B{[1..j-1]}),Zero(C!.K)),
          ExtractColumn(F[j],(k-1)*Size(D!.G)+1),
          ListWithIdenticalEntries(Sum(C!.B{[j+1..n+1]}),Zero(C!.K))
        )]
      );
    od;
  od;

  J:=List(I,x->LinearCombination(B,x));
  
  return AlgebraHomomorphismByImages(D!.A,C!.A,Basis(D!.A),J);
  end
);
