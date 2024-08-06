clc
clear all

rho=8500;
k=35;
Cp=320;
h=210;
r=0.5*1e-3;
tau=rho*Cp*4/3*3.14*r^3/h/(4*3.14*r^2);

% part 1 
T_amb=120;
Ti=20;
t_analytical= @(t) T_amb+(Ti-T_amb)*exp(-t/tau);
figure
fplot(t_analytical,[0 15],LineWidth=2)
hold on
% part 2
% for 99% change 
theta_99=-(99/100*(20-120) -(20-120));
% theta is -1, that means its 1 degree less than ambinet
time_99=tau*log((20-120)/theta_99)
% time for 99% temp difference is 9.941 secons , which can be also seen clearly from graph


% part 3
tau_1=1;
tau_2=2;
tau_3=3;
tau_4=4;

t_analytical= @(t) T_amb+(Ti-T_amb)*exp(-t/tau_1);
fplot(t_analytical,[0 15])
hold on 
t_analytical= @(t) T_amb+(Ti-T_amb)*exp(-t/tau_2);
fplot(t_analytical,[0 15])
hold on 
t_analytical= @(t) T_amb+(Ti-T_amb)*exp(-t/tau_3);
fplot(t_analytical,[0 15])
hold on 
t_analytical= @(t) T_amb+(Ti-T_amb)*exp(-t/tau_4);
fplot(t_analytical,[0 15])
hold on 
title('Temp vs time ')
ylabel("Temp in degree celcius")
xlabel("Time in sec")
legend("Tau as given from rhoCpV/Ah","Tau=1","Tau=2","Tau=3","Tau=4")

% as Tau increases, it takes more time to reach a specific temp from
% initial temp. we can say it delays to change in temp . if tau is very
% less, then it will quickly reach, or attain the ambient temp. 
% if tau is high, or large, we have to wait more time for reading to reach
% ambient temp.