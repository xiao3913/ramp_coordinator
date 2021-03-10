function [pos, vel, time] = initialize_vehicle(num, v_max, a_max, CR_length, tau)
    vel = zeros(num,1);
    pos = zeros(num,1);
    time = zeros(num,1);
    for i = 1:num
        vel(i) = (v_max-5) + 5*rand;
        pos(i) = CR_length*rand;
        while min(abs(pos(1:end ~= i) - pos(i))) <= tau*vel(i)
            pos(i) = CR_length*rand;
        end
        dist_to_CR = CR_length - pos(i);
        dist_to_vmax = (v_max^2-vel(i)^2)/(2*a_max);
        if dist_to_CR > dist_to_vmax
            time(i) = (v_max-vel(i))/a_max + (dist_to_CR-dist_to_vmax)/v_max;
        else
            time(i) = (sqrt(vel(i)^2+2*dist_to_CR*a_max)-vel(i))/a_max;
        end
    end
    [pos, ind] = sort(pos,'descend');
    vel = vel(ind);
    time = time(ind);    
end