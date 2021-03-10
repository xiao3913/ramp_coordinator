function [tu_interval, tl_interval, upper_bound, lower_bound, reach_case] = reachable_set(Dist, a_max, a_min, v_max, v_0, t_max)
AreaL = v_0^2/(2*a_min);
AreaR = v_max^2/(2*a_max);
AreaQ = v_max^2/(2*a_min);
AreaU = (v_max^2-v_0^2)/(2*a_max);

td1 = (v_0 - sqrt(v_0^2 - 2*a_min*Dist))/a_min;
td2 = (-v_0 + sqrt(v_0^2 + 2*a_max*Dist))/a_max;
td3 = v_0/a_min + v_max/a_max - sqrt((a_min + a_max)/(a_min^2*a_max^2)*(a_max*v_0^2 + a_min*v_max^2 - 2*a_min*a_max*Dist));
td5 = v_0/a_min + sqrt((2*a_min*Dist-v_0^2)/(a_min*a_max));

tu1 = (1/a_min + 1/a_max)*v_max - v_0/a_max - sqrt(((a_min+a_max)*v_max^2 - a_min*v_0^2 - 2*a_min*a_max*Dist)/(a_min^2*a_max));
tu2 = ((v_max - v_0)^2 + 2*a_max*Dist)/(2*a_max*v_max);
tu4 = -v_0/a_max + sqrt(((a_min+a_max)/(a_min*a_max^2))*(v_0^2 + 2*a_max*Dist));
tu5 = (1/a_min + 1/a_max)*(v_max/2) - v_0/a_max + (v_0^2+2*a_max*Dist)/(2*a_max*v_max);

hd1 = @(t) v_0 - a_min*t + sqrt((a_min+a_max)*(a_min*t.^2-2*v_0*t+2*Dist));
hd2 = @(t) sqrt((a_max/a_min)*(2*a_min*Dist - v_0^2))*t.^0;

gu1 = @(t) v_0 + a_max*t - sqrt((a_min + a_max)*(a_max*t.^2 + 2*v_0*t - 2*Dist));
gu2 = @(t) v_max - sqrt((a_min/a_max)*(2*a_max*v_max*t - (v_max - v_0)^2 - 2*a_max*Dist));

v_m = @(t) v_max*t.^0;
z_l = @(t) 0*t;
if Dist <= AreaL && Dist <= AreaU
    reach_case = 1;
    tu_interval{1} = [td2 td1];
    upper_bound{1} = hd1;    
    tl_interval{1} = [td2 td1];
    lower_bound{1} = gu1;
elseif Dist <= AreaL && Dist >= AreaU
    reach_case = 2;
    tu_interval{1} = [tu2 td3];
    tu_interval{2} = [td3 td1];
    upper_bound{1} = v_m;
    upper_bound{2} = hd1;           
    tl_interval{1} = [tu2 tu1];
    tl_interval{2} = [tu1 td1];
    lower_bound{1} = gu2;
    lower_bound{2} = gu1; 
elseif Dist >= AreaL && Dist <= AreaU
    reach_case = 3;
    tu_interval{1} = [td2 td5];
    tu_interval{2} = [td5 t_max];
    upper_bound{1} = hd1;
    upper_bound{2} = hd2;
    tl_interval{1} = [td2 tu4];
    tl_interval{2} = [tu4 t_max];
    lower_bound{1} = gu1;
    lower_bound{2} = z_l;
elseif Dist >= max(AreaL, AreaU) && Dist <= min(AreaL+AreaR, AreaU+AreaQ)
    reach_case = 4;
    tu_interval{1} = [tu2 td3];
    tu_interval{2} = [td3 td5];
    tu_interval{3} = [td5 t_max];
    upper_bound{1} = v_m;
    upper_bound{2} = hd1;
    upper_bound{3} = hd2;    
    tl_interval{1} = [tu2 tu1];
    tl_interval{2} = [tu1 tu4];
    tl_interval{3} = [tu4 t_max];
    lower_bound{1} = gu2;
    lower_bound{2} = gu1;
    lower_bound{3} = z_l; 
elseif Dist >= AreaL+AreaR && Dist <= AreaU+AreaQ
    reach_case = 5;
    tu_interval{1} = [tu2 t_max];
    upper_bound{1} = v_m;    
    tl_interval{1} = [tu2 tu1];
    tl_interval{2} = [tu1 tu4];
    tl_interval{3} = [tu4 t_max];
    lower_bound{1} = gu2;
    lower_bound{2} = gu1;
    lower_bound{3} = z_l;
elseif Dist <= AreaL+AreaR && Dist >= AreaU+AreaQ
    reach_case = 6;
    tu_interval{1} = [tu2 td3];
    tu_interval{2} = [td3 td5];
    tu_interval{3} = [td5 t_max];
    upper_bound{1} = v_m;
    upper_bound{2} = hd1;
    upper_bound{3} = hd2;    
    tl_interval{1} = [tu2 tu5];
    tl_interval{2} = [tu5 t_max]; 
    lower_bound{1} = gu2;
    lower_bound{2} = z_l;
elseif Dist >= max(AreaL+AreaR, AreaU+AreaQ)
    reach_case = 7;
    tu_interval{1} = [tu2 t_max];
    upper_bound{1} = v_m;
    tl_interval{1} = [tu2 tu5];
    tl_interval{2} = [tu5 t_max];
    lower_bound{1} = gu2;
    lower_bound{2} = z_l;
end
end