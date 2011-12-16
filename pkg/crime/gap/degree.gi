InstallMethod(IsHomogeneous,[IsSCAlgebraObj],
  function(e)
    local A,f,n;
    A:=FamilyObj(e)!.fullSCAlgebra;
    f:=Grading(A).hom_components;
    for n in [0..Grading(A).max_degree] do
      if e in f(n) then return true;fi;
    od;
    return false;
  end
);

InstallMethod(Degree,[IsSCAlgebraObj],
  function(e)
    local A,f,n;
    A:=FamilyObj(e)!.fullSCAlgebra;
    f:=Grading(A).hom_components;
    for n in [0..Grading(A).max_degree] do
      if e in Subspace(A,Flat(List([0..n],x->Basis(f(x)))))
        then return n;
      fi;
    od;
    return fail;
  end
);
