rs_convert_to_cli <- function(context = rstudioapi::getActiveDocumentContext()) {
  # see if the user has run `cli_pal()` successfully already
  if (!exists(".last_cli_pal")) {
    tryCatch(
      cli_pal(),
      error = function(e) {
        rstudioapi::showDialog("Error", "Unable to create a cli pal. See `?cli_pal()`.")
      }
    )
  }

  selection <- rstudioapi::primary_selection(context)
  selection_text <- selection[["text"]]

  if (selection_text == "") {
    rstudioapi::showDialog("Error", "No code selected. Please highlight some code first.")
    return(NULL)
  }

  tryCatch({
    output_str <- convert_to_cli_impl(selection_text, .last_cli_pal)

    rstudioapi::modifyRange(
      selection$range,
      output_str,
      context$id
    )
    n_lines <- length(gregexpr("\n", output_str)[[1]])
    selection$range$end[[1]] <- selection$range$start[[1]] + n_lines
    rstudioapi::setSelectionRanges(selection$range)
    rstudioapi::executeCommand("reindent")
  }, error = function(e) {
    rstudioapi::showDialog("Error", paste("The cli pal ran into an issue: ", e$message))
  })
}
