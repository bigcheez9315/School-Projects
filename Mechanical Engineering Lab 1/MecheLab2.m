edit MecheLab_2
rng(1)
%1a) I imported the data set and made the name of the variable excel_data
% Now I will calculate the population mean and the standard deviation of the data set
excel_file = 'HW02_P1_population.csv';
data = csvread(excel_file);

mu = mean(data)
% mu = -3.7461E-04 (very close to zero)
[m n] = size(data);
pop_std = std(data,1)
%%
%pop_std = 1.001

%1b) Plot a histogram of population using histfit

histfit(data)

xlabel('Observation Value')
ylabel('Frequency')
title('Excel Data')

%1c) create 1000 random samples of size N=10 from population
% First I will create a 10x1000 matrix called Rsample that will eventually hold all 1000 samples,
% each of size N=10. I will run a for loop with 1000 iterations, where in each iteration I
% will add a random sample of size n = 10 to the ith row of the Rsample
% matrix. 
%%
Rsample = zeros(10,1000);

Rsample = data(randi(1000000,10,1000));

%1d) Calculate the mean of each sample of size 10, and use histfit to make
%a histogram of all of the means. 

% I will save the mean of each column of Rsample(each separate random
% sample of size 10) into a new matrix called sample_mean. Then I will plot
% the frequencies using histfit

sample_mean = mean(Rsample)

histfit(sample_mean)
xlabel('Sample Mean')
ylabel('Frequency')
title('Distribution of Sample Means')
legend('N=10')

%1e) repeat for N=30
% Now I will do the same process, but I will save the new sampling
% distribution of size n = 30 into a 30 x 1000 matrix called Rsample2.
% Then I'll put all of the sample means into a 1x1000 matrix called
% sample_means2, and then use histfit on all of the sample means. 
%%
Rsample2 = zeros(30,1000);
Rsample2 = data(randi(1000000, 30, 1000));
%%
sample_mean2 = mean(Rsample2)
histfit(sample_mean2)
xlabel('Sample Mean')
ylabel('Frequency')
title('Distribution of Sample Means')
legend('N=30')

%%
%1f) Compare the two plots for N = 10 and N = 30. What do you notice? If you
% calculate the standard deviation of the 1000 sample means for N = 10 and 1000
% sample means for N = 30, and compare it to 1/sqrt(N) what behavior do you notice
% as you increase N? Compare the standard deviation of the 1000 sample means to the
% population mean.

% The interval of sample means is smaller for N=30 than it is for N = 10 .
% For N=10, nearly all of the sample means are between -1 and 1, while for
% N=30 nearly all sample means are between -.6 and .6. This suggests that a
% larger sample size can give you a more accurate estimate of the actual
% mean. 

% First I will calculate the standard deviations for the n = 10, and n = 30
% sampling distribution of the mean, then I will compare those values to
% 1/sqrt(n)

% I will call standard deviation of n = 10 sampling distribution, sd10, and
% for n = 30, sd30. 
sd10 = std(sample_mean)
sd30 = std(sample_mean2)
1/sqrt(10)
1/sqrt(30)

pop_std/sqrt(10)
pop_std/sqrt(30)
% sd10 = .3177
% 1/ sqrt(10) = .3162
% pop_std/sqrt(10) = .3166
% sd30 = .1837
% 1 / sqrt(30) = .1826
% pop_std/sqrt(30) = .1828
% Note that sd10 and sd30 are very close to 1/sqrt(10) and 1/sqrt(30),
% respectively and to pop_std/sqrt(10) and pop_std/sqrt(30), respectively. 
% This is because the population standard deviation is very
% close to 1, and the sample standard deviation can be approximated by
% pop_std/sqrt(n), so 1/sqrt(n) is almost the same as pop_std/sqrt(n). 



%1(g) Determine the percentage of occurences when the population means fall 
%outside 95% confidence interval.You will also have to calculate the 1 
% sample standard deviation for each of the1000 samples in this step to 
% determine the confidence interval. Do this for N = 10 and N = 30.
%%
%Initialize vectors that I will use.
mean_check10 = zeros(1,1000);
mean_check30 = zeros(1,1000);
ci10 = zeros(2,1000);
ci30 = zeros(2,1000);

% Define two 1x1000 vectors that contain the standard deviation for each
% sample in the sampling distributions. sample_std10 has standard
% deviations of samples of size n = 10, and sample_std30 contains standard
% deviations of samples of size n = 30
sample_std10 = std(Rsample)
sample_std30 = std(Rsample2)

%I will do multiple thing in the following for loop. First I will create a
%2x1000 matrix, where the two rows of each column contain the lower
%and upper limits of the confidence interval, respectively. This is for
%samples of size n = 10. I used table to calculate t-critical for 9 degrees
%of freedom and alpha = .025. t=2.262. 
%Then I run an if statement that makes each element of mean_check10 1 if
%the true mean falls in the interval and 0 if it doesnt. 
for i = 1:1000 ;
    ci10(1,i) = sample_mean(1,i) - 2.262*sample_std10(1,i)/sqrt(10);
    ci10(2,i) = sample_mean(1,i) + 2.262*sample_std10(1,i)/sqrt(10);
    if mu >= ci10(1,i) & mu <= ci10(2,i);
        mean_check10(1,i) = 1;
    else
        mean_check10(1,i) = 0;
    end

end
%Now to get the percentage of confidence intervals that contain the true
%mean, I divide the sum of mean_check 10 (this is the total number of
%CI that contain the true mean) by 1000. 
percentmean10 = 100*(sum(mean_check10)/1000)
%%
for i = 1:1000 
    ci30(1,i) = sample_mean2(1,i) - 2.045*sample_std30(1,i)/sqrt(30);
    ci30(2,i) = sample_mean2(1,i) + 2.045*sample_std30(1,i)/sqrt(30);
     if mu >= ci30(1,i) & mu <= ci30(2,i)
        mean_check30(1,i) = 1;
    else
        mean_check30(1,i) = 0;
    end
end

percentmean30 = 100*(sum(mean_check30)/1000)


% In conclusion, 95.9% of the confidence intervals based on random samples of 
% size n = 10 contained the true mean, while 95.7% of the confidence 
% intervals based on random samples of size n = 30 contained the true mean.

