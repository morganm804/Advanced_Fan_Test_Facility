function [T2_5L_F, T7L_F, T5L_F, T6L_F, Pb_mbar, T0_F, Tdew_F, Rh_percent, pb] = processSensorInput(T2_5aL_F, T2_5bL_F, T2_5cL_F, T7aL_F, T7bL_F, T7cL_F, T5aL_F, T5bL_F, T5cL_F, T6aL_F, T6bL_F, T6cL_F, Pba_mbar, Pbb_mbar, Pbc_mbar, T0a_F, T0b_F, T0c_F, Tdewa_F, Tdewb_F, Tdewc_F, Rha_percent, Rhb_percent, Rhc_percent, n)
    %Removes outliers and averages remaining values uisng rmoutliersandaverage.m for multiple sensors of
    %same data reading
   
    T2_5L_F = [n];
    for i=1:n
        T2_5L_F(i) = rmoutliersandaverage([T2_5aL_F(i), T2_5bL_F(i), T2_5cL_F(i)]);
    end 
    T7L_F = [n];
    for i=1:n
        T7L_F(i) = rmoutliersandaverage([T7aL_F(i), T7bL_F(i), T7cL_F(i)]);
    end 

    T5L_F = [n];
    for i=1:n
        T5L_F(i) = rmoutliersandaverage([T5aL_F(i), T5bL_F(i), T5cL_F(i)]);
    end 

    T6L_F = [n];
    for i=1:n
        T6L_F(i) = rmoutliersandaverage([T6aL_F(i), T6bL_F(i), T6cL_F(i)]);
    end 

    Pb_mbar = [n];
    for i=1:n
        Pb_mbar(i) = rmoutliersandaverage([Pba_mbar(i), Pbb_mbar(i), Pbc_mbar(i)]);
    end 

    T0_F = [n];
    for i=1:n
        T0_F(i) = rmoutliersandaverage([T0a_F(i), T0b_F(i), T0c_F(i)]);
    end 

    Tdew_F = [n];
    for i=1:n
        Tdew_F(i) = rmoutliersandaverage([Tdewa_F(i), Tdewb_F(i), Tdewc_F(i)]);
    end 

    Rh_percent = [n];
    for i=1:n
        Rh_percent(i) = rmoutliersandaverage([Rha_percent(i), Rhb_percent(i),Rhc_percent(i)]);
    end

    pb = [n];
    for i=1:n
      pb(i) = abs(rmoutliersandaverage([Pba_mbar(i), Pbb_mbar(i), Pbc_mbar(i)]))/ 68.948;
    end

end