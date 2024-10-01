#' Save most recent results to search path
#'
#' @param x A cli pal.
#'
#' @return NULL, invisibly.
#'
#' @details The function will assign `x` to `.last_cli_pal` and put it in
#' the search path.
#'
#' @export
#' @keywords internal
.stash_last_cli_pal <- function(x) {
  if (!"org:r-lib" %in% search()) {
    do.call("attach", list(new.env(), pos = length(search()),
                           name = "org:r-lib"))
  }
  env <- as.environment("org:r-lib")
  env$.last_cli_pal <- x
  invisible(NULL)
}
