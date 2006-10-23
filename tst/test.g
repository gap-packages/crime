# This file tests all the functions and methods
# documented in the manual. It only calls each
# function, but does not confirm the accuracy
# of the results. If GAP chokes, the last line
# printed is the problem.

LoadPackage("crime");
G:=DihedralGroup(8);
H:=CyclicGroup(4);
k:=GF(2);
M:=TrivialGModule(G,k);

Print("CohomologyObject, first method, characterisic 2\n");
C:=CohomologyObject(G,M);
Print("CohomologyObject, second method characeristic 2\n");
D:=CohomologyObject(H);

Print("ProjectiveResolution\n");
ProjectiveResolution(C,10);
Print("CohomologyRing, characteristic 2\n");
A:=CohomologyRing(C,10);

b:=Basis(A);
Print("IsHomogeneous\n");
IsHomogeneous(b[1]);
Print("Degree\n");
Degree(b[1]);
Print("CohomologyGenerators\n");
CohomologyGenerators(C,10);
Print("CohomologyRelators\n");
CohomologyRelators(C,10);

f:=GroupHomomorphismByImages(H,G,[H.1],[G.2]);
Print("InducedHomomorphismOnCohomology\n");
F:=InducedHomomorphismOnCohomology(D,C,f,10);
Print("Application of F\n");
A.1^F;

B:=CohomologyRing(CyclicGroup(3),10);
Print("CohomologyRing, characteristic 3\n");
z:=Basis(B)[2];
Print("MasseyProduct, double\n");
MasseyProduct(z,z);
Print("MasseyProduct, triple\n");
MasseyProduct(z,z,z);
