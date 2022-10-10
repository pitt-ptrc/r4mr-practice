library(tidyverse)

# This dataset is an extract that comes from MIMIC-III data. It is much cleaner than we expect!

rx <- read_csv("data/rx.csv")

rx

# This is common in dataset. It is too big to see all at once!

# You can view the contents

rx |> View()

# Or get a helpful glimpse

rx |> glimpse()


# selecting ---------------------------------------------------------------



# Suppose we wanted to look only at the ids

rx |> select(ends_with("id"))

# Or drug info

rx |> select(starts_with("drug"))

# Or both!

rx |> select(ends_with("id"), starts_with("drug"))

# mutating ----------------------------------------------------------------

# lets try converting a column into a different type.

# So far we all our changes have been temporary. But now we want to create new variables

temp_row_ids <-
  rx |>
  select(row_id) |>
  mutate(row_id_num = as.character(row_id))

temp_row_ids

# we didn't need to `select` first, but it helps us see that `row_id_num` came from `row_id`

# we can also overwrite variables and columns. R won't warn us about that.

temp_row_ids <-
  rx |>
  select(row_id) |>
  mutate(row_id = as.character(row_id))

temp_row_ids

# finally, when going from charater to number, NAs are often a problem

rx |> glimpse()

rx |>
  select(form_val_disp) |>
  mutate(form_val_disp_num = form_val_disp |> as.numeric()) |>
  print(n = 20)


# counting -------------------------------------------------------------

# Now we can get to some practical examples

# Let's remind ourselves of our dataset

rx |> glimpse()

# Very often, we want to get a sense of counts per something else.

# let's suppose each `id` is a unique event or person. How many prescriptions happen per subject?

rx |>
  count(subject_id)

# You can also sort

rx |>
  count(subject_id, sort = TRUE)

# One patient got more than 1000 rxs.
# How would we see prescriptions per ICU stay?





# Probably the subject didn't have all those rx on one stay.

rx |> count(subject_id, hadm_id, sort = TRUE)

rx |>
  count(subject_id, hadm_id, sort = TRUE) |>
  arrange(subject_id) |>
  print(n = 20)

# Why was `arrange` needed?

# on lines 19 and 20, we see someone with two hospital stays


# filtering

# let's look at just IV meds, and then count those

rx |> filter(route == "IV") |>
  count(drug, sort = TRUE)

# Notice that in real data, similar things are always together (NaCL)

rx |> filter(route == "DIALYS") |>
  count(dose_val_rx, dose_unit_rx)

# Notice that in real data, similar things are always together (ml Ml)

# summarizing -------------------------------------------------------------

# this is the same as the count function

rx

rx |>
  group_by(subject_id) |>
  summarise(n = n())

# Let's go back to dialysis

rx |> filter(route == "DIALYS") |>
  mutate(dose_val_rx = dose_val_rx |> as.numeric()) |>
  group_by(dose_unit_rx) |>
  summarise(avg = mean(dose_val_rx))

# we can get multiple summaries at the same time

rx |> filter(route == "DIALYS") |>
  mutate(dose_val_rx = dose_val_rx |> as.numeric()) |>
  group_by(dose_unit_rx) |>
  summarise(avg = mean(dose_val_rx), sd = sd(dose_val_rx))
