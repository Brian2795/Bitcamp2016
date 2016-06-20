function y = stopaudio(obj, eventdata, player, figHandle, plotdata)
    % stop player after certain time
    if strcmp(player.Running, 'on')
        stop(player);
    end
    y = 0;
end
