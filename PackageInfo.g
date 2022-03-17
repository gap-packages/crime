#############################################################################
##  PackageInfo.g for the package `crime'                       Marcus Bishop

SetPackageInfo( rec(
  PackageName := "CRIME",
  Subtitle := "A GAP Package to Calculate Group Cohomology and Massey Products",
  Version := "1.6",
  Date := "17/03/2022", # dd/mm/yyyy format
  License := "GPL-2.0-or-later",

  Persons := [
    rec( 
      LastName      := "Bishop",
      FirstNames    := "Marcus",
      IsAuthor      := true,
      IsMaintainer  := false,
      Email         := "marcus.bishop@gmail.com",
      WWWHome       := "http://math.uic.edu/~marcus",
    ),
    rec(
      LastName      := "GAP Team",
      FirstNames    := "The",
      IsAuthor      := false,
      IsMaintainer  := true,
      Email         := "support@gap-system.org",
    ),
  ],
  Status := "accepted",
  CommunicatedBy := "Bettina Eick (Braunschweig)",
  AcceptDate := "10/2006",

  PackageWWWHome  := "https://gap-packages.github.io/crime/",
  README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
  PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
  SourceRepository := rec(
      Type := "git",
      URL := "https://github.com/gap-packages/crime",
  ),
  IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
  ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                   "/releases/download/v", ~.Version,
                                   "/crime-", ~.Version ),
  ArchiveFormats := ".tar.gz",

  AbstractHTML := Concatenation([
    "This package computes the cohomology rings of finite ", 
    "p-groups, induced maps, and Massey products."
  ]),

  PackageDoc := rec(
    BookName      := "crime",
    ArchiveURLSubset := ["doc"],
    HTMLStart     := "doc/chap0.html",
    PDFFile       := "doc/manual.pdf",
    SixFile       := "doc/manual.six",
    LongTitle     := "The CRIME Package",
    Autoload      := true
  ),

  Dependencies := rec(
    GAP := ">=4.9",
    NeededOtherPackages := [],
    SuggestedOtherPackages := [],
    ExternalConditions := []
  ),

  AvailabilityTest := ReturnTrue,
  BannerString:=Concatenation([
    "\nThis is CRIME, Version ", ~.Version, "\n",
    "\"Obviously crime pays, or there'd be no crime\".\n",
    "                                G. Gordon Liddy\n\n"
  ]), 
  Autoload := false,
  TestFile := "tst/testall.g",
  Keywords := ["cohomology"],

AutoDoc := rec(
    TitlePage := rec(
        Copyright := """
&copyright; 2006, 2007 Marcus Bishop <P/>
<Package>CRIME</Package> is free software which is distributed under
the GNU Public Licence, version 2, and may be
redistributed under the GNU Public Licence, version 2
or later (at your preference).
See the file COPYING for detailed information
""",

        Acknowledgements := """
This project would not have been possible without Jon Carlson.
Jon devised the algorithms used by <K>ProjectiveResolution</K>,
<K>CohomologyGenerators</K>, and <K>CohomologyRelators</K>,
having already implemented them in <Package>Magma</Package>,
and shared these programs with me.
""",
    )
),

));
