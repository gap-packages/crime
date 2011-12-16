# Given a map f:G->H, this function produces 
# the induced map H(H)->H(G) to degree n.

InstallGlobalFunction(InducedHomomorphismOnCohomology,function(C,D,f,n)
  local B,L,M,g,F,c,G,i,j,k,I,J;
  
  if not C!.K=D!.K then Error("Fields not the same\n");fi;
  if not Source(f)=C!.G then Error("Source(f) not the right group\n");fi;
  if not Range(f)=D!.G then Error("Range(f) not the right group\n");fi;
  
  CohomologyRing(C,n);
  CohomologyRing(D,n);
  B:=Basis(C!.A);
  L:=ReverseLex(C!.G);
  M:=ReverseLex(D!.G);
  g:=NullMat(Size(C!.G),Size(D!.G),C!.K);
  for i in [1..Size(L)] do g[i][Position(M,L[i]^f)]:=One(C!.K);od;
  ConvertToMatrixRep(g,C!.K);
  
  # Lift g to a chain map.
  F:=[g];
  for j in [1..n-1] do
    c:=C!.d[j]*F[j];
    F[j+1]:=List(c,x->SolutionMat(D!.d[j],x));
  od;
  
  # Remove all rows and columns except the first of every block
  G:=[];
  for i in [1..n] do
  G[i]:=List([1..C!.B[i]],
     j->List([1..D!.B[i]],
     k->F[i][(j-1)*Size(C!.G)+1]
            [(k-1)*Size(D!.G)+1]
     ));
  od;
  
  # Bookeeping. Produce the list J of 
  # images of the map we're constructing.
  I:=[];
  for j in [1..n] do
    for k in [1..D!.B[j]] do
      Append(I,
        [Concatenation(
          ListWithIdenticalEntries(Sum(C!.B{[1..j-1]}),Zero(C!.K)),
          ExtractColumn(G[j],k),
          ListWithIdenticalEntries(Sum(C!.B{[j+1..n+1]}),Zero(C!.K))
        )]
      );
    od;
  od;
  for j in [1..D!.B[n+1]] do
    Append(I,[ListWithIdenticalEntries(Sum(C!.B),Zero(C!.K))]);
  od;
  J:=List(I,x->LinearCombination(B,x));
  
  return AlgebraHomomorphismByImages(D!.A,C!.A,Basis(D!.A),J);
  end
);
