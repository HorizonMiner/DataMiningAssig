# 4. Resulting Rules
## Reason for sorting by lift:
Lift not only measures the "sureness" a.k.a confidence, but measures the dependence between the antecedents and consequence in the rule. Therefore, it is more detailed especially when the confidence is the same. The larger the lift ratio, the significant the association between two.

## 1. Association rules that include all three combinations with minimum of 2 item sets
Result:

![All Rules Result](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.1/allRulesResult.png)

Scatter:

![All Rules Scatter](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.1/allRulesScatter.png)

Graph:

![All Rules Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.1/allRulesGraph.png)

Grouped:

![All Rules Grouped](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.1/allRulesGrouped.png)
We are interested in finding the relationship between all items.

We would only show rules 1-6 because of the relatively high confidence and lift.

## 2. Association rules with top food occurrence (GongolaisCookie)
Result:

![Gongolais Rules Result](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.2/gongolaisRulesResult.png)

Scatter:

![Gongolais Rules Scatter] (https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.2/gongolaisRulesScatter.png)

Graph:

![Gongolais Rules Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.2/gongolaisRulesGraph.png)

We are interested in finding what will the customer purchase next when a customer purchase Gongolais Cookie.

We would only show the 1st rule because its confidence is larger than 50% and its support, confidence and lift are significantly different than the rest.

## 3. Association rules with top food quantity (TuileCookie)
Result:

![Tulie Rules Result](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.3/tulieRulesResult.png)

Scatter:

![Tuile Rules Scatter](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.3/tulieRulesScatter.png)

Graph:

![Tulie Rules Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.3/tulieRulesGraph.png)

We are interested in finding what will the customer purchase next when a customer purchase Tulie Cookie.

We would only show the 1st rule because its confidence is larger than 50% and its support, confidence and lift are significantly different than the rest.

## 4. Association rules with top drink occurrence/quantity (HotCoffee)
Result:

![Hot Coffee Rules Result](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.4/hotCoffeeRulesResult.png)

Scatter:

![Hot Coffee Rules Scatter](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.4/hotCoffeeRulesScatter.png)

Graph:

![Hot Coffee Rules Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.4/hotCoffeeRulesGraph.png)

We are interested in finding what will the customer purchase next when a customer purchase Hot Coffee.

We would show only first three rules since they have high support, similar lift and lift bigger than 1. Their confidence is low because the occurrences of Hot Coffee sold is very high (close to 10%).

## 5. Association rules using type of food and drinks with minimum of 2 item sets
Result:

![Type Rules Result](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.5/typeRulesResult.png)

Scatter:

![Type Rules Scatter](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.5/typeRulesScatter.png)

Graph:

![Type Rules Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.5/typeRulesGraph.png)

Grouped:

![Type Rules Grouped](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.5/typeRulesGrouped.png)

We are interested in finding what will the customer purchase next when a customer purchase certain types of food or drink.

We would only show rules 2-4. We ignore 1st rule because it has low support while we ignore the rest of rules because they have lower lift compared to rules 2-4.

## 6. Association rules using the top item type sold (tart)
Result:

![Tart Rules Result](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.6/tartRulesResult.png)

Scatter:

![Tart Rules Scatter](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.6/tartRulesScatter.png)

Graph:

![Tart Rules Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.6/tartRulesGraph.png)

We are interested in finding what will the customer purchase next when a customer purchase tart.

We would show all rules since all of them have high support indicating they have high chances of occurring together. Moreover, they have confidence near to 50%.

## 7. Association rules include only both food and drink
Result:

![FD Rules Result](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.7/FDrulesResult.png)

Scatter:

![FD Rules Scatter](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.7/FDrulesScatter.png)

Graph:

![FD Rules Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.7/FDrulesGraph.png)

Grouped:

![FD Rules Grouped](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.7/FDrulesGrouped.png)

We are interested in finding what will the customer purchase next when a customer purchase both food and drink. 

We would only show 1st rule since we discover the antecedent has both food and drink while the rest of rules' antecedents only have food. Moreover, the lift for 1st rule has a stark difference than the rest.

## 8. Association rules with specialized category of food and drinks 

