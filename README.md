
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

You can install clipal like so:

``` r
pak::pak("simonpcouch/clipal")
```

Then,

- Ensure that you have an `ANTHROPIC_API_KEY` set in your
  [`.env`](https://github.com/gaborcsardi/dotenv). If you’re using a
  different LLM to power the cli pal, see `?cli_pal()` to set default
  metadata on that model.
- Assign the “Convert to cli” addin the shortcut “Ctrl+Shift+C”.

## Example

### RStudio Add-in

The package provides an RStudio add-in “Convert to cli” that we suggest
registering with the keybinding “Ctrl+Shift+C”. To do so, navigate to
Tools \> Modify Keyboard Shortcuts \> Search “Convert to cli”, and add
the keybinding. After selecting some code, press the keyboard shortcut
and wait a moment:

![](inst/figs/addin.gif)

### In code

The `cli_pal()` function instantiates a cli pal and is a light wrapper
around functions creating [elmer](https://github.com/hadley/elmer)
chats.

``` r
library(clipal)

cli_pal()
#> <Chat messages=0>
```

By default, `cli_pal()` uses Claude Sonnet 3.5 via
`elmer::new_chat_claude()`, though users can choose other models. Then,
the `convert_to_cli()` function takes an R expression that raises a
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
