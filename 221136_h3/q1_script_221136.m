clc
clear all

k=300;
h=10;
h_fan=100;      %coefficient when fans are also attached
A_fin=1e-5;         %in m^2
P_fin=2*(2+7)/1000;     %perimeter in meters
L_fin=0.05;         %in meters
T_amb=20;
T_max_chip=120;
% both temp are in celcius

%part 1
L_mesh=linspace(0,L_fin,100);
solinit = bvpinit(L_mesh,[0;0]);
bcfun = @(ya,yb)[ya(1)-T_max_chip+T_amb;yb(2)+h_fan/k*yb(1)];

sol=bvp4c(@q1_ode_221136,bcfun,solinit);
mainsol = sol.y;        %this is thetha

figure
plot(L_mesh,mainsol(1,:))
title('Theta vs length profile')
ylabel("Theta in degress Celcius")
xlabel("Length in meters")
hold on

%part 2
m=(h_fan*P_fin/k/A_fin)^(0.5);
theta_b=T_max_chip-T_amb;

fun_inf=@(x) (theta_b)*exp(-m*x);
fun_adia=@(x) (theta_b/(1+exp(2*m*L_fin))*exp(m*x) + theta_b/(1+exp(-2*m*L_fin))*exp(-m*x));

fplot(fun_adia,[0 L_fin])
hold on
fplot(fun_inf,[0 L_fin])
legend("Numerically solved","Assumed adiabatic fin tip","Assumed inf. long fin")
hold off

% part 3
% adiabatic tip assumption is what is closer to our numerical plotted result
% when in real case, the temp difference is so small at far x, that very
% less
% conduction occurs between cross section, so dT/dx tends to 0, as length
% reaches l, and it somewhat similars to our afiabatic case which is
% dT/dx=0, at tip.

% part 4
L_vary=[0.001:0.001:1];
for i=1:length(L_vary)
    efficiency_adia(i)=tanh(m*L_vary(i))/m/L_vary(i);
    efficiency_inf(i)=1/m/L_vary(i);
    effectiveness_inf(i)=m;
    effectiveness_adia(i)=m*tanh(m*L_vary(i));
end

figure
plot(L_vary,effectiveness_inf,L_vary,effectiveness_adia)
title('Effectiveness vs Total Length')
ylabel("Effectiveness")
xlabel("Diff. Total length in meters")
legend("infinite long","adiabatic tip")

figure
plot(L_vary,efficiency_inf,L_vary,efficiency_adia)
title('Efficiency vs Total length')
ylabel("Theta in degress Celcius")
xlabel("Diff. Total length in meters")
legend("infinite long","adiabatic tip")
