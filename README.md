
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Your cli pal

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/clipal)](https://CRAN.R-project.org/package=clipal)
<!-- badges: end -->

A couple years ago, the tidyverse team began migrating to the cli R
package for raising errors, transitioning away from base R
(e.g. `stop()`), rlang (e.g. `rlang::abort()`), glue, and homegrown
combinations of them. cli’s new syntax is easier to work with as a
developer and more visually pleasing as a user.

In some cases, transitioning is as simple as Finding + Replacing
`rlang::abort()` to `cli::cli_abort()`. In others, there’s a mess of
ah-hoc pluralization, `paste0()`s, glue interpolations, and other
assorted nonsense to sort through. Total pain in the \*\*\*. clipal
(“c-l-i pal”) is an RStudio add-in that helps you convert your R package
to use cli for error messages.

## Installation

You can install the development version of clipal like so:

``` r
pak::pak("simonpcouch/clipal")
```

## Example

``` r
library(clipal)

clipal <- clipal()

convert_to_cli('stop("An error message.")', clipal)
#> cli::cli_abort("An error message.", call = rlang::call2("TODO: add call here"))
```

TODO: show by function, file, and package…
