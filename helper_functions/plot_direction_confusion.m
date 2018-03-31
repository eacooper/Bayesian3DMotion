function [dfig, lfig] = plot_direction_confusion(z_reversed,sem_z_reversed,x_reversed,sem_x_reversed,ebflag)
%
% makes strong assumptions on input of z_reversed - contrast x viewing
% distance?
% We can either pass in contrast x viewing distance data, or viewing
% eccentricity data

lineWidth = 1.5;
barWidth = 0.2;

dfig = figure;
hold on,

plot([0 2.9], [50 50], 'k--','LineWidth',lineWidth)

if size(z_reversed,2) > 1 % contrast x viewing distance data
    
    bar(2.2,(z_reversed(1,1))*100, barWidth, 'FaceColor',ColorIt(1),'LineWidth',lineWidth) % 7.5% - 90cm
    bar(1.3,(z_reversed(1,2))*100, barWidth, 'FaceColor',ColorIt(2),'LineWidth',lineWidth) % 15% - 90 cm
    bar(0.4,(z_reversed(1,3))*100, barWidth, 'FaceColor',ColorIt(3),'LineWidth',lineWidth) % 100% - 90 cm
    

    if size(z_reversed,1)> 1 % we have datapoints for two viewing distances
        bar(2.5,(z_reversed(2,1))*100, barWidth, 'FaceColor',ColorIt(1)*0.5,'LineWidth',lineWidth) % 7.5% - 45cm
        bar(1.6,(z_reversed(2,2))*100, barWidth, 'FaceColor',ColorIt(2)*0.5,'LineWidth',lineWidth) % 15% - 45 cm
        bar(0.7,(z_reversed(2,3))*100, barWidth, 'FaceColor',ColorIt(3)*0.5,'LineWidth',lineWidth) % 100% - 45 cm
    end
    
else % eccentricity data
    
    bar(2.2,(z_reversed(1,1))*100, barWidth, 'FaceColor',ColorIt(1),'LineWidth',lineWidth)
    bar(0.4,(z_reversed(2,1))*100, barWidth, 'FaceColor',ColorIt(3),'LineWidth',lineWidth)
    
end


fontSize = 14; set(gca,'FontSize',fontSize+8);

grid off; box on;
axis([0 2.9 0 60])
axis square;

set(gca,'LineWidth',1.5)
set(gca,'ytick', [0:20:60])
set(gca,'xtick',[])
set(gca,'xticklabel','');

set(gcf,'Color','w');

ylabel('Depth direction confusions (% trials)', 'FontSize', fontSize+8)

if(ebflag)
    plot([2.2 2.2],[z_reversed(1,1)-sem_z_reversed(1,1) z_reversed(1,1)+sem_z_reversed(1,1)].*100,'k','LineWidth',lineWidth)
    plot([1.3 1.3],[z_reversed(1,2)-sem_z_reversed(1,2) z_reversed(1,2)+sem_z_reversed(1,2)].*100,'k','LineWidth',lineWidth)
    plot([0.4 0.4],[z_reversed(1,3)-sem_z_reversed(1,3) z_reversed(1,3)+sem_z_reversed(1,3)].*100,'k','LineWidth',lineWidth)
    
    if size(z_reversed,1)> 1 % we have datapoints for two viewing distances
        plot([2.5 2.5],[z_reversed(2,1)-sem_z_reversed(2,1) z_reversed(2,1)+sem_z_reversed(2,1)].*100,'k','LineWidth',lineWidth)
        plot([1.6 1.6],[z_reversed(2,2)-sem_z_reversed(2,2) z_reversed(2,2)+sem_z_reversed(2,2)].*100,'k','LineWidth',lineWidth)
        plot([0.7 0.7],[z_reversed(2,3)-sem_z_reversed(2,3) z_reversed(2,3)+sem_z_reversed(2,3)].*100,'k','LineWidth',lineWidth)
    end
end


lfig = figure;
hold on,

plot([0 2.9], [50 50], 'k--','LineWidth',lineWidth)

if size(z_reversed,2) > 1 % contrast x viewing distance data
    bar(2.2,(x_reversed(1,1))*100, barWidth, 'FaceColor',ColorIt(1),'LineWidth',lineWidth) % 7.5% - 90cm
    bar(1.3,(x_reversed(1,2))*100, barWidth, 'FaceColor',ColorIt(2),'LineWidth',lineWidth) % 15% - 90 cm
    bar(0.4,(x_reversed(1,3))*100, barWidth, 'FaceColor',ColorIt(3),'LineWidth',lineWidth) % 100% - 90 cm
    
    if size(z_reversed,1)> 1 % we have datapoints for two viewing distances
        bar(2.5,(x_reversed(2,1))*100, barWidth, 'FaceColor',ColorIt(1)*0.5,'LineWidth',lineWidth) % 7.5% - 45cm
        bar(1.6,(x_reversed(2,2))*100, barWidth, 'FaceColor',ColorIt(2)*0.5,'LineWidth',lineWidth) % 15% - 45 cm
        bar(0.7,(x_reversed(2,3))*100, barWidth, 'FaceColor',ColorIt(3)*0.5,'LineWidth',lineWidth) % 100% - 45 cm
    end
    
else % eccentricity data
    
    % bar(2.2,(x_reversed(1,1))*100, barWidth, 'FaceColor',ColorIt(1),'LineWidth',lineWidth) % 7.5% - 90cm
    bar(1.3,(x_reversed(1,1))*100, barWidth, 'FaceColor',ColorIt(2),'LineWidth',lineWidth) % 15% - 90 cm
    bar(0.4,(x_reversed(2,1))*100, barWidth, 'FaceColor',ColorIt(3),'LineWidth',lineWidth) % 100% - 90 cm
    
end

fontSize = 14; set(gca,'FontSize',fontSize+8);

grid off; box on;
axis([0 2.9 0 60])
axis square;

set(gca,'LineWidth',1.5)
set(gca,'ytick', [0:20:60])
set(gca,'xtick',[])
set(gca,'xticklabel','');

set(gcf,'Color','w');

ylabel('Lateral direction confusions (% trials)', 'FontSize', fontSize+8)

if(ebflag)
    
    plot([2.2 2.2],[x_reversed(1,1)-sem_x_reversed(1,1) x_reversed(1,1)+sem_x_reversed(1,1)].*100,'k','LineWidth',lineWidth)
    
    plot([1.3 1.3],[x_reversed(1,2)-sem_x_reversed(1,2) x_reversed(1,2)+sem_x_reversed(1,2)].*100,'k','LineWidth',lineWidth)
    
    plot([0.4 0.4],[x_reversed(1,3)-sem_x_reversed(1,3) x_reversed(1,3)+sem_x_reversed(1,3)].*100,'k','LineWidth',lineWidth)
    
    if size(z_reversed,1)> 1 % we have datapoints for two viewing distances
        plot([2.5 2.5],[x_reversed(2,1)-sem_x_reversed(2,1) x_reversed(2,1)+sem_x_reversed(2,1)].*100,'k','LineWidth',lineWidth)
        plot([1.6 1.6],[x_reversed(2,2)-sem_x_reversed(2,2) x_reversed(2,2)+sem_x_reversed(2,2)].*100,'k','LineWidth',lineWidth)
        plot([0.7 0.7],[x_reversed(2,3)-sem_x_reversed(2,3) x_reversed(2,3)+sem_x_reversed(2,3)].*100,'k','LineWidth',lineWidth)
    end
    
end