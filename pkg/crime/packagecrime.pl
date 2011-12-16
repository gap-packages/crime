#!/usr/bin/perl
# This script should be run as
# ./packagecrime directory version

my $location=$ARGV[0];
my $version=$ARGV[1];
die "/tmp/pkg/crime exists: $!" if -e "/tmp/pkg/crime";
mkdir "/tmp/pkg", 0755;
system "cp -pR $location /tmp/pkg";
use POSIX qw(strftime);
my $date=strftime "%d/%m/%Y", localtime;

open(P,"/tmp/pkg/crime/PackageInfo.g") or die "Can't open PackageInfo.g for reading: $!";
open(Q,">/tmp/pkg/crime/PackageInfo.g-") or die "Can't open PackageInfo.g- for writing: $!";
while(<P>){
s/Version := \".*\"/Version := \"$version\"/;
s/Version .*\\/Version $version\\/;
s/^  Date := \".*\"/  Date := \"$date\"/;
s/crime-.*\"/crime-$version\"/;
print Q;
}
rename ("/tmp/pkg/crime/PackageInfo.g-","/tmp/pkg/crime/PackageInfo.g");

open(P,"/tmp/pkg/crime/doc/crime.xml") or die "Can't open crime.xml for reading: $!";
open(Q,">/tmp/pkg/crime/doc/crime.xml-") or die "Can't open crime.xml- for writing: $!";
while(<P>){
s/>Version .*</>Version $version</;
s/crime-.*\.tar\.gz/crime-$version.tar.gz/;
print Q;
}
rename ("/tmp/pkg/crime/doc/crime.xml-","/tmp/pkg/crime/doc/crime.xml");

open(P,"/tmp/pkg/crime/README") or die "Can't open README for reading: $!";
open(Q,">/tmp/pkg/crime/README-") or die "Can't open README- for writing: $!";
while(<P>){
s/crime-.*.tar.gz/crime-$version.tar.gz/g;
print Q;
}
rename ("/tmp/pkg/crime/README-","/tmp/pkg/crime/README");

chdir "/tmp/pkg/crime/doc" or die "Cant chdir to /tmp/pkg/crime/doc: $!";
# Yes, I know how to spell Can't.
system "latex explanation";
system "bibtex explanation";
system "latex explanation";
system "latex explanation";
system "dvips explanation";
system "pdflatex explanation";
system "latex example";
system "latex example";
system "dvips example";
system "pdflatex example";
system "gap -l '/tmp;' compile"; # Has to be killed manually.

foreach (glob "*.blg *.brf *.idx *.ilg *.ind *.log *.pnr *.toc *.aux"){
  unlink;
}

chdir "/tmp/pkg" or die "Cant chdir to /tmp/pkg: $!";
system "tar cvzvf /tmp/crime-$version.tar.gz --owner=0 --group=0 crime";
system "scp crime/PackageInfo.g crime/README /tmp/crime-$version.tar.gz math.uic.edu:/afs/math.uic.edu/public_html/marcus/Crime/";
system "rm -fr /tmp/pkg";