Result
```
      lhs                                    rhs               support confidence lift     
[1]   {Tart=Yes,Danish=Yes,Croissant=Yes} => {Soda=Yes}        0.031   0.52542373 6.8236848
[2]   {Danish=Yes,Croissant=Yes}          => {Soda=Yes}        0.034   0.40963855 5.3199812
[3]   {Tart=Yes,Cookie=Yes,Croissant=Yes} => {Eclair=Yes}      0.010   0.25641026 1.6025641
[4]   {Tart=Yes,Danish=Yes}               => {Soda=Yes}        0.035   0.24822695 3.2237266
[5]   {Coffee=Yes}                        => {Eclair=Yes}      0.073   0.24579125 1.5361953
[6]   {Tart=Yes,Coffee=Yes}               => {Eclair=Yes}      0.043   0.24571429 1.5357143
[7]   {Cookie=Yes,Croissant=Yes}          => {Eclair=Yes}      0.021   0.22105263 1.3815789
[8]   {Coffee=Yes,Cookie=Yes}             => {Eclair=Yes}      0.022   0.20370370 1.2731481
[9]   {Tart=Yes,Coffee=Yes,Cookie=Yes}    => {Eclair=Yes}      0.013   0.19696970 1.2310606
[10]  {Tart=Yes,Croissant=Yes}            => {Soda=Yes}        0.036   0.19672131 2.5548222
[11]  {Tart=Yes,Cake=Yes,Cookie=Yes}      => {Eclair=Yes}      0.015   0.19480519 1.2175325
[12]  {Danish=Yes}                        => {Soda=Yes}        0.039   0.19024390 2.4707000
[13]  {Tart=Yes,Cookie=Yes}               => {Eclair=Yes}      0.031   0.17613636 1.1008523
[14]  {Danish=Yes,Cookie=Yes}             => {Eclair=Yes}      0.011   0.17187500 1.0742188
[15]  {Cookie=Yes,Croissant=Yes}          => {OrangeJuice=Yes} 0.016   0.16842105 2.0539153
[16]  {Cake=Yes,Cookie=Yes}               => {Eclair=Yes}      0.030   0.16666667 1.0416667
[17]  {Cookie=Yes}                        => {Eclair=Yes}      0.066   0.16216216 1.0135135
[18]  {Tart=Yes}                          => {Eclair=Yes}      0.087   0.15675676 0.9797297
[19]  {Croissant=Yes}                     => {OrangeJuice=Yes} 0.047   0.15259740 1.8609439
[20]  {Cookie=Yes}                        => {Lemonade=Yes}    0.061   0.14987715 1.3750197
[21]  {Croissant=Yes}                     => {Soda=Yes}        0.044   0.14285714 1.8552876
[22]  {Tart=Yes,Cake=Yes}                 => {Eclair=Yes}      0.033   0.13524590 0.8452869
[23]  {Coffee=Yes,Croissant=Yes}          => {Eclair=Yes}      0.012   0.12500000 0.7812500
[24]  {Cake=Yes}                          => {Eclair=Yes}      0.056   0.12389381 0.7743363
[25]  {Coffee=Yes,Cookie=Yes}             => {Meringue=Yes}    0.013   0.12037037 1.4329806
[26]  {Cookie=Yes,Croissant=Yes}          => {Meringue=Yes}    0.011   0.11578947 1.3784461
[27]  {Coffee=Yes}                        => {Twist=Yes}       0.034   0.11447811 1.7612018
[28]  {Coffee=Yes}                        => {Pie=Yes}         0.034   0.11447811 1.6835017
[29]  {Cake=Yes,Croissant=Yes}            => {Meringue=Yes}    0.012   0.11214953 1.3351135
[30]  {Coffee=Yes,Cookie=Yes}             => {Lemonade=Yes}    0.012   0.11111111 1.0193680
[31]  {Tart=Yes,Cookie=Yes}               => {Meringue=Yes}    0.019   0.10795455 1.2851732
[32]  {Croissant=Yes}                     => {Eclair=Yes}      0.033   0.10714286 0.6696429
[33]  {Cookie=Yes,Croissant=Yes}          => {Lemonade=Yes}    0.010   0.10526316 0.9657170
[34]  {Coffee=Yes,Cake=Yes}               => {Eclair=Yes}      0.012   0.10344828 0.6465517
[35]  {Tart=Yes,Coffee=Yes}               => {Meringue=Yes}    0.018   0.10285714 1.2244898
[36]  {Cake=Yes,Croissant=Yes}            => {Water=Yes}       0.011   0.10280374 1.3351135
[37]  {Cake=Yes,Croissant=Yes}            => {Eclair=Yes}      0.011   0.10280374 0.6425234
[38]  {Tart=Yes}                          => {Soda=Yes}        0.057   0.10270270 1.3338013
[39]  {Tart=Yes,Cake=Yes}                 => {Meringue=Yes}    0.025   0.10245902 1.2197502
[40]  {Tart=Yes}                          => {Water=Yes}       0.056   0.10090090 1.3104013
[41]  {Tart=Yes,Cookie=Yes}               => {Lemonade=Yes}    0.017   0.09659091 0.8861551
[42]  {Tart=Yes}                          => {Meringue=Yes}    0.053   0.09549550 1.1368511
[43]  {Coffee=Yes,Cake=Yes}               => {Meringue=Yes}    0.011   0.09482759 1.1288998
[44]  {Coffee=Yes,Cake=Yes}               => {Lemonade=Yes}    0.011   0.09482759 0.8699779
[45]  {Cake=Yes,Cookie=Yes}               => {OrangeJuice=Yes} 0.017   0.09444444 1.1517615
[46]  {Cake=Yes,Croissant=Yes}            => {OrangeJuice=Yes} 0.010   0.09345794 1.1397310
[47]  {Cake=Yes,Cookie=Yes}               => {Meringue=Yes}    0.016   0.08888889 1.0582011
[48]  {Danish=Yes}                        => {Eclair=Yes}      0.018   0.08780488 0.5487805
[49]  {Coffee=Yes}                        => {Meringue=Yes}    0.026   0.08754209 1.0421677
[50]  {Tart=Yes,Croissant=Yes}            => {Meringue=Yes}    0.016   0.08743169 1.0408535
[51]  {Tart=Yes,Croissant=Yes}            => {Eclair=Yes}      0.016   0.08743169 0.5464481
[52]  {Cookie=Yes}                        => {OrangeJuice=Yes} 0.035   0.08599509 1.0487206
[53]  {Cookie=Yes}                        => {Meringue=Yes}    0.035   0.08599509 1.0237510
[54]  {Tart=Yes,Coffee=Yes}               => {Lemonade=Yes}    0.015   0.08571429 0.7863696
[55]  {Tart=Yes,Danish=Yes}               => {Meringue=Yes}    0.012   0.08510638 1.0131712
[56]  {Croissant=Yes}                     => {Meringue=Yes}    0.026   0.08441558 1.0049474
[57]  {Cake=Yes}                          => {Meringue=Yes}    0.038   0.08407080 1.0008428
[58]  {Cake=Yes,Cookie=Yes}               => {Lemonade=Yes}    0.015   0.08333333 0.7645260
[59]  {Tart=Yes,Croissant=Yes}            => {Water=Yes}       0.015   0.08196721 1.0645093
[60]  {Tart=Yes,Croissant=Yes}            => {OrangeJuice=Yes} 0.015   0.08196721 0.9996002
[61]  {Tart=Yes,Cake=Yes}                 => {Lemonade=Yes}    0.020   0.08196721 0.7519928
[62]  {Tart=Yes}                          => {Lemonade=Yes}    0.045   0.08108108 0.7438631
[63]  {Cake=Yes}                          => {Lemonade=Yes}    0.036   0.07964602 0.7306974
[64]  {Tart=Yes,Cookie=Yes}               => {Water=Yes}       0.014   0.07954545 1.0330579
[65]  {Tart=Yes,Cookie=Yes}               => {Soda=Yes}        0.014   0.07954545 1.0330579
[66]  {Danish=Yes}                        => {Meringue=Yes}    0.016   0.07804878 0.9291521
[67]  {Tart=Yes,Cake=Yes}                 => {Water=Yes}       0.019   0.07786885 1.0112838
[68]  {Croissant=Yes}                     => {Water=Yes}       0.023   0.07467532 0.9698094
[69]  {Coffee=Yes}                        => {Lemonade=Yes}    0.022   0.07407407 0.6795787
[70]  {Tart=Yes,Croissant=Yes}            => {Lemonade=Yes}    0.013   0.07103825 0.6517271
[71]  {Danish=Yes}                        => {OrangeJuice=Yes} 0.014   0.06829268 0.8328376
[72]  {Danish=Yes}                        => {Lemonade=Yes}    0.014   0.06829268 0.6265384
[73]  {Tart=Yes,Coffee=Yes}               => {Pie=Yes}         0.011   0.06285714 0.9243697
[74]  {Tart=Yes,Cake=Yes}                 => {Soda=Yes}        0.015   0.06147541 0.7983819
[75]  {Cookie=Yes}                        => {Soda=Yes}        0.025   0.06142506 0.7977281
[76]  {Cake=Yes,Cookie=Yes}               => {Soda=Yes}        0.011   0.06111111 0.7936508
[77]  {Cake=Yes}                          => {OrangeJuice=Yes} 0.027   0.05973451 0.7284697
[78]  {Cookie=Yes}                        => {Water=Yes}       0.024   0.05896806 0.7658189
[79]  {Danish=Yes}                        => {Water=Yes}       0.012   0.05853659 0.7602154
[80]  {Croissant=Yes}                     => {Lemonade=Yes}    0.018   0.05844156 0.5361611
[81]  {Tart=Yes}                          => {OrangeJuice=Yes} 0.032   0.05765766 0.7031422
[82]  {Cake=Yes}                          => {Water=Yes}       0.026   0.05752212 0.7470406
[83]  {Tart=Yes,Coffee=Yes}               => {Water=Yes}       0.010   0.05714286 0.7421150
[84]  {Tart=Yes,Cookie=Yes}               => {Twist=Yes}       0.010   0.05681818 0.8741259
[85]  {Tart=Yes,Cookie=Yes}               => {OrangeJuice=Yes} 0.010   0.05681818 0.6929047
[86]  {Cake=Yes,Cookie=Yes}               => {Water=Yes}       0.010   0.05555556 0.7215007
[87]  {Cake=Yes,Cookie=Yes}               => {Pie=Yes}         0.010   0.05555556 0.8169935
[88]  {Cake=Yes}                          => {Soda=Yes}        0.025   0.05530973 0.7183082
[89]  {Cookie=Yes}                        => {Twist=Yes}       0.021   0.05159705 0.7938008
[90]  {Coffee=Yes}                        => {OrangeJuice=Yes} 0.015   0.05050505 0.6159153
[91]  {Danish=Yes}                        => {Twist=Yes}       0.010   0.04878049 0.7504690
[92]  {Danish=Yes}                        => {Pie=Yes}         0.010   0.04878049 0.7173601
[93]  {Cookie=Yes}                        => {Pie=Yes}         0.019   0.04668305 0.6865154
[94]  {Cake=Yes}                          => {Twist=Yes}       0.021   0.04646018 0.7147720
[95]  {Cake=Yes}                          => {Pie=Yes}         0.020   0.04424779 0.6507028
[96]  {Tart=Yes}                          => {Pie=Yes}         0.023   0.04144144 0.6094330
[97]  {Tart=Yes,Cake=Yes}                 => {Twist=Yes}       0.010   0.04098361 0.6305170
[98]  {Coffee=Yes}                        => {Water=Yes}       0.012   0.04040404 0.5247278
[99]  {Croissant=Yes}                     => {Pie=Yes}         0.012   0.03896104 0.5729565
[100] {Coffee=Yes}                        => {Soda=Yes}        0.011   0.03703704 0.4810005
[101] {Tart=Yes}                          => {Twist=Yes}       0.019   0.03423423 0.5266805
[102] {Tart=Yes}                          => {BearClaw=Yes}    0.014   0.02522523 0.9702010
[103] {Cake=Yes}                          => {BearClaw=Yes}    0.010   0.02212389 0.8509190
```

Scatter plot
![SCFD-Scatter](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.8/plot_scatter.png)

Graph plot
![SCFD-Graph](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.8/plot_graph.png)

Grouped plot
![SCFD-Grouped](https://github.com/HorizonMiner/DataMiningAssig/blob/master/Part2/Images/3.8/plot_grouped.png)

We are interested in finding if grouped by categories of food and drinks, what category of food and drink will the customers buy if they buy food from Cake, Tart, Cookie, Danish, Croissant and drink from Coffee category.

The first rule is the most meaningful here as it has high confidence.