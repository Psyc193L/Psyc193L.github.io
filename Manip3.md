# Advanced Wrangling




```r
library(tidyverse) # Load tidyverse packages
```

<a href="Exercise_Manip3.Rmd" download>Exercise Sheet</a>

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
  head()
#>   NUM_INTERVALS INT_TIME1 DAYS_SINCE_BL INT_TIME2
#> 1             1  0.000000            NA  6.000000
#> 2             1  8.033333           241  8.033333
#> 3             2 15.533333           466  7.500000
#> 4             1 27.566667           827 12.033333
#> 5             1  0.000000            NA  6.000000
#> 6             1  6.366667           191  6.366667
#>   DAYS_SINCE_PREV PREV_TIME A14G_T A17I_T C3F_T C3K_M
#> 1              NA        NA                        NA
#> 2             241         0                        NA
#> 3             225         6                        NA
#> 4             361        18                        NA
#> 5              NA        NA                        NA
#> 6             191         0   JAIL                 NA
#>   G1A_30 G1B_30 G1C_30 G1D_30 H1_30 H1_LT H1_RT H2_30 H2_LT
#> 1      1      1      0      1     5    29     1     5    20
#> 2     NA     NA     NA      0     0    NA     0     0    NA
#> 3     NA     NA     NA     NA     0    NA     0     0    NA
#> 4     NA     NA     NA     NA     8    NA     1     8    NA
#> 5      1      0     NA     NA    30    26     1    30    26
#> 6     NA     NA     NA     NA     5    NA     1     5    NA
#>   H2_RT H3_30 H3_LT H3_RT H4_30 H4_LT H4_RT H5_30 H5_LT
#> 1     1     0     0     0     0     0     0     0     0
#> 2     0     0    NA     0     0    NA     0     0    NA
#> 3     0     0    NA     0     0    NA     0     0    NA
#> 4     1     0    NA     0     0    NA     0     0    NA
#> 5     1     0     0     0     0     0     0    15     1
#> 6     1     0    NA     0     0    NA     0     0    NA
#>   H5_RT H6_30 H6_LT H6_RT H7_30 H7_LT H7_RT H8_30 H8_LT
#> 1     0     0     0     0    30     2     1     5    10
#> 2     0     0    NA     0     0    NA     0     0    NA
#> 3     0     0    NA     0     0    NA     0     0    NA
#> 4     0     0    NA     0     0    NA     0     3    NA
#> 5     1     0     0     0    30     1     1    30    21
#> 6     0     0    NA     0     0    NA     0     0    NA
#>   H8_RT H9_30 H9_LT H9_RT H10_30 H10_LT H10_RT H11_30
#> 1     3     0     0     0      0     12      3      0
#> 2     0     0    NA     0      0     NA      0      0
#> 3     0     0    NA     0      0     NA      0      0
#> 4     3     0    NA     0      0     NA      0      0
#> 5     3     1     1     1      0      8      3      0
#> 6     0     0    NA     0      0     NA      0      0
#>   H11_LT H11_RT H12_30 H12_LT H12_RT H13_30 H13_LT H13_RT
#> 1      5      3      0      0      0      5     20      3
#> 2     NA      0      0     NA      0      0     NA      0
#> 3     NA      0      0     NA      0      0     NA      0
#> 4     NA      0      0     NA      0      3     NA      3
#> 5      9      1      0      0      0     30     24      3
#> 6     NA      0      0     NA      0      0     NA      0
#>   U2Q_T PCP_ID U7A_T U32D_T E16A_RT E16A_IB E16A_TM E16A_DD
#> 1           NA           NA       0       0       0       0
#> 2          108           NA      NA      NA      NA      NA
#> 3          176           NA      NA      NA      NA      NA
#> 4           NA           NA      NA      NA      NA      NA
#> 5           NA           NA       0       0       0       0
#> 6           71           NA      NA      NA      NA      NA
#>   PRIM_SUB SECD_SUB COC_HER MD_LANG HS_GRAD MAR_STAT
#> 1        2        1       1       0       0        0
#> 2       NA       NA      NA      NA      NA       NA
#> 3       NA       NA      NA      NA      NA       NA
#> 4       NA       NA      NA      NA      NA       NA
#> 5        1        2       1       0       1        1
#> 6       NA       NA      NA      NA      NA       NA
#>   A12B_REC JAIL_MOS JAIL_5YR GOV_SUPP A18_REC1 A18_REC2
#> 1        1        0        0       NA        0    15000
#> 2       NA       NA       NA        0       NA       NA
#> 3       NA       NA       NA        0       NA       NA
#> 4       NA       NA       NA        0       NA       NA
#> 5        1       49        1        0        0     7500
#> 6       NA       NA       NA        0       NA       NA
#>   STD_EVER STD_6M CHR_SUM CHR_EVER EPI_SUM EPI_6M EPI_6M2B
#> 1        1      0       1        1       1      1        1
#> 2       NA      0       1       NA       0      0        0
#> 3       NA      0       0       NA       0      0        0
#> 4       NA      0       0       NA       1      1        1
#> 5        0      0       3        1       4      1        1
#> 6       NA      0       1       NA       0      0        0
#>   SER_INJ D3_REC D4_REC D5_REC ANY_INS FRML_SAT E10B1_R
#> 1       0      1      1      1       1        1       1
#> 2       0      0      0      0       0        0       0
#> 3       0      1      1      1       0        0       0
#> 4       0      1      1      1       0        0       0
#> 5       1      1      0      1       0        0       0
#> 6       0      1      1      0       0        0       0
#>   E10B2_R ALT_TRT ANY_UTIL NUM_BARR G1B_REC G1D_REC ALCQ_30
#> 1       0       0        1        3       1       1      65
#> 2       1       0        1       NA       0       0       0
#> 3       1       0        1       NA       0       0       0
#> 4       0       0        1       NA       0       0      64
#> 5       0       0        1        3       0       0    1680
#> 6       0       0        0       NA       0       0      40
#>   H2_PRB H3_PRB H4_PRB H5_PRB H6_PRB H7_PRB H8_PRB H9_PRB
#> 1      1      0      0      0      0      1      1      0
#> 2      0      0      0      0      0      0      0      0
#> 3      0      0      0      0      0      0      0      0
#> 4      1      0      0      0      0      0      0      0
#> 5      1      0      0      1      0      1      1      1
#> 6      1      0      0      0      0      0      0      0
#>   H10_PRB H11_PRB H12_PRB O1B_REC O1C_REC O1D_REC O2_REC
#> 1       1       1       0       1       1       1      0
#> 2       0       0       0       0       0       1      0
#> 3       0       0       0       0       0       1      0
#> 4       0       0       0       1       1       1      0
#> 5       1       1       0       1       1       0      0
#> 6       0       0       0       1       1       0      0
#>   CES_D CESD_CUT      C_MS       C_AU      C_DU CUAD_C
#> 1    49        1 0.4611111 0.40252703 0.2282051      3
#> 2     7        0 0.0000000 0.00000000 0.1730769     NA
#> 3     8        0 0.5722222 0.23055556 0.1064103     NA
#> 4     5        0 0.4944444 0.51565117 0.1692308     NA
#> 5    30        1 0.6666667 0.89542261 0.2717949      3
#> 6    11        0 0.2000000 0.05555556 0.0000000     NA
#>   CUAD_H RAW_RE DEC_RE RAW_AM DEC_AM RAW_TS DEC_TS RAW_ADS
#> 1      0     33     50     14     40     38     80       5
#> 2     NA     24     10     12     30     33     50      NA
#> 3     NA     15     10      8     10     36     70      NA
#> 4     NA     29     30     13     30     37     80      NA
#> 5      0     34     60      8     10     30     30      26
#> 6     NA     35     70      7     10     18     10      NA
#>   PSS_FR PSS_FA CHR_6M RCT_LINK REG_MD ANY_VIS
#> 1      0      0     NA       NA     NA      NA
#> 2     12     10      1        1      1       1
#> 3     14      3      0        1      1       1
#> 4     13      7      0        0      0       0
#> 5      1      3     NA       NA     NA      NA
#> 6      2      1      1        0      1       0
#>   ANY_VIS_CUMUL PC_REC PC_REC7
#> 1            NA     NA      NA
#> 2             1      1       1
#> 3             2      2       2
#> 4             2      2       2
#> 5            NA     NA      NA
#> 6             0      0       0
```

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE 2**</div>
  <div class="panel-body">
Select all columns that contain "re".
  </div>
</div>

### `matches()`

`matches()` works similarly to `contains()` but uses regular expressions (more on these below) rather than patterns.


```r
dat %>%
  select(matches("[[:digit:]]")) %>%
  head()
