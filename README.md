
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Your cli pal <img src="man/figures/logo.png" align="right" height="200" alt="" />

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
assorted nonsense to sort through. Total pain, especially with thousands
upon thousands of error messages thrown across the tidyverse, r-lib, and
tidymodels organizations.

clipal (“c-l-i pal”) is an RStudio add-in that helps you convert your R
package to use cli for error messages. It’s vaguely correct most of the
time, and greatly speeds up the process for converting error messages to
cli, in my experience.

## Installation

You can install the development version of clipal like so:

``` r
pak::pak("simonpcouch/clipal")
```

## Example

The `cli_pal()` function instantiates a cli pal (a light wrapper around
an elmer chat).

``` r
library(clipal)

cli_pal <- cli_pal()
```

The `convert_to_cli()` function takes an R expression that raises a
condition and converts it to use cli. At its simplest:

``` r
convert_to_cli(stop("An error message."))
#> cli::cli_abort("An error message.")
```

The function knows to look for the most recently defined cli pal, but
you can pass one manually via `convert_to_cli(cli_pal)` if you please.
It can handle surprisingly complex erroring code, too. For example, some
`paste0()` enumeration and strange line breaking is no issue:

``` r
convert_to_cli({
  types <- paste0(pred_types, collapse = ", ")
  rlang::abort(
    glue::glue(
      "The model only has prediction types {types}. Did you ",
      "fit the model with `silly_head = TRUE`?"
    )
  )
})
#> cli::cli_abort(
#>   c(
#>     "The model only has prediction types {pred_types}.",
#>     "i" = "Did you fit the model with {.code silly_head = TRUE}?"
#>   )
#> )
```

It seems to have a decent hold on sprintf-style statements, too:

``` r
convert_to_cli({
  abort(sprintf("No such '%s' function: `%s()`.", package, name))
})
#> cli::cli_abort("No such {.pkg {package}} function: {.fn {name}}.")
```

TODO: show by function, file, and package…
