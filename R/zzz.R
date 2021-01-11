
.onAttach <- function(...) {

  packageStartupMessage(crayon::white(paste0(
      "Thanks for using tRavis v", utils::packageVersion("tRavis"), "!\n",
      "If you encounter any bugs or problems, please submit an issue at the\n",
      "Github page: https://github.com/travis-m-blimkie/tRavis/issues"
  )))
}
