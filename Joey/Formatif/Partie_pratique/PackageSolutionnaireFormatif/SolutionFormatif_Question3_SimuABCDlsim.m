close all;
clear all;
clc;

% Question 3

t = 0 : 0.01 : 10;

A = [0  1; -100 -4];
B = [0; 1];
C = [1 0];
D = [0];

%% a) calculer et tracer la repomse a limpulsion

x0 = [0 0];

sys = ss(A, B, C, D);

% R�ponse � l'impulsion
figure(1)
impulse(sys)
title('r�ponse � l''impulsion');

%% b) R�ponse � l'�chelon de 50
u = 50*ones(size(t));
figure(2)
y = lsim(sys, u, t, x0);
plot(t, y);
title('r�ponse � l''�chelon de 50');

% Une autre fa�on est d'utiliser la fonction step
% y= 50*step(sys);
% figure(5);
% plot(y); 



%% c) simuler la repnse des etats x(t) = [x1(t)    x2(t)]' lorsque lentree est:

% Entr�e
u = zeros(size(t));
u(t<2) = 100;
u(t>=2) = 20;
% CI
x0 = [0 1];

% �volution de x1 et x2
[y1,t1,X] = lsim(sys, u, t, x0);
figure,
plot(t, X);
legend('x1','x2');
title('�volution de x1 et x2');