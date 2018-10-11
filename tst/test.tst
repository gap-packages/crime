gap> G:=DihedralGroup(8);
<pc group of size 8 with 3 generators>
gap> H:=CyclicGroup(4);
<pc group of size 4 with 2 generators>
gap> k:=GF(2);
GF(2)
gap> M:=TrivialGModule(G,k);;
gap> Display(M);
rec(
  IsOverFiniteField := true,
  dimension := 1,
  field := GF(2),
  generators := [ [ [ Z(2)^0 ] ], [ [ Z(2)^0 ] ], [ [ Z(2)^0 ] ] ],
  isMTXModule := true )
gap> C:=CohomologyObject(G,M);
<object>
gap> D:=CohomologyObject(H);
<object>
gap> ProjectiveResolution(C,10);
[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
gap> A:=CohomologyRing(C,10);
<algebra of dimension 66 over GF(2)>
gap> b:=Basis(A);
CanonicalBasis( <algebra of dimension 66 over GF(2)> )
gap> IsHomogeneous(b[1]);
true
gap> Degree(b[1]);
0
gap> CohomologyGenerators(C,10);
[ 1, 1, 2 ]
gap> CohomologyRelators(C,10);
[ [ z, y, x ], [ z*y+y^2 ] ]
gap> f:=GroupHomomorphismByImages(H,G,[H.1],[G.2]);
[ f1 ] -> [ f2 ]
gap> F:=InducedHomomorphismOnCohomology(D,C,f,10);;
gap> A.1^F;
v.1
gap> B:=CohomologyRing(CyclicGroup(3),10);
<algebra of dimension 11 over GF(3)>
gap> z:=Basis(B)[2];
v.2
gap> MasseyProduct(z,z);
0*v.1
gap> MasseyProduct(z,z,z);
v.3
