#############################################################################
##  PackageInfo.g for the package `crime'                       Marcus Bishop
##  (created from Frank Lübeck's PackageInfo.g template file)

SetPackageInfo( rec(
  PackageName := "Crime",
  Subtitle := "A GAP Package to Calculate Group Cohomology and Massey Products",
  Version := "0.2",
  Date := "24/07/2006",
  ArchiveURL := 
    "http://mad.epfl.ch/~bishop/Crime/crime-0.2",
  ArchiveFormats := ".tar.gz",

  Persons := [
    rec( 
      LastName      := "Bishop",
      FirstNames    := "Marcus",
      IsAuthor      := true,
      IsMaintainer  := true,
      Email         := "marcus.bishop@epfl.ch",
      WWWHome       := "http://people.epfl.ch/marcus.bishop",
      PostalAddress := Concatenation([
                         "EPFL SB IGAT MAD\n",
                         "MA C3 615 (Bâtiment MA)\n",
                         "Station 8\n",
                         "CH-1015 Lausanne\n",
                         "Switzerland"
                        ]),
      Place         := "Lausanne",
      Institution   := "EPFL"
    )
  ],
  Status := "deposited",
  README_URL := 
    "http://mad.epfl.ch/~bishop/Crime/README",
  PackageInfoURL:=
    "http://mad.epfl.ch/~bishop/Crime/PackageInfo.g",
  AbstractHTML := Concatenation([
    "This package computes the cohomology ring ",
    "of finite p-groups, induced maps, and ",
    "Massey products.\n"
  ]),
  PackageWWWHome:= 
    "http://mad.epfl.ch/~bishop/Crime",

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
    "\nLast night I was on the threshold of hell.\n",
    "To-day, I am within sight of my heaven.\n",
    "          -Emily Bronte, Wuthering Heights\n"
  ]),
  Autoload := false,
  TestFile := "tst/test.g",
  Keywords := ["cohomology"],
));
