
# install manually


## Go to the packages tab and see which packages are installed

## Try installing "remotes"

## Notice what is happening in the console.

## Now try the code-first equivalent:

install.packages("survival")

## To access the functions contained in a package, we usually load it:

library(dplyr)

mtcars |> select(mpg, cyl)

## If we just want one function, or we need to make it explicit
## where the function is coming from, we can use :: notation

mtcars |> dplyr::select(mpg, cyl)

## Suppose we want to work with a subset of the dataset. We can save it to a variable.

mtcars2 <- mtcars |> dplyr::select(mpg, cyl)

# Now notice that it shows up in the Environment Tab

# We can inspect the structure with the circle-triangle button, and view the contents with the table button.

# You can also do that with code:

mtcars2 |> View()

mtcars2 |> glimpse()

# Suppose we want to save our transformed data for later

mtcars2 |> write.csv("data/temp_mtcars.csv")
