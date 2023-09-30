


clc
close all
clear


load('DonneesIdentifSyst1erOrdre_1.mat')
 figure()
 plot(t,y),grid
 title('système ordre 1')
 xlabel('t')
 ylabel('y(t)')
 hold on
 
 plot(t,u)
 
 %%%Question 1
 Xe1 = u; %Poser l'équation d'entré 1
 %Xe2 = diff(Xe1)./diff(t);%%%Poser l'équation d'entré 2
 %%%2 entrées car système d'ordre 1
 
 Xs1 = diff(y)./diff(t);
 %Xs2 = diff(Xs1)./diff(t(1:end-1));
 
X=[Xe1(1:end-2) Xs1(1:end-1)];
Y=y(1:end-2);
%transposer X'
P=X'*Y;
R=X'*X;
Ri=pinv(R);
A=Ri*P;
%Y=uk-yT


%%
clc
clear
close all

%q2

TF1=tf([2 6.4],[1 8]);
TF2=tf([25],[1 14.8 61.7 47 25]);
TF3=tf(3,[1 3]);
TF=TF1*TF2*TF3
%representer les poles avant reduction et les zeros avant reduction
pzmap(TF)
%6pôles 1zero

%trouver les pôles dominant (les pôle qui affect le plus la fonction)
[R,P,K]=residue(TF.numerator{1},TF.denominator{1});

%trouver le poid des pôles
Cdom=abs(R)./abs(real(P));
 
%le poid pole avec la plus grande valeur=plus proche de l'axe imaginaire
%on veut toujours deux pole... systeme d'ordre 2

%reduction du systeme
[num,den]=residue(R(5:6),P(5:6),K);
 
TFR=tf(num,den)
pzmap(TFR)
%faire une entré impulsion
t=[0:0.1:50];
u=ones(size(t));
y=lsim(TF,u,t);
yr=lsim(TFR,u,t)
plot(t,y,'b')
hold on
plot(t,yr,'r'),grid
hold off
%faire le gain
%go=gain original gr =gain redui
go=dcgain(TF);
gr=dcgain(TFR);
numrc=num*go/gr;
TFF=tf(numrc,den)
t=[0:0.1:50];
u=ones(size(t));
y=lsim(TF,u,t);
yr=lsim(TFR,u,t);
yf=lsim(TFF,u,t);
plot(t,y,'b')
hold on
plot(t,yr,'r'),grid
plot(t,yf,'g')
%%
%q3
%metre une'
%trouver sa reponse a l'entré
t=[0:0.01:25]';
u=zeros(size(t));
u((t>=0)&(t<2))=2;
u((t>=2))=0.5;
%fonction de transfere
TF=tf([1 2],[1 1 0.25]);
%representer en modele d'état
[A,B,C,D]=tf2ss(TF.numerator{1},TF.denominator{1})
figure()
lsim(A,B,C,D,u,t)
%or
figure()
lsim(TF,u,t)
%%
%q4
TF=tf([1 3 4],[1 4 6 44 80]);
pzmap(TF)
%impulse
figure()
impulse(TF)
%%
%q5 ss to ff
%parti a
A=[-2 -2.5 -0.5;
   1 0 0;
   0 1 0];
B=[1;0;0];
C=[0 1.5 1];
D=[0];
%creer le systeme ss
ME=ss(A,B,C,D);
figure()
impulse(ME)
%parti b
x0=[1 0 2]';
t=[0:0.01:25]';
u=zeros(size(t));
u((t>=0)&(t<2))=2;
u((t>=2))=0.5;
figure
lsim(ME,u,t)
hold on
lsim(ME,u,t,x0)
%parti C
[num,den]=ss2tf(A,B,C,D);
TF=tf(num,den)
hold off

[R,P,K]=residue(TF.numerator{1},TF.denominator{1})
pzmap(TF)