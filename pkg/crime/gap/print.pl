#!/usr/bin/perl
# This program prints all the source code to 
# a pretty tex file which could be comfortably
# read on the sofa, for example.

# The files in logical order.
my @files=qw(helpers.gi action.gi
lift.gi augmentation.gi radical.gi
resolution.gi comments generators.gi
relations.gi table.gi ring.gi induced.gi
degree.gi locate.gi massey.gi);

open PRINT,">print.tex" or die "Cant open print.tex for writing: $!";
print PRINT '\documentclass{article}\usepackage{vmargin,palatino}',"\n";
print PRINT '\setmarginsrb{2cm}{2cm}{2cm}{2cm}{0cm}{0cm}{0cm}{0cm}',"\n";
print PRINT '\begin{document}',"\n";
foreach my $file (@files){
  open LINE, $file or die "Cant open $file for reading: $!";
  print PRINT "\\section\{$file\}\n\\begin\{verbatim\}";
  foreach (<LINE>){
    print PRINT;
    # Or use the following line to remove the comments.
    # print PRINT unless /^\s*\#/;
  }
  print PRINT "\\end\{verbatim\}\n\n";
close FILE;
}
print PRINT "\\end\{document\}";
close PRINT;
