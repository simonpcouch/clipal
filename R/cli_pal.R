#' Create a cli pal
#'
#' A light wrapper around elmer chat functions to create a chat object with
#' a custom system prompt.
#'
#' @param fn A `new_*()` function, likely from the elmer package. Defaults
#'   to [elmer::new_chat_claude()].
#' @param .ns The package that the `new_*()` function is exported from.
#' @param ... Additional arguments to `fn`.
#'
#' @examplesIf FALSE
#' # to create a chat with claude:
#' clipal()
#'
#' # or with OpenAI's o1-mini:
#' clipal(
#'   "new_chat_openai",
#'   model = "gpt-4o-mini"
#' )
#'
#' @export
cli_pal <- function(fn = "new_chat_claude", ..., .ns = "elmer") {
  args <- list(...)

  args$system_prompt <- cli_system_prompt

  cli_pal <- rlang::eval_bare(rlang::call2(fn, !!!args, .ns = "elmer"))

  .stash_last_cli_pal(cli_pal)

  cli_pal
}

# TODO: a print method. it'd be nice to just be able to set
# `$messages(include_system_prompt = FALSE)` in elmer:::print.Chat(),
# but may need to inline it here.
