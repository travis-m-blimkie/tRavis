
.onAttach <- function(...) {

  packageStartupMessage(
    paste0(
      "Thanks for using tRavis v", utils::packageVersion("tRavis"), "! ",
      "If you encounter any bugs or problems, please submit an issue at the ",
      "Github page: https://github.com/travis-m-blimkie/tRavis/issues"
    ) %>% stringr::str_wrap(width = getOption("width"))
  )
}
