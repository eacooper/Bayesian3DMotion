function [lbfig,cffig] = plot_exp3(meanSignedError,semSignedError,mean_zrev,sem_zrev,mean_xrev,sem_xrev)
%
%

lineWidth = 1.5;
barWidth = 0.2;

% lateral bias

lbfig = figure; hold on,

% Bar plot with just center vs. periphery
MSEcenter       = meanSignedError(1)*(180/pi);
MSEperiphery    = meanSignedError(2)*(180/pi);

SEMcenter       = semSignedError(1)*(180/pi);
SEMperiphery    = semSignedError(2)*(180/pi);

% center
bar(0.4,MSEcenter, barWidth, 'FaceColor',ColorIt(4),'LineWidth',lineWidth)
errorbar(0.4,MSEcenter,SEMcenter,'k-','LineWidth',lineWidth)

% periphery
bar(0.8,MSEperiphery, barWidth, 'FaceColor',ColorIt(5),'LineWidth',lineWidth) 
errorbar(0.8,MSEperiphery,SEMperiphery,'k-','LineWidth',lineWidth)

axis([0 1.2 -30 0])

grid off;
box on;
axis square;

set(gca,'FontSize',22);
set(gca,'LineWidth',1.5)
set(gca,'ytick', [-30:10:0])
set(gca, 'Ydir', 'reverse')
set(gca, 'YAxisLocation', 'Right')
set(gca,'xtick',[0.5 0.7])
set(gca,'xticklabel',{'central','peripheral'});
ylabel('Lateral bias');

set(gcf,'Color','w');


% direction confusions

cffig = figure; hold on,

% central
bar(0.3,100*mean_xrev(1), barWidth, 'FaceColor',ColorIt(4),'LineWidth',lineWidth) % lateral
errorbar(0.3,100*mean_xrev(1),100*sem_xrev(1),'k-','LineWidth',lineWidth)

bar(0.6,100*mean_zrev(1), barWidth, 'FaceColor',ColorIt(4),'LineWidth',lineWidth) % depth
errorbar(0.6,100*mean_zrev(1),100*sem_zrev(1),'k-','LineWidth',lineWidth)

% periphery
bar(1.1,100*mean_xrev(2), barWidth, 'FaceColor',ColorIt(5),'LineWidth',lineWidth) 
errorbar(1.1,100*mean_xrev(2),100*sem_xrev(2),'k-','LineWidth',lineWidth)

bar(1.4,100*mean_zrev(2), barWidth, 'FaceColor',ColorIt(5),'LineWidth',lineWidth)
errorbar(1.4,100*mean_zrev(2),100*sem_zrev(2),'k-','LineWidth',lineWidth)

axis([0 1.7 0 50])

grid off; axis square; box on;

set(gca,'FontSize',22);
set(gca,'LineWidth',1.5)
set(gca,'ytick', [0:10:50])
set(gca,'xtick',[0.45 1.25])
set(gca,'xticklabel',{'central','peripheral'});

set(gcf,'Color','w');

ylabel('Direction Confusions (%)', 'FontSize', 22)
