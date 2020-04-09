clear;
close all;
% David Talson
% Student number: 101022690

global C G b
G = zeros(5,5);
C = zeros(5,5);
b = zeros(5,1);

res(1,2,1);
cap(1,2,0.25);
res(2,0,2);
res(3,0,44.23);
res(4,5,0.1);
res(5,0,1000);
ind(2,3,0.2);
vol(1,0,1);
vcvs(4,0,3,0,(100/44.23)+(200/44.23^2)+(300/44.23^3));

Vin = linspace(-10, 10, 100);

for i = 1:100
    b(7) = Vin(i);
    nodeVoltages = G\b;
    vnode3(i) = nodeVoltages(3);
    vOut(i) = nodeVoltages(5);
    gain(i) = vOut(i)/Vin(i);
end

figure(1)
plot(Vin, vnode3,'LineWidth',2);
hold on
plot(Vin, vOut,'LineWidth',2);
xlabel('Input Voltage')
ylabel('Voltage')
legend('Voltage at node 3', 'Output voltage (Vo)');
grid on
hold off

F = logspace(0,8,5000);

for i=1:length(F)
    w = 2*pi*F(i);
    s = 1i*F(i);
    A = G + (s*C);   

    nodeVoltages = A\b;
    Vout(i) = nodeVoltages(5);
    gain(i) = 20*log(abs(nodeVoltages(5)));
end

figure(2);
semilogx(F, Vout,'LineWidth',2);
xlabel('Frequency (Hz)');
ylabel('Output voltage (V)');
title('Frequency Response')
grid on

figure(3);
semilogx(F, gain,'LineWidth',2);
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
title('Gain');
grid on

cnew = 0.25 + 0.05*randn(1,1000);
for i = 1:1000
    s = 1i*pi;
    
    C(1,1) = cnew(i);
    C(2,2) = cnew(i);
    C(1,2) = cnew(i)*-1;
    C(2,1) = cnew(i)*-1;
    c(i)=cnew(i);
    A = G +(s*C);
    nodeVoltages = A\b;
    gainnew(i) = 20*log10(abs(nodeVoltages(5)));
end

figure(4)
histogram(gainnew);
title('Gain Histogram')
grid on