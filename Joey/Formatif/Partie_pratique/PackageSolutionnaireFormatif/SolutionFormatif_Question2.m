close all
clear all
clc

load DonneesIdentifMasseRessortAmorti
% Le fichier DonneesIdentifSyst2eOrdreMasseRessortAmorti contient 3 vecteurs:
% - Le vecteur des temps (de 0 à 5s)
% - Le vecteur de la sortie x
% - Le vecteur de l'entrée Fext (échelon unitaire)

% Affichage des données
figure(1)
plot(t, x, 'r');
figure(2);
plot(t, Fext);

% Pour la méthode d'identification par moindres carrés, il nous faut la
% dérivée de x p.r. au temps, ainsi que la dérivée seconde de x p.r. au
% temps (car on a ici un système d'ordre 2.
delta_t = t(2) - t(1);
Dx = diff(x)/delta_t; % diff donne un vecteur dont la longueur est réduite de 1.
D2x = diff(Dx)/delta_t; % on aura ici un vecteur dont la longueur sera réduite de 2.

% On réduit de 2 la longueur de x et Fext et de 1 la longueur de Dx pour matcher celle de D2x.
long_x = size(x, 1); % Longueur de x (et de Fext)
x_resiz = x(1:(long_x - 2));
Fext_resiz = Fext(1:(long_x - 2));
long_Dx = size(Dx, 1); % Longueur de Dx 
Dx_resiz = Dx(1:(long_Dx-1));
% size(x_resiz)
% size(Fext_resiz)
% size(Dx_resiz)
% size(D2x)


% Pour la méthode des moindres carrés, on forme le vecteur Y (qui est
% déjà formé, c'est x) et on forme la matrice X.
X = [Fext_resiz Dx_resiz D2x];

% On résoud Y = X*alpha par moindres carrés
alpha = inv(X'*X)*X'*x_resiz;

% Dans notre cas particulier:
% alpha(1) vaut 1/k,
% alpha(2) vaut -b/k et
% alpha(3) vaut -m/k
k = 1/alpha(1);
b = -k*alpha(2);
m = -k*alpha(3);

disp(['m = ', num2str(m), 'kg'])
disp(['b = ', num2str(b), ' Ns/m'])
disp(['k = ', num2str(k), ' N/m'])

% Comparaison de la réponse du système avec les paramètres identifiés (courbe
% en noir sur le graphique) versus la réponse fournie dans le fichier de
% données (courbe en rouge sur le graphique de la figure 1).
num = [1/m];
den = [1 b/m k/m];

FT = tf(num,den);
x_c = lsim(FT, Fext, t);
figure(1);
hold on;
plot(t, x_c, 'k');
grid
xlabel('sec')
ylabel('x(t)')
hold off;