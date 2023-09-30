%%  S5 - APP3 - PROBLEMATIQUE - LOMG2301_CORL0701.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Lucas Corrales
%   CIP:        CORL0701

clc
close all
clear all





Kp = 0.318;
K = 100;
t = 0.01;
Ki = 0.5;
Kb = 0.5;
Ra = 8;
La = 0.008;
Jm = 0.02;
Bm = 0.01;
N = 0.1;
Kl = 10000;
Jl = 1;
Bl = 1;


A = [0,1,0,0,0,0;
    ((-Kl*N)/Jl), (-Bl/Jl) , (Kl*N^2)/Jl,0,0,0;
    0,0,0,1,0,0;
    (Kl*N)/Jm , 0, -(Kl*N^2)/Jm , -Bm/Jm , Ki/Jm ,0;
    0,0,0, -Kb/La , -Ra/La , 1/La ;
    0,0,0,0,0, -1/t];

B = [0;0;0;0;0;(K/t)];

C = [1,0,0,0,0,0];

D = [0];

abcd_params = [A,B; C,D];

[num,den] = ss2tf(A,B,C,D);

G = tf(num,den)
subplot(211)
step(G,450)

A1 = [0,1,0,0;
    0, (-Bl/Jl) ,(Ki*N)/Jl ,0;
    0,-Kb/(N*La ), -Ra/La , 1/La ;
    0,0,0, -1/t];

B1 = [0;0;0;(K/t)];

C1 = [1,0,0,0];

D1 = [0];

abcd_params1 = [A1,B1; C1,D1];

[num1,den1] = ss2tf(A1,B1,C1,D1)

subplot(212)
H = tf(num,den1)
coef1 = 1.46/10000
step(coef1*H,450)





