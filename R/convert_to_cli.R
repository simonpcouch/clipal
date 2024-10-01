#' Convert erroring code to use cli
#'
#' @param x Lines of code that raise an error, as a character vector.
#' @param chat An elmer chat. Note that the system prompt will be overwritten.
#'
#' @examplesIf FALSE
#' clipal <- new_clipal()
#'
#' convert_to_cli('stop("An error message.")', clipal)
#'
#' @export
convert_to_cli <- function(x, clipal) {
  structure(clipal$chat(x), class = c("cli_conversion", "character"))
}

#' @export
print.cli_conversion <- function(x, ...) {
  cat(x)
}
