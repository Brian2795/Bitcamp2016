function [adj_diff, yaxis] = EMA_Anal(stock, MAShort, MALong, reach, date)
    % String stock => stock symbol
    % int MAShort => short moving average duration
    % int MALong => long moving average duration
    % int reach => # market days observed
    % String date => final date of interest
    % int[] diff => array of moving average differences over time
    
    c= yahoo;
    format long g
    span= 1.4*(3*MALong+reach); %estimated span for 100 market days
    span= 7*(ceil((span/7)))-3; %adjusted to guarantee Monday start date
    multLong= 2/(1+MALong); %multiplier to calculate the long EMA
    multShort= 2/(1+MAShort); %multiplier to calculate the short EMA

    curr= fetch(c, stock, date);
    date_f= curr(1); % final date
    date_i= date_f-span; % initial date
    data_temp= fetch(c,stock,'close',date_f,date_i);
    data= flipud(data_temp(:,2));
    len= size(data);
    len1= len(1); %length of full dataset

    % Generate initial simple moving average of 10day and 100day
    sum_L= sum(data(1:MALong));
    sum_S= sum(data(MALong-MAShort+1:MALong));
    avg_L= sum_L/MALong;
    avg_S= sum_S/MAShort;
    
    % Generate initial values for exponential moving averages
    len2= len1-MALong; %size of all EMA dataset
    ema_L= zeros(len2,1);
    ema_S= zeros(len2,1);
    ema_L(1)= multLong*(data(MALong+1)-avg_L)+avg_L;
    ema_S(1)= multShort*(data(MALong+1)-avg_S)+avg_S;
    
    for i= 2:len2
        prev_L= ema_L(i-1);
        prev_S= ema_S(i-1);
        ema_L(i)= multLong*(data(MALong+i)-prev_L)+prev_L;
        ema_S(i)= multShort*(data(MALong+i)-prev_S)+prev_S;
    end
    
    
    %plot EMAs side by side
    figure
    hold on
    title1= sprintf('Long and Short EMAs Over %d Days (%s)',reach,stock);
    title(title1)
    xlabel('Day')
    ylabel('Exponential Moving Averages ($)')
    plot(1:reach, data(len1-reach+1:len1))
    plot(1:reach, ema_L(len2-reach+1:len2))
    plot(1:reach, ema_S(len2-reach+1:len2))
    %for use in app
    yaxis = [data(len1-reach+1:len1), ema_L(len2-reach+1:len2), ema_S(len2-reach+1:len2)];
    legend1= sprintf('%d-Day Moving Average',MALong); 
    legend2= sprintf('%d-Day Moving Average',MAShort);
    legend('Daily Close',legend1,legend2);
    grid on
    hold off
% 
% 
      diff= ema_S(len2-reach+1:len2)-ema_L(len2-reach+1:len2);
%     
%     %plot difference
%     figure
%     plot(1:reach, diff)
%     title2= sprintf('%d-Day/%d-Day EMA Diff (%s)',MAShort,MALong,stock);
%     title(title2)
%     xlabel('Day')
%     ylabel('Moving Avg Difference ($)')
%     grid on
      adj_diff= 100.*diff./data(len2-reach+1:len2);
end