close all
clear
clc

% Param

Kp = 0.318;     % V/rad
K = 100;        % gain ampli
tau =  0.01;    % Cte de temps ampli (s)
Ki =  0.5;      % Cte de couple du moteur (N-m/A)
Kb =  0.5;      % Cte de force contre électromotrice (fcém) du moteurV/rad/s
Ra =  8;        % résistance armature du moteur Ohm
La =  0.008;    % inductance armature dumoteur H (Henrys)
Jm =  0.02;     % inertie armatureN-m s2/rad
Bm = 0.01;      % frottement visqueux armature N.m/rad/s
N =  0.1;       % facteur de réduction
JL =  1;        % inertie charge N.m s2 /rad
BL =  1;        % frottement visqueux charge N-m/rad/s

%b) Matrice / eq d'état:
JmN2Jl = Jm + (N.^2)*JL;
BmN2Bl = Bm + (N.^2)*BL;

A1 = [0 1 0 0;
     0 (-BmN2Bl/JmN2Jl) (N*Ki/JmN2Jl) 0;
     0 (-Kb/(N*La)) (-Ra/La) (1/La);
     0 0 0 (-1/tau)];
B1 = [0 0 0 (K/tau)]';
C1 = [1 0 0 0];
D1 = [0];
%FTBF et FTBO numerique
[NUM1,DEN1] = ss2tf(A1,B1,C1,D1);
FTBO = tf(NUM1,DEN1)
FTBF = Kp*feedback(FTBO, Kp) % Kp gain de potentiometre donc lentre et le feedback est touche



numa = [K];
dena = [tau 1];
numb = [N*Ki];
denb = [(JmN2Jl*La) (Ra*JmN2Jl + La*BmN2Bl) (BmN2Bl*Ra + Ki*Kb) 0];

tfa = tf(numa,dena);
tfb = tf(numb/2.4e-06,denb/2.4e-06);
FTBO_main = tfa*tfb


