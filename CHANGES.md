# Version history of the CRIME package

## 1.6 (2022-03-17)

- add `License` field to `PackageInfo.g`

## 1.5 (2018-10-11)

- Handed maintenance of the package over to the GAP team

- Fixed an error when using the package in GAP 4.9 and newer

- Moved package to GitHub

- Various other minor changes

## 1.4 (2011-06-01)

  The 1.4 version was primarily introduced to comply with changes
  to package specifications in version 4.5 of GAP. In particular,
  they want the test files to cooperate with their automated
  package testing programs. Cosmetic changes
  were also performed, including and the renaming some functions
  and the removal of smarmy comments in the documentation.

- print.pl now prints comments by default.

  The `PCGens` function now uses GAP's `SmallGeneratingSet`, rather
  then construcing a minimal generating set directly.

  Combined the contents of the files `order.gi`, `matrix.gi`,
  `regular.gi` and `betterbasis.gi` into a single file called `action.gi`

- Made the following name changes:
  - `Inclusion` -> `SubgroupInclusion`
  - `LiftChainMapMassey` -> `LiftChainMapAlternating`
  - `ReverseLex` -> `ReverseLexBasis`
  - `ChangeOfBasisMatrix` -> `GMinusOneBasis`
  - `_RegularModule` -> `ActionOfPCGenerators`

## 1.3 (2007-11-01)

  This file was apparently abandoned at this stage.
  Or possibly no changes were made.

## 1.2 (2007-09-23)

  What was I thinking? Down the middle was eliminated,
  being ridiculously wasteful, and replaced with
  a simple for-loop.

## 1.1 (2006-11-09)

## 1.0 (2006-10-23)

## 0.3 (2006-09-07)

- Most importantly, the function `DiagonalAction`
  uses a for-loop in place of the call to
  `KroneckerProduct`. I thought I was so clever
  for having written the entire function on one line,
  but in fact, `KroneckerProduct` was taking 
  up an inordinate amount of processor time.

- The same function has been renamed DownTheMiddle
  to avoid a conflict with another GAP `package`.

- The call to this function in `lift.g` on line 18
  has been replaced by a single call at the top
  of the j-loop, once per loop instead of every time.

- And I threw in a `ConvertToMatrixRep` at that point,
  which saves a few milliseconds.

- Changed last line in batch.g from "Print(" to "AppendTo(f".

- Added a comment to generators.gi explaining Size(H[1]).

- Changed `X` to `Indeterminate` in relations.gi

- Remarked that `CohomologyRelators` is *not* idempotent.
  Thus, took C!.V away from the cohomology object
  and included it as a local variable in `CohomologyRelators`.

- Also as a local variable in `CohomologyRelators` is the
  new variable IN which holds the indeterminate numbers.
  This information is kept in order to fix a bug in Intersperse.

- `NiceIndeterminate` was eliminated and incorporated into
  `CohomologyRelators`.

- `CohomologyObject` and `CohomologyRing` both test that
  G is a p-group via the `TryNextMethod` mechanism.

- Added functions `Inclusion` and `BoundaryMap`.

- Added file `doc/example.tex `which gives a better
  explanation of the usage of `BoundaryMap` then the
  manual.

- Wrote a slick perl script `packagecrime.pl` to 
  archive the package and another slick perl
  script `perl.pl` to print all the code without
  the comments.

- Included p as a component of the `CObject` to avoid all
  the calls to `PrimePGroup` and `Characteristic`.

- Took away the K argument from `CohomologyObject`,
  as K can be determined from M, and indeed, should
  be the same.

- Improved the argument testing in `CohomologyObject`.

## 0.2 (2006-07-24)

  Initial release.
