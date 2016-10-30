# R Notebook

## Loading Packages & Data

Loading packages

```r
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse", "ggpmisc", "broom", "gridExtra", "ggExtra")
ipak(packages)
```


Load in the data for the exercise

```r
ex8_data <- read.csv("/Users/Julian/GDrive/Misc/Classes/InterStats/Ex8_LabData.csv") %>% tbl_df()
```

<br />
Add a light theme for ggplot output.

```r
old <- theme_set(theme_light(base_size = 12))
```

## Scatterplot

Create a scatterplot with CESD scores at Time 1 and Time 2. 

```r
ggplot(ex8_data, aes(CESD1, CESD2)) + 
  geom_point()
```

![](ex8_nb_files/figure-html/Test-1.png)<!-- -->

<br />
Add a LOESS line (i.e., a smoothed or running average).

```r
ggplot(ex8_data, aes(CESD1, CESD2)) + 
  geom_point() + 
  geom_smooth()
```

![](ex8_nb_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

## Correlation

Test the correlation between CESD1 and CESD2. 

```r
cor.test(ex8_data$CESD1, ex8_data$CESD2)
```

```
## 
## 	Pearson's product-moment correlation
## 
## data:  ex8_data$CESD1 and ex8_data$CESD2
## t = 7.5954, df = 188, p-value = 0.0000000000014
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
##  0.3675733 0.5864698
## sample estimates:
##       cor 
## 0.4845713
```

### BONUS: Boostrapped Confidence Interval

```r
set.seed(10302016)
nSims <- 1000
ex8_data %>% 
  bootstrap(nSims) %>% 
  do(tidy(cor(.$CESD1, .$CESD2))) %>% 
  ungroup() %>% select(pearson_r = x) %>% 
  arrange(pearson_r) %>% 
  slice( c(nSims*.025, nSims*.975)) %>% 
  mutate_all(funs(round(.,4))) %>% 
  add_column(bound = c("lower", "upper"))
```

```
## # A tibble: 2 × 2
##   pearson_r bound
##       <dbl> <chr>
## 1    0.3455 lower
## 2    0.5996 upper
```

## Regression

Test the linear regression of CESD time 1 scores predicting CESD at time 2.    

```r
m1 <- lm(CESD2 ~ CESD1, data=ex8_data)
summary(m1)
```

```
## 
## Call:
## lm(formula = CESD2 ~ CESD1, data = ex8_data)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -21.931  -7.460  -1.998   6.900  40.830 
## 
## Coefficients:
##             Estimate Std. Error t value        Pr(>|t|)    
## (Intercept)  2.56758    1.64667   1.559           0.121    
## CESD1        0.45031    0.05929   7.595 0.0000000000014 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 10.27 on 188 degrees of freedom
## Multiple R-squared:  0.2348,	Adjusted R-squared:  0.2307 
## F-statistic: 57.69 on 1 and 188 DF,  p-value: 0.0000000000014
```

<br />
Use broom::tidy to output model summary into dataframe 

```r
tidy(m1)
```

```
##          term  estimate  std.error statistic              p.value
## 1 (Intercept) 2.5675779 1.64666711  1.559257 0.120617251439059936
## 2       CESD1 0.4503103 0.05928708  7.595420 0.000000000001399962
```

```r
glance(m1)
```

```
##   r.squared adj.r.squared   sigma statistic              p.value df
## 1 0.2348094     0.2307392 10.2705  57.69041 0.000000000001399962  2
##      logLik      AIC      BIC deviance df.residual
## 1 -711.1555 1428.311 1438.052 19830.85         188
```

<br />
General equation for line of best fit:
$$
y = a + bx
$$
<br />
Plug in estimates to generate equation for line of best fit
$$
\hat{Y} = 2.57 + 0.45x
$$

<br />
Examine confidence interval of the estimates

```r
confint(m1)
```

```
##                  2.5 %    97.5 %
## (Intercept) -0.6807409 5.8158967
## CESD1        0.3333569 0.5672637
```

<br />
Add linear regression fit onto scatterplot

```r
ggplot(ex8_data, aes(CESD1, CESD2)) + 
  geom_point() + 
  geom_smooth(method=lm)
```

![](ex8_nb_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

<br />
Remember to add title and axes to your plots

```r
ggplot(ex8_data, aes(CESD1, CESD2)) + 
  geom_point() + 
  geom_smooth(method=lm) + 
  xlab("CESD at Time 1") + 
  ylab("CESD at Time 2") + 
  ggtitle("CESD at Time 2 as a function of CESD at Time 1")
```

![](ex8_nb_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

### BONUS: Adding Equation
We can also add some code to superimpose the regression equation

```r
ggplot(ex8_data, aes(CESD1, CESD2)) + 
  geom_point() + 
  geom_smooth(method=lm) +
  xlab("CESD at Time 1") + 
  ylab("CESD at Time 2") + 
  ggtitle("CESD at Time 2 as a function of CESD at Time 1") +
  stat_poly_eq(aes(label =  paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")),
               formula = y~x, parse = TRUE, label.x.npc = .5, color="blue")
```

![](ex8_nb_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

### BONUS: Marginal Histograms
We can also add histograms to convey marginal distributions


```r
p1 <- ggplot(ex8_data, aes(CESD1, CESD2)) + 
  geom_point() + 
  geom_smooth(method=lm) +
  xlab("CESD at Time 1") + 
  ylab("CESD at Time 2") + 
  stat_poly_eq(aes(label =  paste(..eq.label.., ..adj.rr.label.., sep = "~~~~")),
               formula = y~x, parse = TRUE, label.x.npc = .5, color="blue") + 
  
  # Remove gridlines 
  theme_bw(base_size = 16) +
  theme(axis.text.x     = element_text(size = 12),
        axis.title.y    = element_text(vjust = +1.5),
        panel.grid.major  = element_blank(),
        panel.grid.minor  = element_blank(),
        legend.background = element_blank(),
        legend.key = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.line  = element_line(colour = "black"))

ggMarginal(
  p = p1,
  type = 'histogram',
  bins = 20,
  margins = 'both',
  size = 2,
  col = 'black',
  fill="grey"
)
```

![](ex8_nb_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

