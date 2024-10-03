#' Create a cli pal
#'
#' A light wrapper around elmer chat functions to create a chat object with
#' a custom system prompt.
#'
#' @param fn A `new_*()` function, likely from the elmer package. Defaults
#'   to [elmer::new_chat_claude()]. To set a persistent alternative default,
#'   set the `.clipal_fn` option; see examples below.
#' @param .ns The package that the `new_*()` function is exported from.
#' @param ... Additional arguments to `fn`. The `system_prompt` argument will
#'   be ignored if supplied. To set persistent defaults,
#'   set the `.clipal_args` option; see examples below.
#'
#' @details
#' Upon successfully creating a cli pal, this function will assign the
#' result to the search path as `.last_cli_pal`. At that point,
#' [convert_to_cli()] and the RStudio add-in "Convert to cli" know to look
#' for `.last_cli_pal` and you don't need to worry about passing your cli
#' pal yourself.
#'
#' If you have an Anthropic API key (or another API key and the `clipal_*()`
#' options) set and this package installed, you are ready to using the add-in
#' in any R session with no setup or library loading required; the addin knows
#' to look for your API credentials and will call both
#' this function and [convert_to_cli()] itself.
#'
#' @examplesIf FALSE
#' # to create a chat with claude:
#' clipal()
#'
#' # or with OpenAI's 4o-mini:
#' clipal(
#'   "new_chat_openai",
#'   model = "gpt-4o-mini"
#' )
#'
#' # to set OpenAI's 4o-mini as the default, for example, set the
#' # following options (possibly in your .Rprofile, if you'd like
#' # them to persist across sessions):
#' options(
#'   .clipal_fn = "new_chat_openai",
#'   .clipal_args = list(model = "gpt-4o-mini")
#' )
#' @export
cli_pal <- function(fn = getOption(".clipal_fn", default = "new_chat_claude"), ..., .ns = "elmer") {
  args <- list(...)
  default_args <- getOption(".clipal_args", default = list())
  args <- modifyList(default_args, args)

  args$system_prompt <- cli_system_prompt

  cli_pal <- rlang::eval_bare(rlang::call2(fn, !!!args, .ns = "elmer"))

  .stash_last_cli_pal(cli_pal)

  structure(cli_pal, class = c("cli_pal", class(cli_pal)))
}

#' @export
print.cli_pal <- function(x, ...) {
  cli::cli_h3(
    "A {.field {x$.__enclos_env__$private$model@model}}-based cli pal."
  )
}
