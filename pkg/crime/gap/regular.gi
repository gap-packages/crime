# This is a modified version of the library 
# function RegularModule by Bettina Eick.
# Returns a list of matrices giving the actions
# of g on kG for all g in Pcgs(G) with respect
# to the basis ReverseLex(G) of KG.

# And just so everyone is clear, no one being
# more confused than me about this, RIGHT 
# multiplication by one of these matrices 
# corresponds with RIGHT multiplication 
# by the corresponding group element.
  
InstallGlobalFunction(_RegularModule,function( G, K )
  local gens, mats, elms, d, zero, i, mat, j, o;
  gens := Pcgs(G);
  mats := List( gens, x -> false );
  elms := ReverseLex(G);
  d    := Length(elms);
  zero := NullMat( d, d, K );
  for i in [1..Length( gens )] do
    mat := List( zero, ShallowCopy ); 
    for j in [1..d] do
      o := Position( elms, elms[j]*gens[i] );
      mat[j][o] := One( K );
    od;
    ConvertToMatrixRep(mat,K);
    mats[i] := mat;
  od;
  return  mats;
  end
);
