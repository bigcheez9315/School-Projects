edit MecheLab_3

%% 1a) Find the regression coefficients for the points (0,.23), (1,.925), (2,2.35), (3,3.5)

x = [0, 1, 2, 3]
y = [.23, .925, 2.35, 3.5]

%%I need to take the transpose of y, so i can multiply x*y
y = y'

% I will calculate a0 and a1 using the same formula that we used in class.
% In short hand, the formula is 
% a0 = (s(x^2)*s(y)-s(x)s(xy))/(N*s(x^2)-(s(x)^2))
% a1 = (N*s(xy)*s(y)-s(x)s(y))/(N*s(x^2)-(s(x)^2))

Sx = sum(x)
Sy = sum(y)
Sxy = sum(x*y)
N = 4
Sx2 = sum(x.^2)

a0 = (Sx2*Sy-Sx*Sxy)/(N*Sx2-Sx^2)
a1 = (N*Sxy-Sx*Sy)/(N*Sx2-Sx^2)

% Call regression line Yc
Yc = a1*x + a0
Yc = Yc'
%1b) Calculate the standard deviation of the data point about the fitted
%line. 
%Sy^2 = (1/N-2)*sum(y-Yc)^2

Stdy = sqrt((1/(N-2))*sum((y-Yc).^2))

%1c) Calculate 95% Confidence Intervals for a0 and a1
% The formula is:
% a0 - t*Sa0 <= a0 <= a0 + t*Sa0, where t, is calculated with alpha/2 =
% .025, and degrees of freedom = 2, and Sa0^2 = Sx2*(Stdy)^2/(N*Sx2-(Sx)^2)

t = tinv(.975,2)
Sa0 = sqrt((Sx2*(Stdy)^2)/ (N*Sx2-(Sx)^2))
a0_lower = a0 - t*Sa0
a0_upper = a0 + t*Sa0

%a0_lower= -.748 is the lower bound of a0 and a0_upper = .88 is the upper
%bound of a0

%To calculate the 95% confidence interval for a1, the formula is:
% a1 - t*Sa1 <= a1 <= a1 + t*Sa1, where t, is calculated with alpha/2 =
% .025, and degrees of freedom = 2, and Sa1^2 = N*(Stdy)^2/(N*Sx2-(Sx)^2)
% t was already calculated above, so we just need to find Sa1

Sa1 = sqrt((N*(Stdy)^2)/ (N*Sx2-(Sx)^2))
a1_lower = a1 - t*Sa1
a1_upper = a1 + t*Sa1

% a1_lower = .69 is the lower bound for a1, and a1_upper = 1.56 is the
% upper bound for a1

%1d) Plot the regression line, the points, the lower bound of regression
%line and the upper bound of regression line
% First, I need to define the lower and upper bound regression lines

yc_lower = a1_lower*x + a0_lower
yc_upper = a1_upper*x + a1_upper

scatter(x,y)
hold on;
plot(x, yc_lower,'-y')
plot(x, yc_upper, '-b')
plot(x, Yc, '-g')
title('Data with regression lines')
xlabel('X')
ylabel('Y')
legend('original data','yc_lower', 'yc_upper', 'yc')
hold off;




