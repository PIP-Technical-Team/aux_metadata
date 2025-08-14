library(fastverse)

m2 <- fread("metadata.csv")
m1 <- fread("pip_metadata.csv")


# Remove columns where all values are NA in m1
m1 <- m1[, vapply(m1, allNA, logical(1)) |>
           whichv(FALSE),
         with = FALSE]

# Remove columns where all values are NA in m2
m2 <- m2[, vapply(m2, allNA, logical(1)) |>
           whichv(FALSE),
         with = FALSE]

# Fix typo

m2[ grepl("^CNH", svy_id),
    svy_id := gsub("CNH_", "CHN_", svy_id)]

m1[ grepl("^CNH", svy_id),
    svy_id := gsub("CNH_", "CHN_", svy_id)]


jn <- joyn::joyn(m2, m1, "svy_id",
           match_type = "1:1",
           keep = "full",
           # y_vars_to_keep = "link",
           update_NAs = TRUE)

