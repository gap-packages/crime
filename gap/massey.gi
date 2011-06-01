# There is an explanation of this program in the documentation.
# Wherever possible, the program uses the same notation as
# that document.

InstallGlobalFunction(_MasseyProduct,function(C,L,d,n)
# L is a list of chain maps having degrees 
# given by the list d.
# This function recursively computes u such that 
# du = the lower degree product <L>=g,
# together with the first n lifts of u.
# Thus, the list returned has length n+1.

local m,g,t,l,r,dl,dr,s,f,u,dg;
m:=Size(L);
if m=0 then Error("Empty list\n");fi;
if m=1 then return L[1];fi;

# First we write down <L>=g.
dg:=Sum(d)-m+2;               # dg=Degree(g), so Degree(u)=dg-1.
f:=_MasseyProduct(C,L{[1..m-1]},d{[1..m-1]},d[m])[d[m]+1]
  *LiftHom(C!.L[1],L[m][1],C!.p);
g:=ListWithIdenticalEntries(n-1,0);
for t in [1..m-1] do
  #u^{1..t}*u^{t+1..m}
  dl:=Sum(d{[1..t]})-t+1;     # Degree of left factor
  dr:=Sum(d{[t+1..m]})+t-m+1; # Degree of right factor
  l:=_MasseyProduct(C,L{[1..t]},d{[1..t]},n+dr-1); # left factor
  r:=_MasseyProduct(C,L{[t+1..m]},d{[t+1..m]},n-1);# right factor
  for s in [1..n-1] do
    g[s]:=g[s]+(-1)^dl*l[dr+s+1]*LiftHom(C!.L[1],r[s+1],C!.p);
  od;
od;
# f is the first step (the map g_d) and the list g contains 
# steps 2 through n (the maps g_{d+1} through g_{d+n}).

u:=[0,List(f*(-1)^dg,x->SolutionMat(C!.d[1],x))];
if not ForAll(u[2],x->not x=fail) then return fail;fi;

for t in [1..n-1] do
  f:=g[t]-(-1)^dg*C!.R[dg+t]*LiftHom(C!.L[1],u[t+1],C!.p);
  Append(u,[List(f,x->SolutionMat(C!.d[t+1],x))]);
  if not ForAll(u[2+t],x->not x=fail) then return fail;fi;
od;
return u;
end
);

InstallGlobalFunction(MasseyProduct,function(arg)
# Observe that if the degree of the result is > Grading(A).max_degree,
# then the function will return unexpected results. 

local m,C,B,f,d,H,t,y,x,dt;
m:=Size(arg);
if not m>1 then Error("Not defined\n");fi;
if not ForAll(arg,IsHomogeneous) 
  then Error("Elements not all homogeneous\n");
fi;
C:=FamilyObj(arg[1])!.fullSCAlgebra!.AssociatedCohomologyObject;
B:=Basis(C!.A);
f:=Grading(C!.A).hom_components;
d:=List(arg,Degree);
ProjectiveResolution(C,Sum(d)+1-m);
H:=List(arg,x->FirstLift(C,Coefficients(Basis(f(Degree(x))),x)));
for t in [1..m-1] do
  LiftChainMapAlternating(C,H[t],d[t],Sum(d{[t+1..m]}));
od;

y:=_MasseyProduct(C,H{[1..m-1]},d{[1..m-1]},d[m]);
if y=fail then return fail;fi;
x:=(-1)^(Sum(d{[1..m-1]})-m+2)
  *y[d[m]+1]*LiftHom(C!.L[1],H[m][1],C!.p);
dt:=Sum(d)-m+2;
return Coefficients(Basis(FullRowSpace(C!.K,C!.B[dt+1])),
  TransposedMat(x)[1])*
    B{[Sum(C!.B{[1..dt]})+1..Sum(C!.B{[1..dt+1]}) ]};
end
);
