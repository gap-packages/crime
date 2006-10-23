n:=16;
# This file calculates cohomology rings for all groups
# of size n, and prints timings.

LoadPackage("crime");
s:=0;
f:=Concatenation(String(n),"-group_cohomology.txt");
for j in [1..NumberSmallGroups(n)] do
  AppendTo(f,"SmallGroup(",n,",",j,")\n");
  G:=SmallGroup(n,j);
  C:=CohomologyObject(G);

  B:=ProjectiveResolution(C,10);
  t:=Runtime();
  AppendTo(f,"Betti Numbers: ",B,"\nTime: ",StringTime(t-s),"\n");
  s:=t;

  D:=CohomologyGenerators(C,10);
  t:=Runtime();
  AppendTo(f,"Generators in degrees: ",D,"\nTime: ",StringTime(t-s),"\n");
  s:=t;

  R:=CohomologyRelators(C,10);
  t:=Runtime();
  AppendTo(f,"Relators: ",R,"\nTime: ",StringTime(t-s),"\n\n");
  s:=t;
od;
AppendTo(f,"Total time: ",StringTime(t),"\n");
