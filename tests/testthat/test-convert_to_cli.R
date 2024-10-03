test_that("convert_to_cli works", {
  skip_if(identical(Sys.getenv("ANTHROPIC_API_KEY"), ""))
  skip_if_not_installed("withr")
  withr::local_options(.clipal_fn = NULL, .clipal_args = NULL)

  cli_pal()

  res <- convert_to_cli(stop("Error message here."))

  expect_s3_class(res, c("cli_conversion", "character"))
  expect_true(grepl("cli_abort", res))
  expect_true(grepl("Error message", res))
})

test_that("convert_to_cli errors informatively without a cli pal", {
  skip_if(identical(Sys.getenv("ANTHROPIC_API_KEY"), ""))
  skip_if_not_installed("withr")
  withr::local_options(.clipal_fn = NULL, .clipal_args = NULL)

  cli_pal()
  cli_pal_env <- search_envs()[["org:r-lib"]]
  cli_pal_env[[".last_cli_pal"]] <- NULL

  expect_snapshot(error = TRUE, convert_to_cli(stop("Error message here.")))
})
