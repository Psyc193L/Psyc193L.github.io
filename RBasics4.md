# Preparing For More Content





<a href="exercises/Exercise3.Rmd" download>Exercise Sheet</a>

In this lesson, a few miscellaneous topics will be covered that will help prepare you for all the content covered in the rest of the course. This is meant to wrap up the basics and background, getting you ready to dive in to the real R coding!

## Functions

>"To understand computations in R, two slogans are helpful:
    Everything that exists is an object, and
    Everything that happens is a function call."<br>
- John Chambers, Advanced R, p. 79.

You have already used a few functions before (`typeof()`, `class()`, `here()`), but they will be formally introduced now. Almost everything you do with coding is built around using functions. Functions are variables containing pre-written code which, most often, have a verb name and are always followed by a set of parentheses. The things inside the parentheses, called **arguments**, are what that verb will be applied. When running:

`typeof(x = myDF)`

You are finding what type `myDF` is. This function has one argument, `x`, that is given the value "myDF". Functions expect arguments to be given values. They need something to apply the pre-written code to! Functions that have multiple arguments often have default values, so you only need to set one or a few of them. you will see more about this later on.

<p class="text-info"> **<u>Note:</u> Arguments are separated with a comma and should often be given their own line.**</p> 

### Where Do Functions Come From? 

A number of different sources! They are:

* Available from base R
  + By default, R has many functions (like those you have seen so far)
* Defined by you (this is beyond the scope of this course)
* Available from packages you import
  + Packages are collections of data, code, and functions, that other people have created and you install into your R. There are many packages that will be used throughout this course.

### Installing Packages

The way you install packages is by using the `install.packages()` function! You just include the name of the package in quotes, and that is it! Packages often need the code from other packages to work (aka **dependencies**). If a package has dependencies, they will also automatically be installed. This means that a lot of scary looking code will be ran in your console when installing packages. It may look like a lot of things are being installed, but this is totally normal and fine! Most packages are extremely small. You can have hundreds of packages installed and it take up less than 1gb of space on your computer! Once a package is installed, you have to actually load it into your R session by using `library()`.

Install a new package:

* `install.packages("tidyverse")`
  + do 1x per machine


Load an installed package:

* `library(tidyverse)`
  + do 1x per work session

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE #1**</div>
  <div class="panel-body">Install the packages listed below:
  tidyverse, viridis, RColorBrewer, DT, ggExtra, gridExtra, patchwork, reprex, knitr, palmerpenguins, magrittr, markdown, janitor, ggridges</div>
</div>

## Pipes

![](figures/pipe.png)
<br>
<span style="font-size:8.0pt"> This is a reference to René Magritte's "The Treachery of Images," which actually is on display at the LAC Museum of Art!</span>

One of the more powerful tools in R that you will use is the `%>%` (pipe) operator.

RStudio Keyboard Shortcuts:

* OSX: CMD + SHIFT + M
* Else: CTRL + SHIFT + M

<span style="font-size:18.0pt"><u>**How Does a Pipe Work?**</u></span>

