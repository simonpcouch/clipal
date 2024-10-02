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
