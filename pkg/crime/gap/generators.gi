# Called as CohomologyGenerators(C,n), the objective
# of this function is to lift ALL of the generators
# n-1 times, discovering the generators of degree > 1 
# in the process. In particular, this means that the
# degree 1 generators will be lifted to maps P_n -> P_{n-1}.

InstallMethod(CohomologyGenerators,
  "Computes cohomology generators to degree n",
  [IsCObject,IsPosInt], 
  function(C,n)
    local G,K,R,L,B,D,P,BB,H,h,j,k,l,m,d,N; 
    ProjectiveResolution(C,n);
    G:=C!.G; K:=C!.K; R:=C!.R; L:=C!.L; B:=C!.B;
    if not IsBound(C!.D) then C!.D:=List([1..B[2]],x->1);fi;
    if not IsBound(C!.P) then C!.P:=[];fi;
    D:=C!.D; P:=C!.P;
    
    # Set up cochains in degree 1.
    if not IsBound(C!.H) then 
      BB:=IdentityMat(B[2],K);
      C!.H:=List(BB,x->FirstLift(C,x));
    fi;
    H:=C!.H;

    for m in [Size(H[1])..n-1] do
      # Size(H[1]) is the number of lifts already computed.
      h:=Size(H); 
      # h is the number of generators there were at the 
      # beginning of round m. We need this information later.
      
      for j in [1..h] do
        d:=D[j];
        LiftChainMap(C,H[j],d,m);
    
        # Digging out the first column of each block column of 
        # the matrix we just computed amounts to multiplying 
        # H[j] by a degree m map, producing a degree d+m map. 
        # We stick them all into P[d+m] for now. 
    
        if not IsBound(P[d+m]) then P[d+m]:=[];fi;
        for k in [1..B[m+1]] do
          Append(P[d+m],[ExtractColumn(H[j][m+1],(k-1)*Size(G)+1)]);
        od;
      od;
    
      # At this point, all products of generators
      # of degree < m+1 which produce maps of degree m+1
      # have been computed put in P[m+1].
    
      N:=BaseSteinitzVectors(
        IdentityMat(B[m+2],K),BaseMat(P[m+1])).factorspace;

      # Voila! The new generators in degree m+1. It only
      # remains to repeat all of the above computations
      # m times for each of the |N| new generators so that
      # all the generators will have the same number m
      # of lifts not including the first map P_d -> P_0.
    
      for j in [1..Size(N)] do
        D[h+j]:=m+1;
        H[h+j]:=FirstLift(C,N[j]);
        ProjectiveResolution(C,2*m+1);
        for k in [1..m] do
          LiftChainMap(C,H[h+j],m+1,k);
          if not IsBound(P[m+k+1]) then P[m+k+1]:=[];fi;
          for l in [1..B[k+1]] do
          Append(P[m+k+1],[ExtractColumn(H[h+j][k+1],(l-1)*Size(G)+1)]);
          od;
        od;
      od;
    od;
    return D;
  end
);
