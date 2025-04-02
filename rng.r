generateDatasetFile <- function(n) {

    dir.create("data", showWarnings = FALSE)

    fileName <- paste0(n, ".txt")

    path <- paste0("data/", fileName)

    if (file.exists(path)) {
        file.remove(path)
    }

    # Generate all numbers at once and write in one go
    nbrs <- sample(0:9999, n, replace = TRUE)
    write(nbrs, file = path, ncolumns = 1)

    return(path)
}