Consider the [following example](https://twitter.com/dmi3k/status/1191824875842879489?s=09) of making and eating a cake.

There are several things you need to do:

* Have ingredients
* Mix ingredients
* Pour mixture into pan
* Bake mixture
* Let cool
* Slice
* Eat a piece

One thing you might think to do is just go step by step:


```r
mixture = mix(ingredients)
thing_in_oven = pour(mixture)
hot_baked_bake = bake(thing_in_oven)
cooled_baked_cake = cool(hot_baked_bake)
sliced_cake = slice(cooled_baked_cake)

eat(sliced_cake, 1)
```

This creates a lot of unnecessary interim step variables that you do not care about. You will not use them again and they just clog up your workspace.

If you were to express this process as a set of nested functions, it would look like this:


```r
eat(slice(cool(bake(put(pour(mix(ingredients), into = baking_pan), into = oven), time = 30), duration = 20), pieces = 6, 1))
```

Nesting a dataframe inside a function is hard to read because it forces you to read the sequence of functions inside out. You have to start in the innermost parentheses, and then work your way out/back.

Even if you were to apply your style and syntax guidelines here:


```r
eat(
  slice(
    cool(
      bake(
        put(
          pour(
            mix(ingredients),
            into = baking_pan),
          into = oven),
        time = 30),
      duration = 20),
    pieces = 6,
    1)
)
```

It is still difficult and unnatural to read. If you were to describe this process in words, spoken or written, it would take a totally different form! You might say something like:

>"I need to start by taking my ingredients, mix them together, pour the mixture into a baking pan, and then put that pan into the oven and bake for 30 minutes. Once that is done let it cool for 20 minutes, slice into 6 pieces, and eat one of them (or several, if you are me)!"

It would be so much easier if you could write your code in a form that would match how you actually think about this process. That is precisely what piping with `%>%` allows you to do! Here is how you write this code with piping:


```r
ingredients %>% 
  mix() %>% 
  pour(into = baking_pan) %>% 
  put(into = oven) %>% 
  bake(time = 30) %>% 
  cool(during = 20) %>%
  slice(pieces = 6) %>% 
  eat(1)
```

When you pipe a dataframe into a function, and *chain* together a number of functions, it lets you read left to right / up to down. Your code "sentence" starts with a noun instead of a verb. This is much easier to read and write because it takes the same form that you actually think about this process. It is in the chronological order of what you want to be doing.

There are two mantras with pipes:

* Think of a `%>%` to mean "and then"
* "dataframe first, dataframe once"

What the `%>%` operator is actually doing is taking the result/output of the previous computation (thing on the left or above) and *piping* it through as input to the next computation. In most cases, these computations will be functions. 

`mix(ingredients)` is equivalent to `ingredients %>% mix()`

Below is an animated illustration of a similar example:

<center>
  <video width="450" height="450" autoplay loop>
    <source src="figures/RPipe.mp4" type="video/mp4">
  </video>
</center>
<p style="font-size:6pt">Source: [Arthur Welle](https://twitter.com/ArthurWelle/status/1535429654760284161)</p>
<br>

### Do's and Dont's

**<u>DO:</u>**

* Apply all the same style/syntax guidelines
  + Space before and after a `%>%`
  + Each new step on its own line
  + Indent each subsequent line in a chain
  + Etc.

**<u>DON'T:</u>**

Use a pipe when...

* More than one object needs to be manipulated. 
  + Pipes should only be used when a chain of steps is applied to one object.

* There are intermediate objects you need to use which could be given an informative name.

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE #2**</div>
  <div class="panel-body">Rewrite the following code as properly formatted pipe chains.</div>
</div>

### Pipe Positions

When you pipe something in to a function, it is input as the first element by default.

`a %>% sum(b)` is equivalent to `sum(a, b)`

You can specify which argument (or what position in the function) the piped input should be given to with the `.` operator. The `.` operator can be used to refer to the object/dataframe in its current state in the pipe chain. In other words, the `.` refers to what is being piped in to the current function. 

Consider the following example using the `seq(from, to)` function, which has two arguments (*from* and *to*). `seq()` will generate a sequence of numbers with a range of the *from* value until the *to* value (it was very hard avoiding the use of the words "from" and "to" here). By default, what is piped in will be input as the first element. 


```r
a = 1
b = 5
b %>% seq(a)
#> [1] 5 4 3 2 1
```

Above, when `b` is piped in, it gets set as the first argument and the result is a descending sequence. However, if you explicitly told `seq()` where you wanted the piped input to go using `.`, you could get the expected ascending sequence:


```r
b %>% seq(from = a, 
          to = .)
#> [1] 1 2 3 4 5
```

<!-- ## COMMON CODE BUGS -->

## REPREX

The last thing you need to truly be prepared for the forthcoming material is to know how to get help. That is, how to help others best help you! If you are running into an error or your code is not working the way you want or expected, the best way to get help is by preparing a "minimal <u>**repr**</u>oducible <u>**ex**</u>ample".

![](figures/reprex.png){width=100%}
<p style="font-size:6pt">Artwork by @allison_horst</p>

> "The goal of a reprex is to package your problematic code in such a way that other people can run it and feel your pain. Then, hopefully, they can provide a solution and put you out of your misery."<br>
- tidyverse documentation

### How To Create

You create a reprex by copying some code to your clipboard (cmd/ctrl+C), and then running the `reprex()` function in your console (after loading the `reprex` library with `library(reprex)`). This will do two things:

1. Generate a preview of your reprex
2. Copy the reprex to your clipboard for you to paste anywhere! (i.e., a discord DM/message, email, etc.)

### Creating Good Reprex

There are several things you must do, consider, and apply, to creating a good reprex.

#### Reproducible

To make a reprex, your code must be reproducible. This means that your reprex code must include any `library()` calls, and that you should ideally use one of R's built in datasets (to guarantee it will work for anyone else).

A few good options include:

* iris
* diamonds
* mtcars
* airquality
* ChickWeight
* ToothGrowth
* PlantGrowth

#### Minimal

Your reprex code should be as simple and minimal as possible. Only include things on a "need to run" basis. If something is not **directly** related to the problem you are facing, delete it and do not include it! This often means that your reprex will be using a much smaller and simpler R object, using a different dataset, than what you encountered in your actual coding.

#### Legible

Your reprex code should still incorporate all the same style and syntax guidelines that you otherwise would in your code.

More guidelines can be found on the reprex [website](https://reprex.tidyverse.org/articles/reprex-dos-and-donts.html) and [here](https://www.tidyverse.org/help/).

#### Dude, This is a Lot of Work!

Yes, this is definitely true, and creating a good reprex is a skill in itself! You may be thinking, *"Okay but is it really worth it to go through all that effort when I am <b><u>already</u></b> struggling?*

The answer is definitely yes! There are two compelling reasons:

1. Most of the time, in the process of creating a good reprex, you will reveal the source of the error and solve your own problem. 
2. In the instances where that does not happen, you have made it a lot easier to get help and increase the likelihood of solving your issue!

## Data Importing and Exporting

While the built in datasets that R comes with can be very helpful, the whole point of learning R is to use it for our own needs. So you need some ways to get your raw data into R, and the products of your code out of R.

### Importing

You are most often going to work with csv's and .RData files. You can work with a number of other file types in R, but that will be beyond the scope of this class.

#### csv Files

You will use the `read_csv()` function to load a dataset into R. This function takes a file as its argument. How does R know where to look for the file? You need to give it the right file path, and this is where the `here()` function discussed [previously](#here) will be applied!

Recall in the previous lesson when considering the structure of your project directories, an example was discussed where you had a data file called **"dataset.csv"** and it was in a folder called **"data"**. You tell `read_csv()` where to look by giving it the same `here()` call used before!


```r
here("data", "dataset.csv")
#> "/Users/ethan/Documents/Psyc193L/data/dataset.csv"

example_df = read_csv(here("data", "dataset.csv"))
```

If the output from `read_csv()` was not saved to a variable, it would just print it out in the console. You need a variable to *get* the output so you can use it later in your other code. You do this by saving it to a variable.

As an additional point, you can also directly load files from websites by using the website as the file path. Remember, a file path is just a map to tell your computer where to look for something. The file path just needs to lead `read_csv()` to a .csv file!


```r
example_df = read_csv("https://www.ethanhurwitz.com/example_data.csv")
```

#### RData Files

The other type of file you may want to import is an .RData file. These directly load R objects into your workspace. Instead of using `read_csv()`, you just use `load()` and pass it the file path to a .RData file!

Since .RData files already contain R objects, you do not have to save this to a variable. It is loading variables that already exist!

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE #3**</div>
  <div class="panel-body">Download the files for today's class that came with the assignment and move them into your project directory you created last time. Using `here()` import both the .csv and .RData files. Copy/paste their file path in the cell below this question on your worksheet!</div>
</div>

### Exporting

While the goal of using R code is to make your tasks easily reproducible, there are instances where you may want to directly save and export something. For example, you may want to use some data with other software. In these instances, you can easy export the file with `write_csv()`, which takes the form: `write_csv(object_to_be_saved, file = "file_name.csv")`. This will create a new .csv file of your dataframe/object in your working directory.

Alternatively, you may have run some code that takes a **V.F.L.T.** <b>(Very, *Frankly*, Long Time)</b> to run. Somewhere down the road you may be executing complicated models that can take hours or even days to run! You may not want to have to rerun this code consecutively each time you revisit that project. To avoid doing so, you can save R data object that you can easily load in to R.

You do so using the `save()` function, which takes a similar form of `save(objects_to_be_saved, file = "fil_name.rdata")`.

<div class="panel panel-success">
  <div class="panel-heading">**EXERCISE #4**</div>
  <div class="panel-body">Open up your exercises from the 3rd class. Export your dataframe as a .csv file called "my_dataframe.csv". Export your dataframe and all the variables you saved to an .RData file called "my_data.RData".</div>
</div>
