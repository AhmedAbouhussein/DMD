
clc 
clear all
close all

f = 0.5; %frequency
w = 2*pi*f;
x = 0:pi/30:2*pi-(pi/30); %Exclude last point
r = 10; %Number of DMD modes
dt = 10; %Sampling Rate
endint = 60; %Span of sampling

%Sampled at 0.1 seconds for endint/dt = 6.2 seconds, while moving 0.1 seconds to the
%right
b = zeros(length(x),endint); 

for t = 1:endint+1
 t = t/dt;
 phase = t*w
 y = sin(w.*x+phase);
 b(:,dt*t) = y(:);
 plot(x,y)
 pause(0.1)
end

v1 = b(:,1:end-1);
v2 = b(:,2:end);

[U,E,W] = svd(v1);    %SVD of v1_n-1

Ut = U(:,1:r); %trims U vector to r modes
Et = E(1:r,1:r); %trims E vector to r modes
Wt = W(:,1:r); %trims W vector to r modes


Sbar = Ut'*v2*Wt*inv(Et); %E is not a square matrix if I sample more x points

[V,D] = eig(Sbar);
eigenvalues = diag(D); 

eigenvalues = log(eigenvalues)*dt;

figure()
plot(eigenvalues, 'x')
xlabel('Real(omega)')
ylabel('Im(omega)')



