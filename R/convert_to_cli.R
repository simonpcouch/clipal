#' Convert erroring code to use cli
#'
#' @param x Lines of code that raise an error, as an expression.
#' @param cli_pal A cli pal created with [cli_pal()].
#'
#' @examplesIf FALSE
#' cli_pal <- cli_pal()
#'
#' convert_to_cli(stop("An error message."), cli_pal)
#'
#' @export
# TODO: default `chat` to the latest cli pal
convert_to_cli <- function(expr, cli_pal) {
  x <- deparse(substitute(expr))
  structure(cli_pal$chat(x), class = c("cli_conversion", "character"))
}

#' @export
print.cli_conversion <- function(x, ...) {
  cat(x)
}
