PRank:=function(G) 
# It's more difficult to understand 
# the indentation then the content.
return
Maximum(
  List(
    Filtered(
      List(
        ConjugacyClassesSubgroups(LatticeSubgroups(G)),
        Representative),
      IsElementaryAbelian),
    Size)
);
end;
