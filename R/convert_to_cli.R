#' Convert erroring code to use cli
#'
#' @param expr Lines of code that raise an error, as an expression.
#' @param cli_pal A cli pal created with [cli_pal()].
#'
#' @examplesIf FALSE
#' cli_pal <- cli_pal()
#'
#' convert_to_cli(stop("An error message."))
#'
#' @export
convert_to_cli <- function(expr, cli_pal = if (exists(".last_cli_pal")) .last_cli_pal else NULL) {
  if (is.null(cli_pal)) {
    cli::cli_abort(
      "Create a cli pal with {.fn cli_pal} to use this function."
    )
  }

  x <- deparse(substitute(expr))
  convert_to_cli_impl(x = x, cli_pal = cli_pal)
}

convert_to_cli_impl <- function(x, cli_pal) {
  structure(cli_pal$chat(x), class = c("cli_conversion", "character"))
}

#' @export
print.cli_conversion <- function(x, ...) {
  cat(x)
}
