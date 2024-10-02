test_that(".last_cli_pal is up to date with most recent cli pal", {
  skip_if(identical(Sys.getenv("ANTHROPIC_API_KEY"), ""))
  skip_if(identical(Sys.getenv("OPENAI_API_KEY"), ""))
  skip_if_not_installed("withr")
  withr::local_options(.clipal_fn = NULL, .clipal_args = NULL)

  cli_pal()
  expect_snapshot(.last_cli_pal)

  cli_pal("new_chat_openai", model = "gpt-4o-mini")
  expect_snapshot(.last_cli_pal)
})
