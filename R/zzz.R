# nocov start

.onLoad <- function(libname, pkgname) {
  # automatically source .env for API keys on package load
  if (rlang::is_installed("dotenv")) {
    library(dotenv)
  }

  rlang::env_bind(
    rlang::ns_env("clipal"),
    cli_system_prompt =
      paste0(
        readLines(system.file("prompt.md", package = "clipal")),
        collapse = "\n"
      )
  )
}

# nocov end
