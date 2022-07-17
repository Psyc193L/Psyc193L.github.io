# Advanced Wrangling




```r
library(tidyverse) # Load tidyverse packages
```

<!-- <a href="exercises/Exercise_Manip3.Rmd" download>Exercise Sheet</a> -->

This dataset used in examples throughout, called `HELPfull` (`mosaicData::HELPfull`), contains data from the **H**ealth **E**valuation and **L**inkage to **P**rimary Care study. From the dataset's description:

- "The HELP study was a clinical trial for adult inpatients recruited from a detoxification unit. Patients with no primary care physician were randomized to receive a multidisciplinary assessment and a brief motivational intervention or usual care, with the goal of linking them to primary medical care."

This data is saved in a variable called `dat`.



This dataset is ***massive***, so it is not even worth using `glimpse()` to preview it.


```r
ncol(dat)
#> [1] 788
nrow(dat)
#> [1] 1472
```

It contains 788(!!) variables from 1472 observations!!! Throughout, as has been done previously, a `head()` call will be added at the end of most of the code just to prevent having a ***giant*** output in every block!

## Selecting {#helper-functions}

One of the first data wrangle tools we learned back in Lab 2 was `select()`. 

`select()` was introduced [previously](#select) as a way to return only specific columns from your df. In this case, there are a **TON** of variables, and it would be quite annoying to have to explicitly specify all of them that you want by full name. Luckily, there are a number of **<u>helper functions</u>** that you can use with `select()` to help make selecting variables easier. What they do is select the variable names you want by *matching* them based on some specified criteria.

### `starts_with()`

`starts_with()` will select all variables that **start** with a specified pattern.


```r
dat %>%
  select(starts_with("RAW")) %>%
  head()
#>   RAWPF RAWRP RAWBP RAWGH RAWVT RAWSF RAWRE RAWMH RAW_RE
#> 1    28     7   9.4  21.4    13     4     4    15     33
#> 2    28     8  10.0  21.4    19     9     6    23     24
#> 3    30     8   8.2  22.4    16    10     6    27     15
#> 4    29     8  10.4  19.0    20    10     6    27     29
#> 5    21     4   8.1   7.0     9     6     3    13     34
#> 6    30     8  12.0  18.4    15     9     5    21     35
#>   RAW_AM RAW_TS RAW_ADS
#> 1     14     38       5
#> 2     12     33      NA
#> 3      8     36      NA
#> 4     13     37      NA
#> 5      8     30      26
#> 6      7     18      NA
```

### `ends_with()`

`ends_with()` will select all variables that **end** with a specified pattern.


```r
dat %>%
  select(ends_with("ABUSE")) %>%
  head()
#>   PHYABUSE SEXABUSE FAMABUSE STRABUSE ABUSE
#> 1        1        1        1        1     1
#> 2       NA       NA       NA       NA    NA
#> 3       NA       NA       NA       NA    NA
#> 4       NA       NA       NA       NA    NA
#> 5        1        0        1        0     1
#> 6       NA       NA       NA       NA    NA
```

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE 1**</div>
  <div class="panel-body">
Use helper functions to...<br>
  1. Select all columns that start with "sleep".<br>
  2. Select all columns that end with "wt".
  </div>
</div>

### `contains()`

`contains()` selects variables if their name **contains** a specified pattern.


```r
dat %>%
  select(contains("RISK")) %>%
  head()
#>   DRUGRISK SEXRISK
#> 1        0       4
#> 2        0       1
#> 3        0       1
#> 4        0       3
#> 5        0       7
#> 6        0       0
```

This also works on special characters.


```r
dat %>%
  select(contains("_")) %>% 
  select(1:7) %>%
  # Take just the first 7 columns
  # to save space
  head()
#>   NUM_INTERVALS INT_TIME1 DAYS_SINCE_BL INT_TIME2
#> 1             1  0.000000            NA  6.000000
#> 2             1  8.033333           241  8.033333
#> 3             2 15.533333           466  7.500000
#> 4             1 27.566667           827 12.033333
#> 5             1  0.000000            NA  6.000000
#> 6             1  6.366667           191  6.366667
#>   DAYS_SINCE_PREV PREV_TIME A14G_T
#> 1              NA        NA       
#> 2             241         0       
#> 3             225         6       
#> 4             361        18       
#> 5              NA        NA       
#> 6             191         0   JAIL
```

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE 2**</div>
  <div class="panel-body">
Select all columns that contain "re".
  </div>
</div>

### `matches()`

`matches()` works similarly to `contains()` but uses [regular expressions](#regex) (more on these below) rather than patterns.


```r
dat %>%
  select(matches("[[:digit:]]")) %>%
  select(1:7) %>%
  # Take just the first 7 columns
  # to save space
  head()
#>   INT_TIME1 INT_TIME2 A1 A9 A10 A11A A11B
#> 1  0.000000  6.000000  1  9   1    1    0
#> 2  8.033333  8.033333 NA NA   2    1    0
#> 3 15.533333  7.500000 NA NA   1    1    0
#> 4 27.566667 12.033333 NA NA   4    1    0
#> 5  0.000000  6.000000  1 12   6    1    0
#> 6  6.366667  6.366667 NA NA   6    1    0
```

### `num_range()`

`num_range()` matches a series of columns that has a string ending with a numerical range, e.g., x01, x02, x03.


```r
dat %>%
  select(num_range("M", 1:15)) %>%
  head()
#>   M1 M2 M3 M4 M5 M6 M7 M8 M9 M10 M11 M12 M13 M14 M15
#> 1  1  1  1  1  1  1  1  1  1   1   0   1   1   1   1
#> 2  0  1  0  0  1  0  0  0  0   0   0   1   0   0   0
#> 3  0  0  0  0  0  0  0  0  0   0   0   0   0   0   0
#> 4  0  0  0  0  3  0  1  2  0   2   0   2   2   1   0
#> 5  1  1  1  1  1  1  1  1  1   1   1   1   1   1   0
#> 6  1  0  0  0  1  0  0  0  0   0   0   0   0   0   1
```

### `last_col()`

`last_col()` selects the last column in a df. This can be especially helpful when paired with other functions. For example, when positioning columns in mutate or relocate:


```r
dat %>%
  mutate(newRow = "test", .after = last_col()) %>%
  select(last_col()) %>%
  head()
#>   newRow
#> 1   test
#> 2   test
#> 3   test
#> 4   test
#> 5   test
#> 6   test
```

::: {.rmdimportant}
**This creates a new variable after the last column in the df, and then selects the last column (which is now the newly created variable).**
:::

### `all_of()`

`all_of()` matches variable names in a character vector. **All** names must be present, otherwise an error is thrown. In this way, `all_of()` is good when strict selection is needed and an error could have wide ranging consequences.


```r
dat %>%
  select(all_of(c("DRUGRISK", "SEXRISK"))) %>%
  head()
#>   DRUGRISK SEXRISK
#> 1        0       4
#> 2        0       1
#> 3        0       1
#> 4        0       3
#> 5        0       7
#> 6        0       0
```


```r
dat %>%
  select(all_of(c("DRUGRISK", "DRUGRISK2"))) %>%
  head()
#> Error in `select()`:
#> ! Can't subset columns that don't exist.
#> ✖ Column `DRUGRISK2` doesn't exist.
```

::: {.rmdimportant}
**The `DRUGRISK2` variable does not exist in this dataset. Thus, the 2nd code chunk will throw an error.**
:::

### `any_of()`

`any_of()` works the same as `all_of()`, except that **no error is thrown** for names that do not exist. It will only return the columns from the input that are found in the data and ignore the ones that are not.


```r
dat %>%
  select(any_of(c("DRUGRISK", "SEXRISK"))) %>%
  head()
#>   DRUGRISK SEXRISK
#> 1        0       4
#> 2        0       1
#> 3        0       1
#> 4        0       3
#> 5        0       7
#> 6        0       0
dat %>%
  select(any_of(c("DRUGRISK", "DRUGRISK2"))) %>%
  head()
#>   DRUGRISK
#> 1        0
#> 2        0
#> 3        0
#> 4        0
#> 5        0
#> 6        0
```

`any_of()` is particularly useful when removing variables from your df, since there will be no error if you are including a variable that already does not exist. In this way, it can be used to make sure a variable is truly removed.

### `where()`

`where()` takes a function and returns all variables for which the function returns `TRUE`. For example, say you wanted to find how many quantitative variables there are in this df.


```r
dat %>%
  select(where(is.numeric)) %>%
  ncol()
#> [1] 782
```

<p class="text-info"> **Note: We don't <u>call</u> the function by including parentheses after it, we just *NAME* the function.**</p>

<button class="btn btn-primary" data-toggle="collapse" data-target="#BlockName"> How the Syntax Works</button>  
<div id="BlockName" class="collapse">  

Under the hood of `where()`, it just needs a function. This means it can take functions that are designed on the spot. 

The long form version of the code above would be the following:


```r
dat %>%
  select(where(function(x) is.numeric(x))) %>%
  ncol()
#> [1] 782
```

Where you define the function that calls `is.numeric()` inline. A slightly condensed version of this inline defining looks like this:


```r
dat %>%
  select(where(~ is.numeric(.x))) %>%
  ncol()
#> [1] 782
```

You can replace the `function(x)` part with a `~`. Note that you need `.` before the `x` here though! 

This inline shorthand is really useful because it allows you to string multiple functions together using logic statements. For example, you could first select all the abuse columns, then only the columns that are numeric and have a mean larger than 1.


```r
dat %>% 
  drop_na(contains("ABUSE")) %>%
  select(contains("ABUSE")) %>%
  select(where(~ is.numeric(.x) && mean(.x) > 1)) %>%
  head()
#>   ABUSE2 ABUSE3
#> 1      3      2
#> 2      1      1
#> 3      1      1
#> 4      3      2
#> 5      0      0
#> 6      0      0
```

Breaking this down line by line:

- `dat %>%` take the `dat` dataframe
- `drop_na(contains("ABUSE")) %>%` get rid of the `NA` values in all the columns used, because it will mess things up otherwise (note that you can use the selection helper functions here too!).
- `select(contains("ABUSE")) %>%` select only the columns that contain "ABUSE"
- `select(where(~ is.numeric(.x) && mean(.x) > 1)) %>%` select only the columns that are numeric AND have a mean greater than 1
- `head()` show just the first 5 observations

<p class="text-info"> **NOTE: You are not looking for the mean of the column, the output *IS* the column that has a mean greater than 1. Remember, selection helper functions are to help select certain columns. You can just get VERY specific with which columns you want in this way!**</p>
</div>

<br>

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE 3**</div>
  <div class="panel-body">
Use `where()` to select...<br>  
  1. All columns that are *numeric*.<br>
  2. All columns that are *characters*.
  </div>
</div>

### Misc Selecting

Logical operators work as expected and can be used to create tests with multiple helper functions for even more specified selecting!


```r
dat %>%
select(starts_with("RAW") | starts_with("ABUSE")) %>%
  head()
#>   RAWPF RAWRP RAWBP RAWGH RAWVT RAWSF RAWRE RAWMH RAW_RE
#> 1    28     7   9.4  21.4    13     4     4    15     33
#> 2    28     8  10.0  21.4    19     9     6    23     24
#> 3    30     8   8.2  22.4    16    10     6    27     15
#> 4    29     8  10.4  19.0    20    10     6    27     29
#> 5    21     4   8.1   7.0     9     6     3    13     34
#> 6    30     8  12.0  18.4    15     9     5    21     35
#>   RAW_AM RAW_TS RAW_ADS ABUSE2 ABUSE3 ABUSE
#> 1     14     38       5      3      2     1
#> 2     12     33      NA     NA     NA    NA
#> 3      8     36      NA     NA     NA    NA
#> 4     13     37      NA     NA     NA    NA
#> 5      8     30      26      1      1     1
#> 6      7     18      NA     NA     NA    NA
dat %>%
  select(starts_with("A") & ends_with("C")) %>%
  head()
#>   A11C A14C A15C A16C A17C A12B_REC
#> 1    1    0    0    0    0        1
#> 2    1    0    0   NA    0       NA
#> 3    1    0    0   NA    0       NA
#> 4    1    0    0   NA    0       NA
#> 5    1    0   12   49    0        1
#> 6    1    0  178   NA    0       NA
```

Selection helper functions can be negated with a `!`

Below, only the number of columns is shown to save space, but note the difference! 

First look at how many variables there are total:


```r
dat %>% 
  ncol()
#> [1] 788
```

Then see how many there are that start with "RAW":


```r
dat %>%
  select(starts_with("RAW")) %>%
  ncol()
#> [1] 12
```

Then see how many there are after selecting *NOT* the columns that start with "RAW":


```r
dat %>%
  select(!starts_with("RAW")) %>%
  ncol()
#> [1] 776
```

The total number of columns has decreased by exactly the number of columns that start with "RAW"!

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE 4**</div>
  <div class="panel-body">
User helper functions to select the columns that...<br>  
  1. Contain "re" and are *numeric* data.<br>
  2. End with "e" and do not start with "sleep".
  </div>
</div>

## Filtering

There are two `if_*()` functions which apply the same test function to a selection of columns and combine the results into a single logical vector (a vector of `TRUE` and `FALSE`). **Since you are dealing with logical vectors, this is good for *filtering*!**

### `if_any()` 

Returns `TRUE` when the test evaluates to `TRUE` for *any* of the selected columns.


```r
# Show the number of rows and columns in the full df
dim(dat)
#> [1] 1472  788
# Show the number of rows and columns for
# All observations where at least one of the selected
# Variables has a score above 75:
dat %>%
  filter(if_any(starts_with("I") & matches("[[:digit:]]"), ~ . > 75)) %>%
  dim()
#> [1] 625 788
```

<p class="text-info"> **Note: To save space `dim()` was added here. However, without that, it will just output the actual rows of data like any other filter call would.**</p>

Notice how the number of columns (second value) stays the same, but the number of rows (first value) differs!

To break down the unique syntax here:

* It is filtering for observations where any of the columns that start with "I" and also contain a digit in the column name have a score/value greater than 75.

So what is a use case for this? Maybe you have a suicidality questionnaire in your dataset and a participant who responds greater than $X$ on any of the questions needs to be contacted for emergency intervention. There are many questions on your suicidality questionnaire (the columns that start with "I" here), and this is a way to quickly filter for the people who responded with greater than 75 on **ANY** of those questions!

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE 5**</div>
  <div class="panel-body">
  1. Filter for observations where scores in any variable that ends with "wt" is above 35.<br>
  2. Filter for observations where scores in any variable that starts with "sleep" is less than 2.
  </div>
</div>

### `if_all()`

`if_all()` is similar to `if_any()`, except it returns `TRUE` **only** when the test evaluates to `TRUE` for **ALL** of the selected columns.


```r
# Show the number of rows and columns for
# the observations where ALL of the selected
# variables has a score above 75:
dat %>%
  filter(if_all(starts_with("I") & matches("[[:digit:]]"), ~ . > 75)) %>%
  dim()
#> [1]   0 788
```

Importantly, these functions will not give you an error if you do something incorrect (whereas using `select()` would). Since you are dealing with logical vectors and tests, having nothing return is not inherently indicative of a problem! 

Look what happens when we try this on columns that we know do not exist (there are no columns that start with "Y").


```r
dat %>%
  select(starts_with("Y"))
#> data frame with 0 columns and 1472 rows
dat %>%
  filter(if_all(starts_with("Y"), ~ . > 75)) %>%
  dim()
#> [1] 1472  788
```

## Mutating `across()`

`mutate()` was [previously](#Modifying-Existing-Variables) used to make changes to the data in our columns. To do so, you had to specify the specific column you wanted to change and what you wanted to do to it. However, utilizing the `across()` function, you can instead apply some changes to **multiple** columns simultaneously!

From the tidyverse website:

"`across()` makes it easy to apply the same transformation to multiple columns, allowing you to use `select()` semantics (like helper functions) inside "data-masking" functions like `mutate()`. R code in dplyr verbs is generally evaluated once per group. Inside `across()` however, code is evaluated once for each combination of columns and groups!"

For example, you can apply some function/code to specific variables:


```r
dat %>% 
  mutate(across(c("Q2", "Q3"), scale)) %>%
  select(c("Q2", "Q3")) %>%
  head(10)
#>            Q2         Q3
#> 1  -0.3443861 -0.3158289
#> 2  -0.3443861 -0.3158289
#> 3  -0.3443861 -0.3158289
#> 4  -0.3443861 -0.3158289
#> 5  -0.3443861 -0.3158289
#> 6  -0.3443861 -0.3158289
#> 7   2.9017304  5.3304180
#> 8   2.9017304  3.4483357
#> 9   2.9017304  5.3304180
#> 10 -0.3443861 -0.3158289
```

You can use helper functions to make these selections as well!


```r
dat %>% 
  mutate(across(starts_with("Q"), scale)) %>%
  select(starts_with("Q")) %>%
  select(1:7) %>%
  # Take just the first 7 columns
  # to save space
  head(10)
#>           Q1A       Q1B         Q2         Q3         Q4
#> 1   1.3247918 -0.471342 -0.3443861 -0.3158289 -0.2700594
#> 2          NA -0.471342 -0.3443861 -0.3158289 -0.2700594
#> 3          NA -0.471342 -0.3443861 -0.3158289 -0.2700594
#> 4          NA -0.471342 -0.3443861 -0.3158289 -0.2700594
#> 5   1.3247918 -0.471342 -0.3443861 -0.3158289 -0.2700594
#> 6          NA -0.471342 -0.3443861 -0.3158289 -0.2700594
#> 7   1.3247918  2.120156  2.9017304  5.3304180  1.4294526
#> 8          NA  2.120156  2.9017304  3.4483357  4.8284766
#> 9          NA  2.120156  2.9017304  5.3304180 -0.2700594
#> 10 -0.7532261 -0.471342 -0.3443861 -0.3158289 -0.2700594
#>            Q5         Q6
#> 1   1.3360441 -0.2731168
#> 2  -0.6042744 -0.2731168
#> 3  -0.6042744 -0.2731168
#> 4  -0.6042744 -0.2731168
#> 5   2.3062033 -0.2731168
#> 6  -0.6042744 -0.2731168
#> 7  -0.6042744  4.9244139
#> 8   0.3658848 -0.2731168
#> 9  -0.6042744  4.9244139
#> 10 -0.6042744 -0.2731168
```

You can combine `where()` with `across()` to mutate conditionally. In other words, **IF** the column passes some test, the function will be applied to all its values.

Consider the following scenario: say you wanted to convert all the *factors* to *characters*.

First, you would check which columns contain *factors*:


```r
dat %>%
  select(where(is.factor)) %>%
  glimpse()
#> Rows: 1,472
#> Columns: 6
#> $ A14G_T <fct> "", "", "", "", "", "JAIL", "", "JAIL", "",…
#> $ A17I_T <fct> , , , , , , , , FOOD STAMPS, , , , , , , , …
#> $ C3F_T  <fct> "", "", "", "", "", "", "", "", "", "", "",…
#> $ U2Q_T  <fct> "", "", "", "", "", "", "", "", "NO NEED TO…
#> $ U2R    <fct> , A, A, A, , H, , H, Q, , A, H, P, , H, D, …
#> $ U7A_T  <fct> "", "", "", "", "", "", "", "", "", "", "",…
```

Next, you can use `across()` and `where()` to change only columns that are *factors* into *characters*, checking which columns are *characters*. The columns that were previously *factors* should show up here.


```r
dat %>% 
  mutate(across(where(is.factor), as.character)) %>%
  select(where(is.character)) %>%
  glimpse()
#> Rows: 1,472
#> Columns: 6
#> $ A14G_T <chr> "", "", "", "", "", "JAIL", "", "JAIL", "",…
#> $ A17I_T <chr> "", "", "", "", "", "", "", "", "FOOD STAMP…
#> $ C3F_T  <chr> "", "", "", "", "", "", "", "", "", "", "",…
#> $ U2Q_T  <chr> "", "", "", "", "", "", "", "", "NO NEED TO…
#> $ U2R    <chr> "", "A", "A", "A", "", "H", "", "H", "Q", "…
#> $ U7A_T  <chr> "", "", "", "", "", "", "", "", "", "", "",…
```
  
Which they do!

You also can apply multiple functions by `list`ing them. For example:


```r
dat %>%
  select(starts_with("Z")) %>%
  mutate(across(where(is.numeric), list(log, round))) %>%
  head()
#>    Z1  Z2     Z1_1 Z1_2     Z2_1 Z2_2
#> 1  NA  NA       NA   NA       NA   NA
#> 2   0  NA     -Inf    0       NA   NA
#> 3   0  NA     -Inf    0       NA   NA
#> 4 999 999 6.906755  999 6.906755  999
#> 5  NA  NA       NA   NA       NA   NA
#> 6 999 999 6.906755  999 6.906755  999
```

As before, multiple helper functions can be strung together and they can also be negated with `!`. 

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE 6**</div>
  <div class="panel-body">
Use helper functions to...<br>
  1. Round all the columns that are *numeric*.<br>
  2. Round only the columns that are *numeric* and start with "sleep".<br>
  3. `scale()` the columns that end with "wt" and are *numeric*, then filter the results for only those where all columns that end with "wt" are greater than 0.
  </div>
</div>

## Regular Expressions {#regex}

Regular expressions (regex) are a way to select certain *kinds* of characters. When you want to refer to a class/type of character, you can select them with a regex.

Regular expressions all get wrapped in brackets. So, to use any of these, wrap them in brackets. (i.e., they need double brackets in practice!):

- **[:punct:]** - punctuation.
- **[:alpha:]** - letters.
- **[:lower:]** - lowercase letters.
- **[:upper:]** - upperclass letters.
- **[:digit:]** - digits.
- **[:xdigit:]** - hex digits.
- **[:alnum:]** - letters and numbers.
- **[:cntrl:]** - control characters.
- **[:graph:]** - letters, numbers, and punctuation.
- **[:print:]** - letters, numbers, punctuation, and whitespace.
- **[:space:]** - space characters (basically equivalent to `\s`).
- **[:blank:]** - space and tab.

## Extra Resources

* [Select Vignette](https://dplyr.tidyverse.org/reference/select.html)


