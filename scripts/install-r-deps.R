local({
  repo <- Sys.getenv("CRAN_REPO", unset = "https://cloud.r-project.org")
  lib <- Sys.getenv("R_LIBS_USER", unset = "~/R/library")
  lib <- path.expand(lib)

  if (!dir.exists(lib)) {
    dir.create(lib, recursive = TRUE, showWarnings = FALSE)
  }

  .libPaths(c(lib, .libPaths()))

  packages <- c(
    "bookdown"
  )

  missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]

  if (length(missing) > 0) {
    install.packages(missing, lib = lib, repos = repo)
  }

  versions <- vapply(
    packages,
    function(package) as.character(utils::packageVersion(package)),
    character(1)
  )

  message("R library: ", lib)
  message("Installed packages:")
  for (package in names(versions)) {
    message("- ", package, " ", versions[[package]])
  }
})
