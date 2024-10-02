test_that("cli pal can vary underlying model", {
  skip_if(identical(Sys.getenv("ANTHROPIC_API_KEY"), ""))
  skip_if(identical(Sys.getenv("OPENAI_API_KEY"), ""))
  withr::local_options(.clipal_fn = NULL, .clipal_args = NULL)

  # defaults to anthropic
  expect_snapshot(cli_pal())

  # respects other argument values
  expect_snapshot(cli_pal("new_chat_openai", model = "gpt-4o-mini"))

  # respects .clipal_* options
  withr::local_options(
    .clipal_fn = "new_chat_openai",
    .clipal_args = list(model = "gpt-4o-mini")
  )
  expect_snapshot(cli_pal())
})
