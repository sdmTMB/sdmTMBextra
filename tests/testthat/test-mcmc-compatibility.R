test_that("MCMC setup supports legacy sdmTMB fits", {
  skip_if_not_installed("sdmTMB")

  dat <- data.frame(
    y = c(0, 1, 0, 1, 1, 0),
    x = c(-2, -1, 0, 0, 1, 2)
  )
  fit <- sdmTMB::sdmTMB(
    y ~ x,
    data = dat,
    spatial = "off",
    family = stats::binomial(),
    silent = TRUE
  )

  m <- mle_mcmc_object(fit)

  expect_true(is.list(m$obj))
  expect_true(is.function(m$obj$fn))
  expect_true(length(m$map) > 0L)
  expect_true(all(vapply(m$map, is.factor, logical(1))))
})
