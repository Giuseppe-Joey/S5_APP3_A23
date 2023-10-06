%%  S5 - APP3 - FORMATIF PRATIQUE- PRATIQUE_Q1.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301

%   Date de creation:                       05-Octobre-2023
%   Date de derniere modification:          05-Octobre-2023

%   DESCRIPTION:    pratique formatif pratique question 1

clc
close all
clear all


num = [1.5      28.5        202.8       652.2       740.4];
den = [1        23          210         950         2044        1632];




%% essaie 3

TF = tf(num, den)

% reduction
[R, P, K] = residue(num, den)
poid = abs(R)./abs(real(P))

[numR, denR] = residue(R(4:5), P(4:5), K);
TF_R = tf(numR, denR)


% correction du gain dc
gain0 = dcgain(num, den)
gainR = dcgain(numR, denR)
newNumR = numR*(gain0/gainR)


% nouvelle FT avec gain DC corrige
new_TF_R = tf(newNumR, denR)


% appliquer un echelon unitaire
t = 0:0.1:10;
u = ones(size(t));
y0 = lsim(num, den, u, t);
y1 = lsim(newNumR, denR, u, t);


figure
plot(t, y0, t, y1)
grid on
legend("FT originale", "FT reduite")






















 
%% essaie 2
% % soit:
% 
% num = [1.5      28.5        202.8       652.2       740.4];
% den = [1        23          210         950         2044        1632];
% 
% 
% 
% 
% TF = tf(num, den)
% 
% figure
% impulse(TF)
% title("Reponse impulsionnelle ")
% grid on
% 
% 
% 
% 
% 
% 
% [R, P, K] = residue(num, den);
% 
% poid = abs(R) ./ abs(real(P))
% 
% [numReduit, denReduit] = residue(R(4:5), P(4:5), K);
% 
% TF_reduite = tf(numReduit, denReduit)
% 
% figure
% impulse(TF_reduite)
% grid on
% 
% 
% 
% % correction du gain DC
% gain0 = dcgain(num, den);
% gainReduit = dcgain(numReduit, denReduit);
% numReduit = numReduit * ( gain0 / gainReduit);
% 
% TF_reduite = tf(numReduit, denReduit)






% %% b) reponse a un echelunitaire
% t = 0:0.1:10;
% u = ones(size(t));
% y0 = lsim(num, den, u, t);
% y1 = lsim(numReduit, denReduit, u, t);
% 
% figure
% plot(t, y0, t, y1)












%% essaie 1
% TF = tf(num, den)
% 
% figure("Name", "Reponse Impulsionnelle")
% impulse(TF)
% title("Reponse impulsionnelle")
% grid on
% 
% 
% figure
% pzmap(TF)
% title("Map avant reduction")
% grid on
% 
% 
% 
% % reduction
% [R, P, K] = residue(num, den)
% 
% poid = abs(R)./real(P)
% 
% [numReduit, denReduit] = residue(R(4:5), P(4:5), K)
% 
% TF_reduite = tf(numReduit, denReduit)
% 
% 
% figure
% pzmap(TF_reduite)
% title("Map apres reduction")
% grid on
% 
% 









