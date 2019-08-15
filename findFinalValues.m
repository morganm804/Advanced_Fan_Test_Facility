%Created by Morgan McNulty, SEAP, 7-15-2019

function [Q, P, Q5] = findFinalValues(T2_5aL_F, T2_5bL_F, T2_5cL_F, T7aL_F, T7bL_F, T7cL_F, Trtd7L_F, T5aL_F, T5bL_F, T5cL_F, Trtd5L_F, T6aL_F, T6bL_F, T6cL_F, Trtd6L_F, Pba_mbar, Pbb_mbar, Pbc_mbar, Ps0_wg, T0a_F, T0b_F, T0c_F, Tdewa_F, Tdewb_F, Tdewc_F, Rha_percent, Rhb_percent, Rhc_percent, D5, D6, a, b, Ps7L_wg, Ps6L_wg, Ps5L_wg, Ps2L_wg, deltaPs5_6L_wg, n, LD)

    
   [T2_5L_F, T7L_F, T5L_F, T6L_F, Pb_mbar, T0_F, Tdew_F, Rh_percent, pb] = processSensorInput(T2_5aL_F, T2_5bL_F, T2_5cL_F, T7aL_F, T7bL_F, T7cL_F, T5aL_F, T5bL_F, T5cL_F, T6aL_F, T6bL_F, T6cL_F, Pba_mbar, Pbb_mbar, Pbc_mbar, T0a_F, T0b_F, T0c_F, Tdewa_F, Tdewb_F, Tdewc_F, Rha_percent, Rhb_percent, Rhc_percent, n);

   %test set up
     D5 = D5/12; %convert to feet
     D6 = D6/12; %convert to feet
     a = a/12; %convert to feet
     b = b/12; %convert to feet
     D2 = (2*a*b)/(a+b); %calculates hydraulic diameter of rectangular inlet eq. 7.32
    
  %Energy factor eq. 7.16
  E = 1;
  
  %create empty arrays with pre defined length of final values to be
  %calculated
  Q5 = [n];
  Q = [n];
  P = [n];
  %If calcualtions for adjusted Q and P are incorporated, replace the
  %function calls to findQ and findP with new functions for adjusted
  %values.
  %To add new reported values, add newVar(i) = calcNewVar(parameters...);
  %list of functions in for loop
  for i=1:n
      Q5(i, 1) = calcQ5(T0_F(i), T5L_F(i), T6L_F(i), Tdew_F(i), Ps5L_wg(i), pb(i), abs(deltaPs5_6L_wg(i)), D6, D5, E, LD);
      Q(i, 1)= calcQ(T0_F(i), T5L_F(i), T6L_F(i), Tdew_F(i), Ps5L_wg(i), pb(i), abs(deltaPs5_6L_wg(i)), D6, D5, E, LD);
      P(i, 1) = calcPs(T0_F(i), T5L_F(i), T6L_F(i), T2_5L_F(i), Tdew_F(i), Ps7L_wg(i), Ps5L_wg(i), Ps2L_wg(i), pb(i), abs(deltaPs5_6L_wg(i)), D2, D6, D5, E, LD);
  end
end