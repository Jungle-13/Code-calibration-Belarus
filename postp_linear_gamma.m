% Plot results

clearvars
close all
clc

obj_fun_type  = 'sym';
gamma_Q_diff  = 'no';

%==========================================================================
% COMPARE CONSTANT AND LINEARLY VARYING PARTIAL FACTOR, GAMMA_Q
%==========================================================================
%--------------------------------------------------------------------------
% CONSTANT GAMMA_Q 
%--------------------------------------------------------------------------
% load data
gamma_Q_type  = 'constant';

load(['results\obj_fun.',obj_fun_type,...
    '_gamma_Q_type.',gamma_Q_type,...
    '_gamma_Q_diff.',gamma_Q_diff,...
    '_load_combi.simple_t_ref.50_beta_t.2.3_limit_state.1_lead_action.1  2  3.mat'])

Results    = filter_Results(Results);
Results1    = select_Results(Model, Results, 0);  % WARNING!
plot_reli_vs_loadratio(Model, Results1)

ha1     = gca;
ylim1   = get(ha1, 'Ylim');
hf1     = gcf;
hf      = get(gcf,'Children');
hl      = hf(1);
hl.Visible  = 'off';
disp('=====================================================================')
%--------------------------------------------------------------------------
% LINEAR GAMMA_Q 
%--------------------------------------------------------------------------
% load data
gamma_Q_type  = 'linear';

load(['results\obj_fun.',obj_fun_type,...
    '_gamma_Q_type.',gamma_Q_type,...
    '_gamma_Q_diff.',gamma_Q_diff,...
    '_load_combi.simple_t_ref.50_beta_t.2.3_limit_state.1_lead_action.1  2  3.mat'])

Results    = filter_Results(Results);
Results2    = select_Results(Model, Results, 0);  % WARNING!
plot_reli_vs_loadratio(Model, Results2)

hf2     = gcf;
ha2     = gca;
ylim2   = get(ha2, 'Ylim');
ylimm   = [min(ylim1(1), ylim2(1)), max(ylim1(2), ylim2(2))];
set(ha1,'Ylim',ylimm)
set(ha2,'Ylim',ylimm)

% Objective function value
tx = min(xlim) + 0.05*diff(xlim);
ty = max(ylim) - 0.10*diff(ylim);

figure(hf1)
text(tx, ty, ['$O_\mathrm{',obj_fun_type,'}=', sprintf('%4.2f', Results1.obj_fun_val), '$'], 'Interpreter', 'LaTeX')
figure(hf2)
text(tx, ty, ['$O_\mathrm{',obj_fun_type,'}=', sprintf('%4.2f', Results2.obj_fun_val), '$'], 'Interpreter', 'LaTeX')

%--------------------------------------------------------------------------
% COMPARE required characteristic resistances!
%--------------------------------------------------------------------------
plot_rRk_vs_loadratio(Model, Results1, Results2)