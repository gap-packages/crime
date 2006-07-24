# This function computes the SC-table for 
# the cohomology ring. Unlike other functions, 
# this one is not idempotent because of the way
# the SC-table is set up.
InstallGlobalFunction(MakeMultiplicationTable,function(C,n)
local G,K,R,L,B,N,T,h,d,c,i,j,k,l,BB,s,t,u,v,w,x; 
G:=C!.G; K:=C!.K; 
R:=C!.R; L:=C!.L; B:=C!.B;

# Set up the SC table.
N:=Sum(B{[1..n+1]});   # Size of the table
C!.T:=EmptySCTable(N,Zero(K));
T:=C!.T;

# Set up the identity element of of the table.
for i in [1..N] do
  T[1][i]:=[[i],[One(K)]];
  T[i][1]:=[[i],[One(K)]];
od;

# Create all cochains. 
C!.h:=[]; h:=C!.h; 
for j in [1..n] do
    h[j]:=List(IdentityMat(B[j+1],K),x->FirstLift(C,x));
od;

# Lift maps and record products.
for i in [1..n-1] do
  for j in [1..Minimum(i,n-i)] do
    BB:=Basis(FullRowSpace(K,B[i+j+1]));
    for k in [1..B[i+1]] do
      LiftChainMap(C,h[i][k],i,j);
      for l in [1..B[j+1]] do
        v:=ExtractColumn(h[i][k][j+1],(l-1)*Size(G)+1);
        # s and t are the positions of the elements
        # we're multiplying.
        s:=Sum(B{[1..i]})+k;
        t:=Sum(B{[1..j]})+l;
        # The following funny-looking lines just prepare 
        # the (t,s) and (s,t) entries of SC table. 
        u:=List([1..Sum(B{[1..i+j]})],x->Zero(K));
        Append(u,Coefficients(BB,v));
        w:=TransposedMat(ListX([1..Size(u)],
          x->u[x]<>Zero(K), x->[x,u[x]]));
        if w=[] then w:=[[],[]];fi;
        T[s][t]:=w;
        if i<>j then 
          x:=ShallowCopy(w);
          x[2]:=(-1)^(i*j)*x[2];
          T[t][s]:=x;
        fi;
      od;
    od;
  od;
od;
end
);
