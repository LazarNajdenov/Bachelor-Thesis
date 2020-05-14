% Script for plotting the scatters of the artificial datasets 
% taken from http://cs.joensuu.fi/sipu/datasets/.
clc;
clear;
close all;

load Aggregation7.mat
load Compound6.mat
load Flame2.mat
load Jain2.mat
load Patchbased3.mat
load R15.mat
load Spiral3.mat
img = figure;
hold on;
dotsize = 12;
 colormap([1 0 .5; % magenta  
           0 0 .8; % blue  
           0 .6 0; % dark green  
           .3 1 0; % bright green 
           54/255 252/255 195/255; % turkese
           198/255 95/255 59/255; % amaranto
           127/255 21/255 5/255; % red brick
           172/255 108/255 204/255; % violet
           237/255 86/255 245/255; % pink
           162/255 26/255 94/255; % fuchsia
           199/255 174/255 132/255; % sand
           84/255 68/255 129/255; %purple
           1 1 0; %yellow 
           1 0 0; %red
           1 128/255 0; %orange
           ]);

subplot(331);
scatter(Aggregation(:,1), Aggregation(:,2), dotsize, Aggregation(:,3));
axis off;
title('Aggregation');
set(gca,'fontsize',17)
subplot(332);
scatter(Compound(:,1), Compound(:,2), dotsize, Compound(:,3));
axis off;
title('Compound');
set(gca,'fontsize',17)
subplot(333);
scatter(Flame(:,1), Flame(:,2), dotsize, Flame(:,3));
axis off;
title('Flame');
set(gca,'fontsize',17)
subplot(334);
scatter(Jain(:,1), Jain(:,2), dotsize, Jain(:,3));
axis off;
title('Jain');
set(gca,'fontsize',17)
subplot(335); 
scatter(Patchbased(:,1), Patchbased(:,2), dotsize, Patchbased(:,3));
axis off;
title('Patchbased');
set(gca,'fontsize',17)
subplot(336);
scatter(R15(:,1), R15(:,2), dotsize, R15(:,3));
axis off;
title('R15');
set(gca,'fontsize',17)
subplot(338);
scatter(Spiral(:,1), Spiral(:,2), dotsize, Spiral(:,3));
axis off;
title('Spiral');
set(gca,'fontsize',17)
set(img,'Renderer', 'painters', 'Position', [100 50 1250 850])
