# nocov start

.onLoad <- function(libname, pkgname) {
  # automatically source .env for API keys on package load
  if (rlang::is_installed("dotenv")) {
    library(dotenv)
  }
}

# nocov end
