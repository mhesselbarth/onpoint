context("test-plot_quantums")

test_that("plot_quantums returns ggplot", {

  pattern <- spatstat.core::rThomas(kappa = 50, scale = 0.025, mu = 5)

  csr_envelope <- spatstat.core::envelope(pattern,
                                          fun = spatstat.core::pcf, nsim = 9,
                                          funargs = list(divisor = "d",
                                                         correction = "Ripley"),
                                          verbose = FALSE)

  plot <- plot_quantums(csr_envelope, ylab = "g(r)")

  expect_is(plot, "ggplot")
  expect_true(plot$labels$y == "g(r)")
  expect_length(plot$layers, n = 4)
})

test_that("plot_quantums returns ggplot (only quantum)", {

  pattern <- spatstat.core::rThomas(kappa = 50, scale = 0.025, mu = 5)

  csr_envelope <- spatstat.core::envelope(pattern,
                                          fun = spatstat.core::pcf, nsim = 9,
                                          funargs = list(divisor = "d",
                                                         correction = "Ripley"),
                                          verbose = FALSE)

  plot <- plot_quantums(csr_envelope, ylab = "g(r)", full_fun = FALSE)

  expect_is(plot, "ggplot")
  expect_length(plot$layers, n = 1)
})

test_that("plot_quantums returns ggplot only function", {

  pattern <- spatstat.core::rThomas(kappa = 50, scale = 0.025, mu = 5)

  csr_envelope <- spatstat.core::envelope(pattern,
                                          fun = spatstat.core::pcf, nsim = 9,
                                          funargs = list(divisor = "d",
                                                         correction = "Ripley"),
                                          verbose = FALSE)

  plot <- plot_quantums(csr_envelope, ylab = "g(r)", quantum = FALSE)

  expect_is(plot, "ggplot")
  expect_length(plot$layers, n = 3)
})

test_that("plot_quantums creates labels if not provided", {

  pattern <- spatstat.core::rThomas(kappa = 50, scale = 0.025, mu = 5)

  csr_envelope <- spatstat.core::envelope(pattern,
                                          fun = spatstat.core::pcf, nsim = 9,
                                          funargs = list(divisor = "d",
                                                         correction = "Ripley"),
                                          verbose = FALSE)

  expect_warning(plot_quantums(csr_envelope,
                              labels = c("clustering", "segregation")),
                 regexp = "Not enough labels provided - using 'obs > hi', 'lo < obs < hi' and 'ob < lo'.")
})

test_that("plot_quantums returns error", {

  pattern <- spatstat.core::rThomas(kappa = 50, scale = 0.025, mu = 5)

  expect_error(plot_quantums(pattern, ylab = "g(r)"),
               regexp = "Please provide envelope or data frame.")
})
