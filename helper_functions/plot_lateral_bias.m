function fig = plot_lateral_bias(meanSignedError,semSignedError,ebflag)
%
% plots lateral bias
% makes strong assumptions on input of meanSignedError - contrast x viewing
% distance?
% We can either pass in contrast x viewing distance data, or viewing
% eccentricity data

fig = figure;
hold on,

lineWidth = 1.5;
barWidth = 0.2;

if size(meanSignedError,2) > 1 % contrast x viewing distance data
    
    bar(2.2,(-meanSignedError(1,1))*(180/pi), barWidth, 'FaceColor',ColorIt(1),'LineWidth',lineWidth) % 7.5% - 90cm
    bar(1.3,(-meanSignedError(1,2))*(180/pi), barWidth, 'FaceColor',ColorIt(2),'LineWidth',lineWidth) % 15% - 90 cm
    bar(0.4,(-meanSignedError(1,3))*(180/pi), barWidth, 'FaceColor',ColorIt(3),'LineWidth',lineWidth) % 100% - 90 cm
    
    if size(meanSignedError,1)> 1 % we have datapoints for two viewing distances
        
        bar(2.5,(-meanSignedError(2,1))*(180/pi), barWidth, 'FaceColor',ColorIt(1)*0.5,'LineWidth',lineWidth) % 7.5% - 45cm
        bar(1.6,(-meanSignedError(2,2))*(180/pi), barWidth, 'FaceColor',ColorIt(2)*0.5,'LineWidth',lineWidth) % 15% - 45 cm
        bar(0.7,(-meanSignedError(2,3))*(180/pi), barWidth, 'FaceColor',ColorIt(3)*0.5,'LineWidth',lineWidth) % 100% - 45 cm
        
    end
    
    if ebflag
        
        plot([2.2 2.2],[-meanSignedError(1,1)-semSignedError(1,1) -meanSignedError(1,1)+semSignedError(1,1)].*(180/pi),'k','LineWidth',lineWidth)
        plot([1.3 1.3],[-meanSignedError(1,2)-semSignedError(1,2) -meanSignedError(1,2)+semSignedError(1,2)].*(180/pi),'k','LineWidth',lineWidth)
        plot([0.4 0.4],[-meanSignedError(1,3)-semSignedError(1,3) -meanSignedError(1,3)+semSignedError(1,3)].*(180/pi),'k','LineWidth',lineWidth)
        
        if size(meanSignedError,1)> 1 % we have datapoints for two viewing distances
            plot([2.5 2.5],[-meanSignedError(2,1)-semSignedError(2,1) -meanSignedError(2,1)+semSignedError(2,1)].*(180/pi),'k','LineWidth',lineWidth)
            plot([1.6 1.6],[-meanSignedError(2,2)-semSignedError(2,2) -meanSignedError(2,2)+semSignedError(2,2)].*(180/pi),'k','LineWidth',lineWidth)
            plot([0.7 0.7],[-meanSignedError(2,3)-semSignedError(2,3) -meanSignedError(2,3)+semSignedError(2,3)].*(180/pi),'k','LineWidth',lineWidth)
        end
        
    end
    
else % viewing eccentricity data
    
    bar(2.2,(-meanSignedError(1,1))*(180/pi), barWidth, 'FaceColor',ColorIt(1),'LineWidth',lineWidth)
    bar(1.3,(-meanSignedError(2,1))*(180/pi), barWidth, 'FaceColor',ColorIt(2),'LineWidth',lineWidth)

end

fontSize = 22;
set(gca,'FontSize',fontSize);

grid off;
box on;

axis([0 2.9 -10 45])

axis square;

set(gca,'LineWidth',1.5)
set(gca,'ytick', [-10:10:40],'yticklabel', -[-10:10:40],'yaxislocation','right')
set(gca,'xtick',[])
set(gca,'xticklabel','');

set(gcf,'Color','w');

ylabel('Mean signed error (deg)', 'FontSize', fontSize)