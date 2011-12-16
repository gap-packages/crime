# This file tests all the functions and methods
# documented in the manual. It only calls each
# function, but does not confirm the accuracy
# of the results.

LoadPackage("crime");
G:=DihedralGroup(8);
H:=CyclicGroup(4);
k:=GF(2);
M:=TrivialGModule(G,k);

C:=CohomologyObject(G,k,M);
D:=CohomologyObject(H);

ProjectiveResolution(C,10);
CohomologyRing(C,10);
A:=CohomologyRing(C,10);

b:=Basis(A);
IsHomogeneous(b[1]);
Degree(b[1]);
CohomologyGenerators(C,10);
CohomologyRelators(C,10);

f:=GroupHomomorphismByImages(H,G,[H.1],[G.2]);
F:=InducedHomomorphismOnCohomology(D,C,f,10);
A.1^F;

B:=CohomologyRing(CyclicGroup(3),10);
z:=Basis(B)[2];
MasseyProduct(z,z);
MasseyProduct(z,z,z);

