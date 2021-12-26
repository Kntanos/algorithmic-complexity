# Algorithmic Complexity Timer

This is a application for timing the running of functions in Ruby and generating csv data that can be graphed.

The application is written in Ruby and tested with Rspec.

- The code automatically generates a set of 20 arrays of increasing number of elements starting at 50_000 up to 1_000_000 (in steps of 50_000), filled with random numbers between 0 and 100.
- It runs 20 repeats for each array, before it starts recoding the time (throaway data).
- It then runs the function for each array the given number of repeats and calculates the median value for each array.
- Finally it exports a csv file with the name of the method in the filename.

The number of throwaway data and sample arrays can be adjusted, by changing constants SAMPLE_SIZES and THROWAWAY_RUNS in sample.rb and stopwatch.rb respectively.  

To use the application on the command line, run:
```
> irb
> require './lib/algorithm_timer'
```
Create a new object e.g. *timer* and give it as arguement the name of the function you want to test as a sting e.g. "reverse"
`> timer = AlgorithmicTimer("reverse")`
Then generate the data by running:
`> timer.run_samples(number_of_repeats)`

The application will generate a csv file named **'reverse_function.csv'**

Example csv file:
```
50000,0.03800005652010441
100000,0.07199996616691351
150000,0.1039999770000577
200000,0.12099999003112316
250000,0.16000005416572094
300000,0.19049999536946416
350000,0.22550002904608846
400000,0.26000000070780516
450000,0.291000003926456
500000,0.3279999946244061
550000,0.36099995486438274
600000,0.38700003642588854
650000,0.44299999717622995
700000,0.4569999873638153
750000,0.4889999981969595
800000,0.5570000503212214
850000,0.5599999567493796
900000,0.590000010561198
950000,0.5525000160560012
1000000,0.6705000414513052
```