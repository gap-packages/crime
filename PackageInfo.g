#############################################################################
##  PackageInfo.g for the package `crime'                       Marcus Bishop
##  Created from Frank Lübeck's PackageInfo.g template file

SetPackageInfo( rec(
  PackageName := "Crime",
  Subtitle := "A GAP Package to Calculate Group Cohomology and Massey Products",
  Version := "1.4",
  Date := "01/6/2011",
  ArchiveURL := 
    "http://math.uic.edu/~marcus/Crime/crime-1.4",
  ArchiveFormats := ".tar.gz",

  Persons := [
    rec( 
      LastName      := "Bishop",
      FirstNames    := "Marcus",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "marcus.bishop@gmail.com",
      WWWHome       := "http://math.uic.edu/~marcus",
    )
  ],
  Status := "accepted",
  CommunicatedBy := "Bettina Eick (Braunschweig)",
  AcceptDate := "10/2006",
  README_URL := 
    "http://math.uic.edu/~marcus/Crime/README",
  PackageInfoURL:=
    "http://math.uic.edu/~marcus/Crime/PackageInfo.g",
  AbstractHTML := Concatenation([
    "This package computes the cohomology rings of finite ", 
    "p-groups, induced maps, and Massey products."
  ]),
  PackageWWWHome:= 
    "http://math.uic.edu/~marcus/Crime",

  PackageDoc := rec(
    BookName      := "crime",
    ArchiveURLSubset := ["doc"],
    HTMLStart     := "doc/chap0.html",
    PDFFile       := "doc/manual.pdf",
    SixFile       := "doc/manual.six",
    LongTitle     := "The Crime Package",
    Autoload      := true
  ),

  Dependencies := rec(
    GAP := ">=4.4",
    NeededOtherPackages := [],
    SuggestedOtherPackages := [],
    ExternalConditions := []
  ),

  AvailabilityTest := ReturnTrue,
  BannerString:=Concatenation([
    "\nThis is CRIME, Version 1.4\n",
    "\"Obviously crime pays, or there'd be no crime\".\n",
    "                                G. Gordon Liddy\n\n"
  ]), 
  Autoload := false,
  TestFile := "tst/test.g",
  Keywords := ["cohomology"],
));
