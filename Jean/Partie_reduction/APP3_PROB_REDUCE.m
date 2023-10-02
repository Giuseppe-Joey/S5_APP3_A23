clc;clear;close all

Kp = 0.318;
K = 100;
tau = 0.01;
Ki = 0.5;
Kb = 0.5;
Ra = 8;
La = 0.008;
Jm = 0.02; 
Bm = 0.01;
N = 0.1; 
JL = 1;
BL = 1;

A = [ 0 1 0 0
     0 (-(Bm+(N^2*BL)))/(Jm+(N^2)*JL) (N*Ki)/(Jm+N^2*JL) 0
     0 (-Kb/La*N) (-Ra/La) (1/La)
     0 0 0 (-1/tau)
    ];

B = [0
    0
    0
    (K/tau)
    ];

C = [1 0 0 0];

D = [0];

[num,den] = ss2tf(A,B,C,D)

G = tf(num,den)
%carte des pôles et zéros
% pzmap(num,den)

%% FT réduit (pôles dominants)

[R,P,K] = residue(num,den);

Poids = abs(R)./abs(real(P));

[numR, denR] = residue(R(3),P(3),K)

Gr_temp = tf(numR, denR)

ogGain = dcgain(G);
redGain = dcgain(Gr_temp);

Kamp = ogGain/redGain;

Gr = Kamp*Gr_temp

%% Reponse a impulse
t = [0:0.01:10]';
u_imp = zeros(size(t));
u_imp(t<=0) = 1;


figure
plot(t, u_imp);




