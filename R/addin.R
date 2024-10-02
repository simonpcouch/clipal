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

  selection <- rstudioapi::primary_selection(context)[["text"]]

  if (selection == "") {
    rstudioapi::showDialog("Error", "No code selected. Please highlight some code first.")
    return(NULL)
  }

  tryCatch({
    output_str <- convert_to_cli_impl(selection, .last_cli_pal)

    rstudioapi::modifyRange(
      context$selection[[1]]$range,
      output_str,
      context$id
    )
  }, error = function(e) {
    rstudioapi::showDialog("Error", paste("The cli pal ran into an issue: ", e$message))
  })
}
