# nocov start

.onLoad <- function(libname, pkgname) {
  # automatically source .env for API keys on package load
  rlang::try_fetch(
    dotenv::load_dot_env(),
    error = function(e) {
      rlang::inform(
        c(
          ".env file not found.",
          "i" = "See {.fn cli_pal} for more information."
        ),
        class = "packageStartupMessage"
      )
    }
  )


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