#>   INT_TIME1 INT_TIME2 A1 A9 A10 A11A A11B A11C A11D A11E
#> 1  0.000000  6.000000  1  9   1    1    0    1    1    1
#> 2  8.033333  8.033333 NA NA   2    1    0    1    1    1
#> 3 15.533333  7.500000 NA NA   1    1    0    1    1    1
#> 4 27.566667 12.033333 NA NA   4    1    0    1    1    1
#> 5  0.000000  6.000000  1 12   6    1    0    1    0    1
#> 6  6.366667  6.366667 NA NA   6    1    0    1    0    1
#>   A12B A13 A14A A14B A14C A14D A14E A14F A14G A14G_T A15A
#> 1    6   1    0    1    0    1    0    0    0           0
#> 2   NA   2    0    1    0    1    0    0    0           0
#> 3   NA   1    0    1    0    1    0    0    0           0
#> 4   NA   1    0    1    0    0    0    0    0          90
#> 5    6   4    1    0    0    0    0    0    0           2
#> 6   NA   5    0    0    0    0    0    0    1   JAIL    1
#>   A15B A15C A16A A16B A16C A17A A17B A17C A17D A17E A17F
#> 1    0    0    0    0    0    0    0    0    0   NA    0
#> 2    0    0   NA   NA   NA    0    0    0    0    0    0
#> 3    0    0   NA   NA   NA    0    0    0    0    0    0
#> 4    0    0   NA   NA   NA    0    0    0    0    0    0
#> 5    3   12    0    0   49    0    0    0    0    0    0
#> 6    0  178   NA   NA   NA    0    0    0    0    0    0
#>   A17G A17H A17I A17I_T A18 B1 B2 B3A B3B B3C B3D B3E B3F
#> 1    0    0   NA          3  3  3   2   3   3   3   3   2
#> 2    0    0    0         NA  3  1   2   3   3   2   3   3
#> 3    0    0    0         NA  2  1   3   3   3   3   3   3
#> 4    0    0    0         NA  5  4   3   3   3   3   3   3
#> 5    0    0   NA          2  4  4   1   3   3   1   3   1
#> 6    0    0    0         NA  3  3   3   3   3   3   3   3
#>   B3G B3H B3I B3J B4A B4B B4C B4D B5A B5B B5C B6 B7 B8 B9A
#> 1   3   3   3   3   0   0   0   1   0   1   1  4  2  2   2
#> 2   3   3   3   3   0   0   0   0   0   0   0  1  1  2   2
#> 3   3   3   3   3   0   0   0   0   0   0   0  1  3  2   2
#> 4   2   3   3   3   0   0   0   0   0   0   0  1  2  1   1
#> 5   1   2   3   3   1   1   1   1   1   1   1  1  4  1   6
#> 6   3   3   3   3   0   0   0   0   1   0   0  1  1  1   4
#>   B9B B9C B9D B9E B9F B9G B9H B9I B10 B11A B11B B11C B11D
#> 1   4   3   5   4   4   3   5   2   2    5    2    5    2
#> 2   5   5   3   2   5   4   3   5   4    5    2    5    2
#> 3   6   6   2   4   5   4   2   4   5    5    2    5    2
#> 4   5   6   3   2   6   4   1   5   5    5    2    5    2
#> 5   6   2   6   6   3   3   6   4   1    2    5    1    5
#> 6   6   5   4   3   3   4   3   4   4    5    5    5    2
#>   C1A C1B C1C C1D C1E C1F C1G C1H C1I C1J C1K C1L C1M C2A1
#> 1   0   1   0   0   0   0   0   0   0   0   0   0   0    0
#> 2   0   1   0   0   0   0   0   0   0   0   0   0   0   NA
#> 3   0   0   0   0   0   0   0   0   0   0   0   0   0   NA
#> 4   0   0   0   0   0   0   0   0   0   0   0   0   0   NA
#> 5   0   1   0   0   0   1   1   0   0   0   0   0   0    0
#> 6   0   0   0   0   0   1   0   0   0   0   0   0   0   NA
#>   C2A2 C2B1 C2B2 C2C1 C2C2 C2D1 C2D2 C2E1 C2E2 C2F1 C2F2
#> 1   NA    1    0    0   NA    0   NA    0   NA    0   NA
#> 2    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 3    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 4    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 5   NA    1    0    0   NA    0   NA    0   NA    0   NA
#> 6    0   NA    0   NA    0   NA    0   NA    0   NA    0
#>   C2G1 C2G2 C2H1 C2H2 C2I1 C2I2 C2J1 C2J2 C2K1 C2K2 C2L1
#> 1    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 2   NA    0   NA    0   NA    0   NA    0   NA    0   NA
#> 3   NA    0   NA    0   NA    0   NA    0   NA    0   NA
#> 4   NA    0   NA    1   NA    0   NA    0   NA    0   NA
#> 5    0   NA    0   NA    0   NA    1    1    0   NA    0
#> 6   NA    0   NA    0   NA    0   NA    0   NA    0   NA
#>   C2L2 C2M1 C2M2 C2N1 C2N2 C2O1 C2O2 C2P1 C2P2 C2Q1 C2Q2
#> 1   NA    0   NA    0   NA    1    1    0   NA    0   NA
#> 2    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 3    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 4    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 5   NA    0   NA    0   NA    1    1    0   NA    1    0
#> 6    0   NA    0   NA    0   NA    0   NA    0   NA    0
#>   C2R1 C2R2 C2S1 C2S2 C2T1 C2T2 C2U1 C2U2 C2V1 C2V2 C2W1
#> 1    0   NA    0   NA    0   NA    0   NA    0   NA    0
#> 2   NA    0   NA    0   NA    0   NA    0   NA    0   NA
#> 3   NA    0   NA    0   NA    0   NA    0   NA    0   NA
#> 4   NA    0   NA    0   NA    0   NA    0   NA    0   NA
#> 5    0   NA    1    0    1    1    1    1    0   NA    1
#> 6   NA    0   NA    0   NA    0   NA    0   NA    0   NA
#>   C2W2 C3A1 C3A2 C3A3 C3B1 C3B2 C3B3 C3C1 C3C2 C3C3 C3D C3E
#> 1   NA    0   NA   NA    1    2    0    0   NA   NA   0   0
#> 2    0    0   NA   NA    0   NA   NA    0   NA   NA   0   0
#> 3    0    0   NA   NA    0   NA   NA    0   NA   NA   0   0
#> 4    0    0   NA   NA    0   NA   NA    0   NA   NA   0   0
#> 5    1    0   NA   NA    0   NA   NA    0   NA   NA   0   0
#> 6    0    0   NA   NA    0   NA   NA    0   NA   NA   0   0
#>   C3F1 C3F2 C3F3 C3F_T C3G1 C3G2 C3G3 C3G4 C3H1 C3H2 C3H3
#> 1    0   NA   NA          1    3    0    2   NA   NA   NA
#> 2    0   NA   NA          0   NA   NA   NA   NA   NA   NA
#> 3    0   NA   NA          0   NA   NA   NA   NA   NA   NA
#> 4    0   NA   NA          0   NA   NA   NA   NA   NA   NA
#> 5    0   NA   NA          1    8    1    2   NA   NA   NA
#> 6    0   NA   NA          1    1   NA    2   NA   NA   NA
#>   C3I C3J C3K C3K_M D1 D2 D3 D4 D5 E2A E2B E2C E3A E3B E3C
#> 1  NA  NA  NA    NA  3  0  4  1  4   0  NA  NA   0  NA  NA
#> 2  NA  NA  NA    NA NA  0  0  0  0   0  NA  NA   0  NA  NA
#> 3  NA  NA  NA    NA NA  1 14  1  4   0  NA  NA   0  NA  NA
#> 4  NA  NA  NA    NA NA  0  7  1  4   0  NA  NA   0  NA  NA
#> 5  NA  NA  NA    NA 22  1 30  0  4   0  NA  NA   0  NA  NA
#> 6  NA  NA  NA    NA NA  1  3  2  0   0  NA  NA   0  NA  NA
#>   E4A E4B E4C E5A E5B E6 E7A E7B E8A1 E8A2 E8A3 E8A4 E9A
#> 1   0  NA  NA   0  NA  0   1  18    1    0    0    0   1
#> 2   0  NA  NA   0  NA  0   0  NA    0    0    0    0   1
#> 3   0  NA  NA   0  NA  0   0  NA    0    0    0    0   1
#> 4   0  NA  NA   0  NA  0   0  NA    0    0    0    0   1
#> 5   0  NA  NA   0  NA  0   0  NA    0    1    0    0   0
#> 6   0  NA  NA   0  NA  0   0  NA    0    0    0    0   1
#>   E9B E10A E10B1 E10B2 E10C19 E11A E11B E11C E12A E12B E13
#> 1   3    1    12     0      0    0   NA   NA    0   NA   1
#> 2   2    1     0     1      0    0   NA   NA    0   NA   0
#> 3   3    1     0     1      0    0   NA   NA    0   NA   0
#> 4   5    0    NA    NA     NA    1    1    4    0   NA   0
#> 5  NA    0    NA    NA     NA    1    1    7    1    1   0
#> 6   3    0    NA    NA     NA    0   NA   NA    0   NA   0
#>   E14A E14B E14C E14D E14E E14F E14G E15A E15B E15C1 E15C2
#> 1    0    0    0    0    0    0    0    0   NA    NA    NA
#> 2    0    0    0    0    0    0    0   NA   NA    NA    NA
#> 3    0    0    0    0    0    0    0   NA   NA    NA    NA
#> 4    0    0    0    0    0    0    0   NA   NA    NA    NA
#> 5    0    0    0    0    0    0    0    0   NA    NA    NA
#> 6    0    0    0    0    0    0    0   NA   NA    NA    NA
#>   E15C3 E15C4 E15C5 E15C6 E15C7 E15C8 E15C9 E15C10 E15C11
#> 1    NA    NA    NA    NA    NA    NA    NA     NA     NA
#> 2    NA    NA    NA    NA    NA    NA    NA     NA     NA
#> 3    NA    NA    NA    NA    NA    NA    NA     NA     NA
#> 4    NA    NA    NA    NA    NA    NA    NA     NA     NA
#> 5    NA    NA    NA    NA    NA    NA    NA     NA     NA
#> 6    NA    NA    NA    NA    NA    NA    NA     NA     NA
#>   E15C12 E16A1 E16A2 E16A3 E16A4 E16A5 E16A6 E16A7 E16A8
#> 1     NA     1     0     1     0     1     0     0     0
#> 2     NA    NA    NA    NA    NA    NA    NA    NA    NA
#> 3     NA    NA    NA    NA    NA    NA    NA    NA    NA
#> 4     NA    NA    NA    NA    NA    NA    NA    NA    NA
#> 5     NA     1     0     0     1     0     0     0     1
#> 6     NA    NA    NA    NA    NA    NA    NA    NA    NA
#>   E16A9 E16A10 E16A11 E16A12 E16A13 E18A E18B E18C E18D
#> 1     0      0      0      0      0   NA   NA   NA   NA
#> 2    NA     NA     NA     NA     NA    1    0    0    1
#> 3    NA     NA     NA     NA     NA    0    0    0    0
#> 4    NA     NA     NA     NA     NA    0    0    0    0
#> 5     0      0      0      0      0   NA   NA   NA   NA
#> 6    NA     NA     NA     NA     NA    0    0    0    0
#>   E18F E18G E18H E18I E18J E18K E18L E18M F1A F1B F1C F1D
#> 1   NA   NA   NA   NA   NA   NA   NA   NA   3   2   3   0
#> 2    0    0    0    0    0    0    0    0   0   0   0   3
#> 3    0    0    0    0    0    0    1    0   0   0   0   3
#> 4    0    0    0    0    0    0    0    0   3   1   0   3
#> 5   NA   NA   NA   NA   NA   NA   NA   NA   3   2   0   3
#> 6    0    1    0    0    0    0    0    1   0   0   0   3
#>   F1E F1F F1G F1H F1I F1J F1K F1L F1M F1N F1O F1P F1Q F1R
#> 1   2   3   3   0   2   3   3   0   1   2   2   2   2   3
#> 2   0   0   0   3   0   1   2   3   2   0   0   3   0   1
#> 3   2   0   0   3   0   1   2   3   1   0   1   2   0   0
#> 4   0   0   0   3   0   0   1   3   0   0   0   3   0   0
#> 5   3   2   0   0   3   0   3   0   0   3   0   0   0   2
#> 6   0   0   0   2   2   0   1   2   0   3   0   0   0   0
#>   F1S F1T G1A G1A_30 G1B G1B_30 G1C G1C_30 G1D G1D_30 H1_30
#> 1   3   2   1      1   1      1   1      0   1      1     5
#> 2   1   0   0     NA   0     NA   0     NA   1      0     0
#> 3   0   0   0     NA   0     NA   0     NA   0     NA     0
#> 4   0   0   0     NA   0     NA   0     NA   0     NA     8
#> 5   0   0   1      1   1      0   0     NA   0     NA    30
#> 6   0   0   0     NA   0     NA   0     NA   0     NA     5
#>   H1_LT H1_RT H2_30 H2_LT H2_RT H3_30 H3_LT H3_RT H4_30
#> 1    29     1     5    20     1     0     0     0     0
#> 2    NA     0     0    NA     0     0    NA     0     0
#> 3    NA     0     0    NA     0     0    NA     0     0
#> 4    NA     1     8    NA     1     0    NA     0     0
#> 5    26     1    30    26     1     0     0     0     0
#> 6    NA     1     5    NA     1     0    NA     0     0
#>   H4_LT H4_RT H5_30 H5_LT H5_RT H6_30 H6_LT H6_RT H7_30
#> 1     0     0     0     0     0     0     0     0    30
#> 2    NA     0     0    NA     0     0    NA     0     0
#> 3    NA     0     0    NA     0     0    NA     0     0
#> 4    NA     0     0    NA     0     0    NA     0     0
#> 5     0     0    15     1     1     0     0     0    30
#> 6    NA     0     0    NA     0     0    NA     0     0
#>   H7_LT H7_RT H8_30 H8_LT H8_RT H9_30 H9_LT H9_RT H10_30
#> 1     2     1     5    10     3     0     0     0      0
#> 2    NA     0     0    NA     0     0    NA     0      0
#> 3    NA     0     0    NA     0     0    NA     0      0
#> 4    NA     0     3    NA     3     0    NA     0      0
#> 5     1     1    30    21     3     1     1     1      0
#> 6    NA     0     0    NA     0     0    NA     0      0
#>   H10_LT H10_RT H11_30 H11_LT H11_RT H12_30 H12_LT H12_RT
#> 1     12      3      0      5      3      0      0      0
#> 2     NA      0      0     NA      0      0     NA      0
#> 3     NA      0      0     NA      0      0     NA      0
#> 4     NA      0      0     NA      0      0     NA      0
#> 5      8      3      0      9      1      0      0      0
#> 6     NA      0      0     NA      0      0     NA      0
#>   H13_30 H13_LT H13_RT H14 H15A H15B H16A H16B H17A H17B
#> 1      5     20      3  15    0    0   20  600    5    4
#> 2      0     NA      0  NA    0    0    0    0    0   30
#> 3      0     NA      0  NA    0    0    0    0    4    4
#> 4      3     NA      3  NA    0    0   60  150   15   15
#> 5     30     24      3  15    0    0  600 2000   30    0
#> 6      0     NA      0  NA    0    0    0    0    0    0
#>   H18A H18B H19A H19B I1 I2 I3 I4 I5 I6A I6B I7A I7B  I8 J1
#> 1    2    2    4    4 13 26 NA NA NA   0   3   0  30 150  1
#> 2    0    1    0    4 NA NA NA NA NA  NA  NA  NA  NA  NA NA
#> 3    1    1    4    4 NA NA NA NA NA  NA  NA  NA  NA  NA NA
#> 4    2    2    4    4  8  8 NA NA NA  NA  NA  NA  NA 120 NA
#> 5    3    0    3    0 56 62 NA NA NA   3   8  12  NA 500  1
#> 6    0    0    0    0  8  8 NA NA NA  NA  NA  NA  NA  NA NA
#>   J2 J3 J4 J5A J5B J6 J7 J8 J9 J10A J10B K1 K2 K3 L1 L2 L3
#> 1  1  1  0   0  NA NA NA NA NA   NA   NA  1 12  1  2  0  0
#> 2 NA NA NA  NA  NA NA NA NA NA   NA   NA  1 10  1 NA NA NA
#> 3 NA NA NA  NA  NA NA NA NA NA   NA   NA  1  8  1 NA NA NA
#> 4 NA NA NA  NA  NA NA NA NA NA   NA   NA  1 10  1 NA NA NA
#> 5  0  1  1   0  NA NA NA NA NA   NA   NA  1 20  0  2  0  2
#> 6 NA NA NA  NA  NA NA NA NA NA   NA   NA  2  1  0 NA NA NA
#>   L4 L5 L6 L7 L8 L9 L10 L11 L12 L13 L14 L15 L16 L17 L18 L19
#> 1  0  0  0  0  0  0   0   0   0   0   0   0   1   0   0   0
#> 2 NA NA NA NA NA NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
#> 3 NA NA NA NA NA NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
#> 4 NA NA NA NA NA NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
#> 5  2  0  0  2  0  1   1   2   2   2   0   1   1   2   1   0
#> 6 NA NA NA NA NA NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
#>   L20 L21 L22 L23 L24 L25 M1 M2 M3 M4 M5 M6 M7 M8 M9 M10
#> 1   0   0   0   0   1   0  1  1  1  1  1  1  1  1  1   1
#> 2  NA  NA  NA  NA  NA  NA  0  1  0  0  1  0  0  0  0   0
#> 3  NA  NA  NA  NA  NA  NA  0  0  0  0  0  0  0  0  0   0
#> 4  NA  NA  NA  NA  NA  NA  0  0  0  0  3  0  1  2  0   2
#> 5   0   0   1   2   1   0  1  1  1  1  1  1  1  1  1   1
#> 6  NA  NA  NA  NA  NA  NA  1  0  0  0  1  0  0  0  0   0
#>   M11 M12 M13 M14 M15 M16 M17 M18 M19 M20 M21 M22 M23 M24
#> 1   0   1   1   1   1   1   1   1   1   1   1   1   0   1
#> 2   0   1   0   0   0   1   0   0   0   0   0   0   0   0
#> 3   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> 4   0   2   2   1   0   3   2   0   0   0   0   1   0   1
#> 5   1   1   1   1   0   1   1   1   1   1   1   1   1   1
#> 6   0   0   0   0   1   0   0   1   1   1   1   1   0   0
#>   M25 M26 M27 M28 M29 M30 M31 M32 M33 M34 M35 M36 M37 M38
#> 1   0   1   1   1   1   1   1   1   1   1   0   1   1   1
#> 2   0   0   0   1   0   0   0   0   0   0   0   1   0   0
#> 3   0   0   0   0   0   0   0   0   0   0   0   0   0   0
#> 4   0   1   1   3   2   3   2   0   0   0   0   2   2   0
#> 5   1   1   1   1   1   1   1   1   1   1   1   1   1   1
#> 6   0   0   0   0   0   0   0   3   3   0   0   0   0   0
#>   M39 M40 M41 M42 M43 M44 M45 M46 M47 M48 M49 M50 N1A N1B
#> 1   1   1   0   0   1   1   0   1   1   0   0   1   7   1
#> 2   0   0   0   0   0   0   0   0   0   0   0   0   1   0
#> 3   0   0   0   0   0   0   0   0   0   0   0   0   1   0
#> 4   0   1   0   0   0   0   3   0   0   0   0   0   1   0
#> 5   1   1   0   1   1   1   0   1   0   1   1   1   0   1
#> 6   0   0   0   0   0   0   0   0   0   0   0   0   0   1
#>   N1C N1D N1E N1F N1G N1H N1I N1J N1K N1L N1M N1N N2A N2B
#> 1   0   0   0   0   0   0   0   1   0   1   0   1   0   0
#> 2   1   1   1   1   1   1   0   0   0   0   1   0   1   1
#> 3   1   1   1   1   1   1   1   0   1   0   1   0   1   0
#> 4   0   1   1   1   1   1   1   0   1   0   1   0   1   0
#> 5   0   0   0   0   0   0   0   0   0   1   0   1   0   0
#> 6   0   0   0   0   0   0   0   1   0   0   0   0   0   0
#>   N2C N2D N2E N2F N2G N2H N2I N2J N2K N2L N2M N2N O1A O1B
#> 1   1   1   0   0   0   0   0   0   0   0   1   1   2   2
#> 2   0   0   7   1   1   1   7   1   1   0   1   0   1   1
#> 3   1   1   0   0   1   1   0   0   0   0   1   1   1   1
#> 4   0   0   0   1   7   1   1   0   0   0   1   0   2   2
#> 5   1   0   0   0   0   1   0   0   0   0   0   1   5   5
#> 6   1   1   0   0   0   0   0   0   0   0   0   1   5   5
#>   O1C O1D O2 P1A P1B P1C P2A P2B P2C P3 P4 P5A P5B P5C P6A
#> 1   2   2  0   1   7   1   1  11   0  2  1   1  11   0   1
#> 2   1   5  0  NA  NA   0  NA  NA   0 NA NA  NA  NA   0  NA
#> 3   1   5  0  NA  NA   0  NA  NA   0 NA NA  NA  NA   0  NA
#> 4   2   4  0  NA  NA   0  NA  NA   0 NA NA  NA  NA   0  NA
#> 5   5   1  2   1   5   0   0  NA  NA  2  1   0  NA  NA   0
#> 6   4   1  2  NA  NA   0  NA  NA   0 NA NA  NA  NA   0  NA
#>   P6B P6C P7 P8 Q1A Q1B Q2 Q3 Q4 Q5 Q6 Q7 Q8 Q9 Q10 Q11 Q12
#> 1  11   0  2  1   1   0  0  0  0  2  0  0  0  0   0   0   1
#> 2  NA   0 NA NA  NA   0  0  0  0  0  0  0  0  0   0   0   1
#> 3  NA   0 NA NA  NA   0  0  0  0  0  0  0  0  0   0   0   1
#> 4  NA   0 NA NA  NA   0  0  0  0  0  0  0  0  0   0   0   2
#> 5  NA  NA NA NA   1   0  0  0  0  3  0  0  0  0   0   0   1
#> 6  NA   0 NA NA  NA   0  0  0  0  0  0  0  0  0   0   0   0
#>   Q13 Q14 Q15 Q16 Q17 Q18 Q19 Q20 R1A R1B R1C R1D R1E R1F
#> 1   1   0   1   0   1   0   1   4   5   4   5   4   4   3
#> 2   2   0   0   0   0   0   1   3   1   1   1   1   4   4
#> 3   2   0   0   0   0   0   1   4   1   2   1   1   5   3
#> 4   3   0   0   0   0   1   2   4   5   4   5   5   4   4
#> 5   1   0   0   0   0   3   4   3   5   1   5   4   1   5
#> 6   0   0   0   0   0   0   4   4   5   1   5   1   2   2
#>   R1G R1H R1I R1J R1K R1L R1M R1N R1O R1P R1Q R1R R1S S1A
#> 1   5   5   5   5   3   5   5   5   4   4   4   5   5   1
#> 2   5   5   5   4   2   5   4   5   4   5   4   5   4   0
#> 3   1   5   5   1   1   1   5   5   5   2   5   5   5   0
#> 4   3   4   5   4   1   4   5   5   4   4   4   4   5   0
#> 5   5   4   4   4   1   5   4   5   5   1   5   4   4   0
#> 6   5   2   2   5   2   5   2   5   5   2   5   2   2   0
#>   S1B S1C S1D S1E S1F T1 T1B T1C T2 T2B T2C T3 T3B T3C U1
#> 1   0   0   0   0   1 NA  NA  NA NA  NA  NA NA  NA  NA NA
#> 2   0   0   0   0   0  1   1 176  0  NA  NA  0  NA  NA  2
#> 3   0   0   0   0   0  0  NA  NA  0  NA  NA  0  NA  NA  1
#> 4   0   0   0   1   0  1  NA 135  0  NA  NA  1  NA 135  1
#> 5   0   0   0   0   0 NA  NA  NA NA  NA  NA NA  NA  NA NA
#> 6   0   0   0   0   0  1   1 175  0  NA  NA  0  NA  NA  2
#>   U2A U2B U2C U2D U2E U2F U2G U2H U2I U2J U2K U2L U2M U2N
#> 1  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
#> 2   1   0   1   0   1   0   0   0   0   1   0   0   1   0
#> 3   1   0   1   0   0   0   0   0   0   0   0   0   0   0
#> 4   1   1   1   0   1   0   0   0   0   0   1   0   0   0
#> 5  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA
#> 6   0   0   0   0   0   0   0   1   0   0   0   0   0   0
#>   U2O U2P U2Q U2Q_T U2R U3A U3B U4 U5 U6A U6B U7A U7A_T U8A
#> 1  NA  NA  NA            NA  NA NA NA  NA  NA  NA        NA
#> 2   0   0   0         A   0   0  0  1   1  NA   5         0
#> 3   0   0   0         A   0   0  0  1   1  NA   5         0
#> 4   0   0   0         A   1   1  0  1   0   0  NA        NA
#> 5  NA  NA  NA            NA  NA NA NA  NA  NA  NA        NA
#> 6   0   0   0         H   1   1  1  1  NA  NA   5        NA
#>   U8B U8C U8D U8E U8F U10A U10B U10C U11 U12 U13 U14 U15A
#> 1  NA  NA  NA  NA  NA   NA   NA   NA  NA  NA  NA  NA   NA
#> 2   1  NA  NA  NA  NA    1    1    0   4   3  NA   5    0
#> 3   1  NA  NA  NA  NA    1    1    0   5   5   3   3    1
#> 4  NA  NA  NA  NA  NA   NA   NA   NA  NA  NA  NA  NA   NA
#> 5  NA  NA  NA  NA  NA   NA   NA   NA  NA  NA  NA  NA   NA
#> 6  NA  NA  NA   4  NA    0    0    0   6   6   5   5    0
#>   U15B U16A U16B U17 U18A U18B U19 U20 U21A U21B U22A U22B
#> 1   NA   NA   NA  NA   NA   NA  NA  NA   NA   NA   NA   NA
#> 2    6    0    4   3   NA   NA   1  NA    5    3    5    4
#> 3    3    1    1   1    4    3  NA   4    4    6    4    5
#> 4   NA   NA   NA  NA   NA   NA  NA  NA   NA   NA   NA   NA
#> 5   NA   NA   NA  NA   NA   NA  NA  NA   NA   NA   NA   NA
#> 6    5    1    6   3    5    3   2   2    5    6    5    4
#>   U22C U22D U22E U23 U24A U24B U24C U24D U24E U25A U25B
#> 1   NA   NA   NA  NA   NA   NA   NA   NA   NA   NA   NA
#> 2    3    3    4   6    3    5    6    5    6    1    1
#> 3    5    4    6   6    3    5    5    4    5    1    0
#> 4   NA   NA   NA  NA   NA   NA   NA   NA   NA   NA   NA
#> 5   NA   NA   NA  NA   NA   NA   NA   NA   NA   NA   NA
#> 6    4    5    5   5    5    5    6    5    5    1    1
#>   U25C U25D U25E U25F U25G U25H U25I U26A U26B U26C U26D
#> 1   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
#> 2    0    0    1    1    1    1    1    1    1    0    1
#> 3    0    0    0    0    0    0    0    1    0    0    0
#> 4   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
#> 5   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
#> 6    0    0    0    0    1    1    0    0    0    0    0
#>   U26E U26F U26G U26H U26I U27A U27B U27C U27D U27E U27F
#> 1   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
#> 2    0    1    0    0    0    3    4    3    4    3    3
#> 3    0    0    0    0    0    3    4    3    3    3    3
#> 4   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
#> 5   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA   NA
#> 6    0    0    0    0    0    2    3    2    4    2    2
#>   U27G U28 U29A U29B U29C U29D U30 U31 U32A U32B U32C U32D
#> 1   NA  NA   NA   NA   NA   NA  NA  NA   NA   NA   NA   NA
#> 2    3   5    2    2    2    2   4   0   NA   NA   NA   NA
#> 3    3   5    2    2    3    3   4   0   NA   NA   NA   NA
#> 4   NA  NA   NA   NA   NA   NA  NA  NA   NA   NA   NA   NA
#> 5   NA  NA   NA   NA   NA   NA  NA  NA   NA   NA   NA   NA
#> 6    4  10    5    3    4    5   3   0   NA   NA   NA   NA
#>   U32D_T U33 U34 U35A U35B U35C U35D U35E U35F U36 U37 U38
#> 1     NA  NA  NA   NA   NA   NA   NA   NA   NA  NA  NA  NA
#> 2     NA  NA   0   NA   NA   NA   NA   NA   NA   3  NA   3
#> 3     NA  NA   0   NA   NA   NA   NA   NA   NA   2   1   5
#> 4     NA  NA  NA   NA   NA   NA   NA   NA   NA  NA  NA  NA
#> 5     NA  NA  NA   NA   NA   NA   NA   NA   NA  NA  NA  NA
#> 6     NA  NA   0   NA   NA   NA   NA   NA   NA   1   2   4
#>   U39 V1 V2  Z1  Z2 E16A_RT E16A_IB E16A_TM E16A_DD REALM2
#> 1  NA NA NA  NA  NA       0       0       0       0      2
#> 2   3  0  0   0  NA      NA      NA      NA      NA     NA
#> 3   4  1  1   0  NA      NA      NA      NA      NA     NA
#> 4  NA  0  1 999 999      NA      NA      NA      NA     NA
#> 5  NA NA NA  NA  NA       0       0       0       0     NA
#> 6   1  1  1 999 999      NA      NA      NA      NA     NA
#>   REALM3 RACE2 A12B_REC ALONE6M JAIL_5YR A18_REC1 A18_REC2
#> 1      3     2        1       0        0        0    15000
#> 2     NA    NA       NA       0       NA       NA       NA
#> 3     NA    NA       NA       0       NA       NA       NA
#> 4     NA    NA       NA       0       NA       NA       NA
#> 5     NA     1        1       1        1        0     7500
#> 6     NA    NA       NA       0       NA       NA       NA
#>   STD_6M EPI_6M EPI_6M2B D3_REC D4_REC D5_REC E10B1_R
#> 1      0      1        1      1      1      1       1
#> 2      0      0        0      0      0      0       0
#> 3      0      0        0      1      1      1       0
#> 4      0      1        1      1      1      1       0
#> 5      0      1        1      1      0      1       0
#> 6      0      0        0      1      1      0       0
#>   E10B2_R G1B_REC G1D_REC PRIMSUB2 ALCQ_30 H2_PRB H3_PRB
#> 1       0       1       1        2      65      1      0
#> 2       1       0       0       NA       0      0      0
#> 3       1       0       0       NA       0      0      0
#> 4       0       0       0       NA      64      1      0
#> 5       0       0       0        1    1680      1      0
#> 6       0       0       0       NA      40      1      0
#>   H4_PRB H5_PRB H6_PRB H7_PRB H8_PRB H9_PRB H10_PRB H11_PRB
#> 1      0      0      0      1      1      0       1       1
#> 2      0      0      0      0      0      0       0       0
#> 3      0      0      0      0      0      0       0       0
#> 4      0      0      0      0      0      0       0       0
#> 5      0      1      0      1      1      1       1       1
#> 6      0      0      0      0      0      0       0       0
#>   H12_PRB O1B_REC O1C_REC O1D_REC O2_REC ABUSE2 ABUSE3
#> 1       0       1       1       1      0      3      2
#> 2       0       0       0       1      0     NA     NA
#> 3       0       0       0       1      0     NA     NA
#> 4       0       1       1       1      0     NA     NA
#> 5       0       1       1       0      0      1      1
#> 6       0       1       1       0      0     NA     NA
#>   PHYS2 IMPUL2 INDTOT2 CHR_6M PC_REC7
#> 1     6      8      39     NA      NA
#> 2     0      1       5      1       1
#> 3     0      0       0      0       2
#> 4     7      6      34      0       2
#> 5     7      9      41     NA      NA
#> 6     4      5      12      1       0
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
#>            Q5         Q6         Q7         Q8         Q9
#> 1   1.3360441 -0.2731168 -0.2964914 -0.2708946 -0.2375393
#> 2  -0.6042744 -0.2731168 -0.2964914 -0.2708946 -0.2375393
#> 3  -0.6042744 -0.2731168 -0.2964914 -0.2708946 -0.2375393
#> 4  -0.6042744 -0.2731168 -0.2964914 -0.2708946 -0.2375393
#> 5   2.3062033 -0.2731168 -0.2964914 -0.2708946 -0.2375393
#> 6  -0.6042744 -0.2731168 -0.2964914 -0.2708946 -0.2375393
#> 7  -0.6042744  4.9244139  4.6259393  5.0979667  5.7418978
#> 8   0.3658848 -0.2731168  2.9851291 -0.2708946  3.7487521
#> 9  -0.6042744  4.9244139  4.6259393  5.0979667  5.7418978
#> 10 -0.6042744 -0.2731168 -0.2964914 -0.2708946 -0.2375393
#>          Q10        Q11         Q12         Q13        Q14
#> 1  -0.254792 -0.4785527 -0.08964059 -0.82644783 -0.2859462
#> 2  -0.254792 -0.4785527 -0.08964059  0.08308206 -0.2859462
#> 3  -0.254792 -0.4785527 -0.08964059  0.08308206 -0.2859462
#> 4  -0.254792 -0.4785527  0.90591326  0.99261195 -0.2859462
#> 5  -0.254792 -0.4785527 -0.08964059 -0.82644783 -0.2859462
#> 6  -0.254792 -0.4785527 -1.08519445 -1.73597772 -0.2859462
#> 7  -0.254792 -0.4785527 -0.08964059  0.08308206 -0.2859462
#> 8  -0.254792 -0.4785527 -0.08964059  0.99261195 -0.2859462
#> 9  -0.254792 -0.4785527 -0.08964059  0.99261195 -0.2859462
#> 10 -0.254792  0.8343306 -1.08519445 -0.82644783 -0.2859462
#>           Q15        Q16        Q17        Q18        Q19
#> 1   1.7635566 -0.2551342  2.3103690 -1.0111878 -1.0321637
#> 2  -0.3014748 -0.2551342 -0.2567077 -1.0111878 -1.0321637
#> 3  -0.3014748 -0.2551342 -0.2567077 -1.0111878 -1.0321637
#> 4  -0.3014748 -0.2551342 -0.2567077 -0.2398803  0.1071559
#> 5  -0.3014748 -0.2551342 -0.2567077  1.3027347  2.3857953
#> 6  -0.3014748 -0.2551342 -0.2567077 -1.0111878  2.3857953
#> 7  -0.3014748 -0.2551342 -0.2567077 -0.2398803 -1.0321637
#> 8  -0.3014748 -0.2551342 -0.2567077  0.5314272  0.1071559
#> 9  -0.3014748 -0.2551342 -0.2567077  1.3027347 -1.0321637
#> 10 -0.3014748 -0.2551342 -0.2567077  1.3027347 -1.0321637
#>           Q20
#> 1   0.8060660
#> 2  -0.5864035
#> 3   0.8060660
#> 4   0.8060660
#> 5  -0.5864035
#> 6   0.8060660
#> 7   0.8060660
#> 8   0.8060660
#> 9   0.8060660
#> 10  0.8060660
```

You can combine `where()` with `across()` to mutate conditionally. In other words, **IF** the column passes some test, the function will be applied to all its values.

Consider the following scenario: say you wanted to convert all the characters to factors.

First, you would check which columns contain characters:


```r
dat %>%
  select(where(is.character)) %>%
  glimpse()
#> Rows: 1,472
#> Columns: 0
```

Next, you can use `across()` and `where()` to change only columns that are characters into factors, checking which columns are factors The columns that were previously characters should show up here.


```r
dat %>% 
  mutate(across(where(is.character), as.factor)) %>%
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

## Regular Expressions

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



https://dplyr.tidyverse.org/reference/select.html


