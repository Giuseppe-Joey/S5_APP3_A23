close all;
clear all;
clc;

disp('EXAMPLE: MATLAB SYMBOLIC TOOLBOX')
disp(' ')

syms s K K2 K3 T L1 Kf

m1 = K*K2*K3/(T*L1*s^2);

L1 = -K2/(T*s);
L2 = -1/(L1*s);
L3 = -K2*K3/(L1*s^2);
L4 = -K/(s^2);

delta = 1 - (L1+L2+L3+L4) + L1*(L2+L3+L4)+L2*L4 - (L1*L2*L4+L1*L3);


FTBO = collect(simplify(m1/delta),s);
disp('___________________________________________')
disp('pretty(FTBO)')
disp('___________________________________________')
pretty(FTBO)

FTBF = collect(simplify(FTBO/(1+FTBO*Kf)),s);
disp('___________________________________________')
disp('pretty(FTBF)')
disp('___________________________________________')
pretty(FTBF)
