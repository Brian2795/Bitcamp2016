MALong= 50;
MAShort= 10;
reach= 60;


stock= 'COST';
date= '4/8/2015';
diff1= EMA_Anal(stock,MAShort, MALong, reach, date);

stock= 'LNKD';
date= '2/22/2016';
diff2= EMA_Anal(stock,MAShort, MALong, reach, date);

stock= 'TSLA';
date= '2/8/2016';
diff3= EMA_Anal(stock,MAShort, MALong, reach, date);

stock= 'TWTR';
date= '3/8/2016';
diff4= EMA_Anal(stock,MAShort, MALong, reach, date);


%COST, LNKD, TSLA, TWTR

%COST Positive
diff1= -diff1;
cross1= zeros(reach,1);
for i= 1:reach
    if i < 60
       if diff1(i)*diff1(i+1) < 0
         cross1(i+1) = 1;
       end
    end
    if diff1(i) < 0
        diff1(i)= 0;
    end
    diff1(i)= sqrt(diff1(i));
end


%LNKD Crossover to Negative
diff2= -diff2;
cross2= zeros(reach,1);
for i= 1:reach
    if i < 60
       if diff2(i)*diff2(i+1) < 0
         cross2(i+1) = 1;
       end
    end
    if diff2(i) < 0
        diff2(i)= 0;
    end
    diff2(i)= sqrt(diff2(i));
end

%TSLA Multiple Crossovers
diff3= -diff3;
cross3= zeros(reach,1);
for i= 1:reach
    if i < 60
       if diff3(i)*diff3(i+1) < 0
        cross3(i+1) = 1;
       end
    end
    if diff3(i) < 0
        diff3(i)= 0;
    end
    diff3(i)= sqrt(diff3(i));
end


%TWTR Negative
diff4= -diff4;
cross4= zeros(reach,1);
for i= 1:reach
    if i < 60
       if diff4(i)*diff4(i+1) < 0
        cross4(i+1) = 1;
       end
    end
    if diff4(i) < 0
        diff4(i)= 0;
    end
    diff4(i)= sqrt(diff4(i));
end

echo1= zeros(reach,1);
for i= 2:reach
    echo1(i)= echo1(i-1)+cross1(i);
    if i>12
        echo1(i)= echo1(i)- cross1(i-12);
    end
end

echo2= zeros(reach,1);
for i= 2:reach
    echo2(i)= echo2(i-1)+cross2(i);
    if i>12
        echo2(i)= echo2(i)- cross2(i-12);
    end
end

echo3= zeros(reach,1);
for i= 2:reach
    echo3(i)= echo3(i-1)+cross3(i);
    if i>12
        echo3(i)= echo3(i)- cross3(i-12);
    end
end

echo4= zeros(reach,1);
for i= 2:reach
    echo4(i)= echo4(i-1)+cross4(i);
    if i>12
        echo4(i)= echo4(i)- cross4(i-12);
    end
end