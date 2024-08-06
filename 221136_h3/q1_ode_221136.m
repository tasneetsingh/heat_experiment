function dydx=q1_ode_221136(x,y)
k=300;
h=100;      %coefficient when fans are also attached
Ac=1e-5;         %in m^2
P=2*(2+7)/1000; 
dydx=[y(2);y(1)*h*P/k/Ac];

end