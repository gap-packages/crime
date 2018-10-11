LoadPackage("crime");
dirs:=DirectoriesPackageLibrary("crime", "tst");
TestDirectory(dirs, rec(exitGAP := true));
FORCE_QUIT_GAP(1);
